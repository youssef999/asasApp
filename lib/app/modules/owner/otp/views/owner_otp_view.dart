import 'package:asas/app/helpers/dialog_utils.dart';
import 'package:asas/app/routes/app_pages.dart';
import 'package:asas/app/theme/lightColors.dart';
import 'package:asas/app/widgets/my_button.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../../translations/strings_enum.dart';
import '../controllers/owner_otp_controller.dart';

class OwnerOtpView extends GetView<OwnerOtpController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: constraints.copyWith(
                  minHeight: constraints.maxHeight,
                  maxHeight: double.maxFinite,
                  maxWidth: double.infinity,
                  minWidth: constraints.maxWidth),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            Strings.Confirm_phone_number.tr,
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                ?.copyWith(
                                    color: LightColors.TEXT_PRIMARY_COLOR),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            Strings.activation_code.tr,
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(
                                    color: LightColors.PRIMARY_COLOR,
                                    fontWeight: FontWeight.w300),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          PinFieldAutoFill(
                            decoration: BoxLooseDecoration(
                                strokeColorBuilder: PinListenColorBuilder(
                                    LightColors.ACCENT_COLOR,
                                    LightColors.EDIT_BORDER_COLOR),
                                bgColorBuilder: PinListenColorBuilder(LightColors.EDIT_BACKGROUND_COLOR, Colors.white)
                            ),
                            onCodeSubmitted: (code) {
                              print(code);
                            },
                            onCodeChanged: (code){
                              print(code);
                            },
                            cursor: Cursor(
                              width: 2,
                              color: Colors.lightBlue,
                              radius: Radius.circular(1),
                              enabled: true,
                            ),
                            autoFocus: true,
                            codeLength: 4,
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          MyButton(
                            title: Strings.Confirm_phone_number.tr,
                            onTap: () => DialogUtils.showOtpDoneDialog(context, ()=> Get.offAllNamed(Routes.OWNER_BASE_DRAWER)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
