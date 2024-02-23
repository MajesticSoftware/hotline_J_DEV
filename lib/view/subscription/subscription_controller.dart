import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hotlines/constant/shred_preference.dart';
import 'package:hotlines/utils/extension.dart';
import 'package:hotlines/view/sports/gameDetails/game_details_controller.dart';
import 'package:hotlines/view/widgets/common_widget.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import "package:in_app_purchase_android/in_app_purchase_android.dart";
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:intl/intl.dart';

import '../../../../../network/subscription_repo.dart';
import '../../constant/app_strings.dart';
import '../../model/response_item.dart';
import '../../model/user_model.dart';
import '../../theme/app_color.dart';
import '../../theme/helper.dart';
import '../auth/log_in_module/log_in_screen.dart';
import '../widgets/common_dialog.dart';

/// IOS SUBSCRIPTION ID
const iosMonthlySubscriptionID = "com.subscription.monthly";
// const iosYearlySubscriptionID = "com.subscription.yearly";
// const iosLifeTimeSubscriptionID = "com.subscription.lifetime.mama";

/// ANDROID SUBSCRIPTION ID
const androidMonthlySubscriptionID = "com.subscription.monthly";
// const androidYearlySubscriptionID = "com.subscription.yearly";
// const androidLifeTimeSubscriptionID = "com.subscription.lifetime.mama";

class SubscriptionController extends GetxController {
  bool isAutoRenewalSubscription =
      PreferenceManager.getAutoRenewalSub() ?? false;
  RxList<ProductDetails> products = <ProductDetails>[].obs;
  String monthlySubscription =
      Platform.isIOS ? iosMonthlySubscriptionID : androidMonthlySubscriptionID;

  // String yearlySubscription =
  //     Platform.isIOS ? iosYearlySubscriptionID : androidYearlySubscriptionID;
  // String lifeTimeSubscription = Platform.isIOS
  //     ? iosLifeTimeSubscriptionID
  //     : androidLifeTimeSubscriptionID;
  RxBool isLoading = false.obs;
  late StreamSubscription<List<PurchaseDetails>> subscription;
  final InAppPurchase inAppPurchase = InAppPurchase.instance;

  // int selectedIndex = -1;
  bool isStepController18 = false;

  String subscriptionPrice = "";
  String subscriptionTime = "";
  String subscriptionStart = "";
  String subscriptionEnd = "";
  String subscriptionId = "";

  @override
  void onInit() {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        inAppPurchase.purchaseStream;
    subscription = purchaseUpdated.listen((purchaseDetailList) async {
      // if (PreferenceManager.getSubscriptionProduct() !=
      //     lifeTimeSubscription) {
      await listenToPurchaseUpdated(purchaseDetailList);
      // }
    }, onDone: () {
      subscription.cancel();
    }, onError: (error) {
      log('$error', name: "Subscription Error");
    });
    initStoreInfo();
    super.onInit();
  }

  restorePurchase(BuildContext context) async {
    Get.back();
    if (PreferenceManager.getIsLogin() ?? false) {
      isLoading.value = true;
      try {
        await inAppPurchase.restorePurchases();
      } catch (e) {
        isLoading.value = false;
      }

      isLoading.value = false;
      update();
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return exitApp(
            context,
            buttonText: 'Login',
            cancelText: 'Cancel',
            title: 'Error',
            subtitle: 'You have to login for Subscription!',
            onTap: () {
              Get.offAll(LogInScreen());
            },
          );
        },
      );
    }
    isLoading.value = false;
  }

  Future<void> getSubscriptionStatus() async {
    isLoading.value = true;
    ResponseItem result = Platform.isIOS
        ? await SubscriptionRepo.getReceiptStatus()
        : await SubscriptionRepo.getGoogleCloudStatus();
    try {
      if (result.status) {
        UserData subscriptionModel = UserData.fromJson(result.data);
        PreferenceManager().saveSubscription(subscriptionModel);
        update();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    isLoading.value = false;
    update();
  }

  Future buyProduct(ProductDetails prod) async {
    try {
      isLoading.value = true;
      late PurchaseParam purchaseParam;
      if (Platform.isAndroid) {
        purchaseParam = GooglePlayPurchaseParam(productDetails: prod);
        await inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
      } else {
        purchaseParam = PurchaseParam(productDetails: prod);
        final paymentWrapper = SKPaymentQueueWrapper();
        var transactions = await paymentWrapper.transactions();
        for (var skPaymentTransactionWrapper in transactions) {
          await paymentWrapper.finishTransaction(skPaymentTransactionWrapper);
        }
        await inAppPurchase.buyNonConsumable(
            purchaseParam: PurchaseParam(productDetails: prod));

        isLoading.value = false;
        update();
      }
    } catch (e) {
      log('SUBSCRIPTION ERROR--$e');
      isLoading.value = false;
    }
    update();
  }

  Future<void> listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailList) async {
    try {
      for (var purchaseDetails in purchaseDetailList) {
        if (purchaseDetails.status == PurchaseStatus.pending) {
          isLoading.value = true;
        } else {
          if (purchaseDetails.status == PurchaseStatus.error ||
              purchaseDetails.status == PurchaseStatus.canceled) {
            isLoading.value = false;
            if (purchaseDetails.error != null) {
              log('${purchaseDetails.error!}', name: 'IAPError');
            }
          } else if (purchaseDetails.status == PurchaseStatus.purchased ||
              purchaseDetails.status == PurchaseStatus.restored) {
            final isValid = await _verifyPurchase(purchaseDetails);
            if (isValid) {
              if (Platform.isAndroid) {
                updateGoogleCloudStatus(
                    purchaseDetails as GooglePlayPurchaseDetails);

                break;
              } else if (Platform.isIOS) {
                verifyReceipt(
                    purchaseDetails.verificationData.localVerificationData);

                break;
              }
            }
          }
          if (purchaseDetails.pendingCompletePurchase) {
            await inAppPurchase.completePurchase(purchaseDetails);
          }
        }
      }
    } catch (e) {
      log("Subscription Listen error is ---> $e");
    }
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
    bool isVerify = false;
    if (purchaseDetails.productID ==
            monthlySubscription /*||
        purchaseDetails.productID == yearlySubscription ||
        purchaseDetails.productID == lifeTimeSubscription*/
        ) {
      isVerify = true;
      update();
    } else {
      isVerify = false;
      update();
    }
    return Future<bool>.value(isVerify);
  }

  changeAutoRenewalSubscription(bool newValue) {}
String price='30 days free trial';
  Future<void> initStoreInfo() async {
    isLoading.value = true;
    products.clear();
    final bool available = await inAppPurchase.isAvailable();
    if (!available) {
      products.value = <ProductDetails>[];
      isLoading.value = false;
      return;
    }

    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
          inAppPurchase
              .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
    }

    List<String> kProductIds = [
      monthlySubscription,
      // yearlySubscription,
      // lifeTimeSubscription
    ];
    final ProductDetailsResponse productDetailResponse =
        await inAppPurchase.queryProductDetails(kProductIds.toSet());

    if (productDetailResponse.error != null) {
      log(productDetailResponse.error!.message, name: 'IAPError');
      products.value = productDetailResponse.productDetails;
      isLoading.value = false;
      return;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      products.value = productDetailResponse.productDetails;
      isLoading.value = false;
      return;
    }

    for (var id in kProductIds) {
      products.add(productDetailResponse.productDetails.firstWhere((element) {
        return element.id == id;
      }));
    }
    log("Product List Length ------> ${products.length}");
    for (var element in products) {
      price=element.price;
      log("Product Price ------> ${element.price}");
    }
    isLoading.value = false;

    return;
  }

  Future<void> updateGoogleCloudStatus(
      GooglePlayPurchaseDetails purchaseDetails) async {
    isLoading.value = true;
    String packageName = purchaseDetails.billingClientPurchase.packageName;
    String productId = purchaseDetails.productID;
    String purchaseToken = purchaseDetails.billingClientPurchase.purchaseToken;
    ResponseItem result = await SubscriptionRepo.manageGooglePurchase(
        packageName, productId, purchaseToken);
    try {
      if (result.status) {
        UserData subscriptionModel = UserData.fromJson(result.data);
        PreferenceManager.setSubscriptionActive(
            subscriptionModel.isSubscriptionActivated ?? "0");
        PreferenceManager().saveSubscription(subscriptionModel);
        // showCompletePurchaseDialog();
        Get.find<GameDetailsController>().update();
        await getSubscriptionProduct();
        update();
        isLoading.value = false;
      } else {
        isLoading.value = false;
        showAppSnackBar(result.message);
      }
    } catch (e) {
      isLoading.value = false;
      showAppSnackBar(result.message);
    }
    isLoading.value = false;
    update();
  }

  Future<void> verifyReceipt(String receiptUrl) async {
    isLoading.value = true;
    ResponseItem result = await SubscriptionRepo.verifyReceipt(receiptUrl);
    try {
      if (result.status) {
        if (result.data != null) {
          UserData subscriptionModel = UserData.fromJson(result.data);
          PreferenceManager().saveSubscription(subscriptionModel);
          PreferenceManager.setSubscriptionActive(
              subscriptionModel.isSubscriptionActivated ?? "0");
          // showCompletePurchaseDialog();
          Get.find<GameDetailsController>().update();
          await getSubscriptionProduct();
          isLoading.value = false;
          update();
        }
      } else {
        showAppSnackBar(result.message);
      }
    } catch (e) {
      isLoading.value = false;
      showAppSnackBar(errorText);
      update();
    }
    isLoading.value = false;
  }

  Future<void> restoreProduct() async {
    isLoading.value = true;
    await inAppPurchase.restorePurchases();
    isLoading.value = false;
    update();
  }

  getSubscriptionProduct() {
    subscriptionId = PreferenceManager.getSubscriptionProduct() ?? "";
    String subscriptionProduct =
        PreferenceManager.getSubscriptionProduct() ?? "";
    subscriptionPrice = subscriptionProduct == monthlySubscription
        ? price
        : /*subscriptionProduct == yearlySubscription
            ? "\$24.99"
            : subscriptionProduct == lifeTimeSubscription
                ? "\$99.99"
                :*/
        "";
    subscriptionTime = subscriptionProduct == monthlySubscription
        ? "monthly"
        : /*subscriptionProduct == yearlySubscription
            ? "yearly"
            : subscriptionProduct == lifeTimeSubscription
                ? "lifetime"
                :*/
        "";

    DateTime subscriptionStartTime = DateTime.fromMillisecondsSinceEpoch(
        int.parse(PreferenceManager.getSubscriptionStartDate() ?? ""));
    log("subscriptionStartTime --> $subscriptionStartTime");
    subscriptionStart =
        DateFormat("MMMM dd, yyyy").format(subscriptionStartTime);

    DateTime subscriptionEndTime = DateTime.fromMillisecondsSinceEpoch(
        int.parse(PreferenceManager.getSubscriptionEndDate()));
    subscriptionEnd = DateFormat("MMMM dd, yyyy").format(subscriptionEndTime);
    update();
  }

  @override
  void onClose() {
    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
          inAppPurchase
              .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      iosPlatformAddition.setDelegate(null);
    }
    subscription.cancel();
    // TODO: implement onClose
    super.onClose();
  }

  showCompletePurchaseDialog() {
    return showDialog(
        context: Get.context!,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            content: ("Subscription purchase completed.")
                .appCommonText(
                    size: 18.h,
                    color: Theme.of(context).secondaryHeaderColor,
                    weight: FontWeight.w700)
                .paddingOnly(top: 10),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              CommonAppButton(
                onTap: () {
                  Get.back();
                  Get.find<GameDetailsController>().update();
                },
                title: "Ok",
                buttonColor: Theme.of(context).secondaryHeaderColor,
                textColor: whiteColor,
              )
            ],
          );
        });
  }
}

class ExamplePaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(
      SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
    return true;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
  }
}
