import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hotlines/constant/shred_preference.dart';
import 'package:hotlines/utils/extension.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:intl/intl.dart';
import '../../../../../network/subscription_repo.dart';
import '../../constant/app_strings.dart';
import '../../model/response_item.dart';
import '../../model/user_model.dart';
import '../../theme/app_color.dart';
import '../../theme/helper.dart';

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

  int selectedIndex = -1;
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

  buyProduct(ProductDetails prod) async {
    try {
      isLoading.value = true;
      late PurchaseParam purchaseParam;
      if (Platform.isAndroid) {
        purchaseParam = GooglePlayPurchaseParam(productDetails: prod);
        if (selectedIndex == 2) {
          await inAppPurchase.buyConsumable(purchaseParam: purchaseParam);
        } else {
          await inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
        }
      } else {
        purchaseParam = PurchaseParam(productDetails: prod);
        var transactions = await SKPaymentQueueWrapper().transactions();
        for (var skPaymentTransactionWrapper in transactions) {
          SKPaymentQueueWrapper()
              .finishTransaction(skPaymentTransactionWrapper);
        }
        if (selectedIndex == 2) {
          await inAppPurchase.buyConsumable(purchaseParam: purchaseParam);
        } else {
          await inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
        }
        isLoading.value = false;
        update();
      }
    } catch (e) {
      isLoading.value = false;
    }
    update();
    // }
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
      print("Subscription Listen error is ---> $e");
    }
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
    bool isVerify = false;
    if (purchaseDetails.productID == monthlySubscription /*||
        purchaseDetails.productID == yearlySubscription ||
        purchaseDetails.productID == lifeTimeSubscription*/) {
      isVerify = true;
      update();
    } else {
      isVerify = false;
      update();
    }
    return Future<bool>.value(isVerify);
  }

  changeAutoRenewalSubscription(bool newValue) {}


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
    print("Product List Length ------> ${products.length}");
    products.forEach((element) {
      print("Product Price ------> ${element.price}");
    });
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
        PreferenceManager().saveSubscription(subscriptionModel);
        showCompletePurchaseDialog();
        await getSubscriptionProduct();
        update();
        isLoading.value = false;
      } else {
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
          showCompletePurchaseDialog();
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
    subscriptionId =PreferenceManager.getSubscriptionProduct() ?? "";
    String subscriptionProduct =
        PreferenceManager.getSubscriptionProduct() ?? "";
    subscriptionPrice = subscriptionProduct == monthlySubscription
        ? "\$6.99/mo"
        : /*subscriptionProduct == yearlySubscription
            ? "\$24.99"
            : subscriptionProduct == lifeTimeSubscription
                ? "\$99.99"
                :*/ "";
    subscriptionTime = subscriptionProduct == monthlySubscription
        ? "monthly"
        : /*subscriptionProduct == yearlySubscription
            ? "yearly"
            : subscriptionProduct == lifeTimeSubscription
                ? "lifetime"
                :*/ "";

    DateTime subscriptionStartTime = DateTime.fromMillisecondsSinceEpoch(
        int.parse(
           PreferenceManager.getSubscriptionStartDate() ??
                ""));
    print("subscriptionStartTime --> $subscriptionStartTime");
    subscriptionStart =
        DateFormat("MMMM dd, yyyy").format(subscriptionStartTime);

    DateTime subscriptionEndTime = DateTime.fromMillisecondsSinceEpoch(
        int.parse(
            PreferenceManager.getSubscriptionEndDate()));
    subscriptionEnd = DateFormat("MMMM dd, yyyy").format(subscriptionEndTime);
    update();
  }

/*Future<void> _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailList) async {
    for (var purchaseDetails in purchaseDetailList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        isLoading.value = true;
      } else {
        if (purchaseDetails.status == PurchaseStatus.error ||
            purchaseDetails.status == PurchaseStatus.canceled) {
          isLoading.value = false;
          if (purchaseDetails.error != null) {
            showAppSnackBar("Purchase error please try after some time", false);
            log('${purchaseDetails.error!}', name: 'IAPError');
          }
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          isLoading.value = false;
          if (purchaseDetails.pendingCompletePurchase) {
            inAppPurchase.completePurchase(purchaseDetails);
          }
          if (Platform.isAndroid) {
            getGoogleCloudStatus(purchaseDetails as GooglePlayPurchaseDetails);
            break;
          } else if (Platform.isIOS) {
            verifyReceipt(
                purchaseDetails.verificationData.localVerificationData);
            break;
          }
        }
      }
    }
  }*/

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
                .appCommonText(size: 16.h,color: Theme.of(context).secondaryHeaderColor,weight: FontWeight.w600)
                .paddingOnly(top: 10),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Theme.of(context).secondaryHeaderColor),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: "Ok".appCommonText(
                          color: whiteColor,
                          weight: FontWeight.w700,
                          size: 18),
                    )),
              ),
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

alreadyPurchaseDialog() {
  return showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: ("Already Purchased"). appCommonText(size: 16.h,color: Theme.of(context).secondaryHeaderColor).paddingOnly(top: 10),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: "Ok". appCommonText(size: 16.h,color: Theme.of(context).secondaryHeaderColor))
          ],
        );
      });
}

/*  Future<void> getSubscriptionStatus(
      GooglePlayPurchaseDetails purchaseDetails, int credit) async {
    isLoading.value = true;
    String packageName = purchaseDetails.billingClientPurchase.packageName;
    String productId = purchaseDetails.productID;
    String purchaseToken = purchaseDetails.billingClientPurchase.purchaseToken;

    ResponseItem result = await SubscriptionRepo.getGoogleCloudStatus(
        packageName, productId, purchaseToken);
    isLoading.value = false;
    try {
      if (result.status) {
        UserData subscriptionModel = UserData.fromJson(result.data);
        preferences.saveSubscription(subscriptionModel);
        isLoading.value = false;
      }
    } catch (e) {
      print("Error is -----> $e");
      showAppSnackBar(errorText);
    }
  }

  Future<void> getGoogleCloudStatusProduct(
      GooglePlayPurchaseDetails purchaseDetails, int credit) async {
    isLoading.value = true;
    String packageName = purchaseDetails.billingClientPurchase.packageName;
    String productId = purchaseDetails.productID;
    String purchaseToken = purchaseDetails.billingClientPurchase.purchaseToken;

    ResponseItem result = await SubscriptionRepo.getGoogleCloudStatusProduct(
        packageName, productId, purchaseToken, credit);
    isLoading.value = false;
    try {
      if (result.status) {
        UserData subscriptionModel = UserData.fromJson(result.data);
        preferences.saveSubscription(subscriptionModel);
        isLoading.value = false;
      }
    } catch (e) {
      print("Error is -----> $e");
      showAppSnackBar(errorText);
    }
  }*/
