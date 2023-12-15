import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    controller.loadApp();
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: SvgPicture.asset('assets/svg/splash_top_right.svg'),
          ),
          Center(
            child: Image.asset('assets/images/logo_app.png', height: 230),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: SvgPicture.asset('assets/svg/splash_bottom.svg', fit: BoxFit.fill),
          )
        ],
      )
    );
  }
}
