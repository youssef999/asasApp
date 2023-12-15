import 'package:asas/app/theme/lightColors.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../translations/strings_enum.dart';

class CustomLoading {
  // static final CustomLoading _singleton = CustomLoading._internal();
  //
  // factory CustomLoading() {
  //   return _singleton;
  // }
  //
  // CustomLoading._internal();

  static cancelLoading(){
    BotToast.closeAllLoading();
  }

  static showSuccessToast({required String msg}){
    BotToast.showSimpleNotification(
      title: msg,
      align: Alignment.bottomCenter,
      titleStyle: Get.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold, fontSize: 14.0, color: Colors.white),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.green,);
  }

  static showWrongToast({required String msg}){
    BotToast.showSimpleNotification(
      title: msg,
      align: Alignment.bottomCenter,
      titleStyle: Get.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold, fontSize: 14.0, color: Colors.white),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.redAccent,);
  }

  static showInfoToast({required String msg}){
    BotToast.showSimpleNotification(
      title: msg,
      align: Alignment.bottomCenter,
      hideCloseButton: true,
      titleStyle: Get.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold, fontSize: 14.0, color: LightColors.TEXT_WHITE_COLOR),
      duration: const Duration(seconds: 3),
      backgroundColor: LightColors.PRIMARY_COLOR,);
  }

  static showLoading({String? msg}){
    int backgroundColor = 0x42000000;
  //  int seconds = 10;
    bool clickClose = false;
    bool allowClick = false;
    bool ignoreContentClick = true;
  //  bool crossPage = true;
    int animationMilliseconds = 200;
    int animationReverseMilliseconds = 200;
    BackButtonBehavior backButtonBehavior = BackButtonBehavior.ignore;

    BotToast.showCustomLoading(
        clickClose: clickClose,
        allowClick: allowClick,
        backButtonBehavior: backButtonBehavior,
        ignoreContentClick: ignoreContentClick,
        animationDuration: Duration(milliseconds: animationMilliseconds),
        animationReverseDuration: Duration(milliseconds: animationReverseMilliseconds),
        // duration: Duration(
        //   seconds: seconds,
        // ),
        backgroundColor: Color(backgroundColor),
        align: Alignment.center,
        toastBuilder: (cancelFunc) {
          return _CustomLoadWidget(cancelFunc: cancelFunc, msg: msg,);
        });
  }

}


class _CustomLoadWidget extends StatefulWidget {
  final CancelFunc cancelFunc;
  final String? msg;

  const _CustomLoadWidget({ required this.cancelFunc, this.msg});

  @override
  __CustomLoadWidgetState createState() => __CustomLoadWidgetState();
}

class __CustomLoadWidgetState extends State<_CustomLoadWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));

    animationController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animationController.forward();
      }
    });
    animationController.forward();

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FadeTransition(
              opacity: animationController,
              child: Image.asset("assets/images/logo.png", height: 50,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.msg ?? Strings.wait_moment.tr,
              ),
            )
          ],
        ),
      ),
    );
  }
}


