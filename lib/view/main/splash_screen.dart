// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:hotlines/view/sports/gameListing/game_listing_screen.dart';
//
// import '../../extras/constants.dart';
// import '../../generated/assets.dart';
// import '../../theme/app_color.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     Timer(const Duration(seconds: 2), () {
//       Get.to(() => SelectGameScreen(),
//           transition: Transition.downToUp,
//           duration: const Duration(milliseconds: 900));
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backGroundColor,
//       body: mobileView.size.shortestSide < 600
//           ? Container(
//               height: Get.height,
//               width: Get.width,
//               color: appColor,
//               child: Padding(
//                 padding: const EdgeInsets.all(60),
//                 child: Center(
//                   child: SvgPicture.asset(Assets.imagesAppLogo),
//                 ),
//               ),
//             )
//           : SvgPicture.asset(
//               Assets.imagesSplashImage,
//               width: Get.width,
//               height: Get.height,
//               fit: BoxFit.cover,
//             ),
//     );
//   }
// }
