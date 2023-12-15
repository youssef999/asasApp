import 'package:asas/app/helpers/custom_loading.dart';
import 'package:asas/app/helpers/owner_shared_pref.dart';
import 'package:asas/app/routes/app_pages.dart';
import 'package:asas/app/theme/lightColors.dart';
import 'package:asas/app/widgets/booster.dart';
import 'package:asas/app/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../../../../translations/strings_enum.dart';
import '../controllers/owner_splash_controller.dart';

class OwnerSplashView extends GetView<OwnerSplashController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Booster.textSecondaryTitle(context, Strings.if_you.tr),
            Booster.verticalSpace(10),
            Item(title: Strings.Owner_of_an_educational_institution.tr,),
            Booster.verticalSpace(10),
            Item(title: Strings.Representative_educational_institution.tr,),
            Booster.verticalSpace(10),
            Item(title: Strings.educational_software_provider.tr,),
            Booster.verticalSpace(27),
            Container(
              height: 280,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: LightColors.PRIMARY_COLOR
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 75,
                    width: 75,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: LightColors.ACCENT_COLOR,
                      borderRadius: BorderRadius.circular(100)
                    ),
                    child: SvgPicture.asset('assets/svg/owner/shake_hands.svg'),
                  ),
                  Booster.verticalSpace(20),
                  Booster.textBody(context, Strings.add_your_organization.tr,
                      fontWeight: FontWeight.bold, color: Colors.white, textAlign: TextAlign.center)
                ],
              ),
            ),
            Booster.verticalSpace(40),
            Row(
              children: [
                Expanded(child: MyButton(title: Strings.tracking.tr, onTap: () {
                  OwnerSharedPref.setIntroShow(true);
                  Get.offAllNamed(Routes.OWNER_LOGIN);
                  CustomLoading.showInfoToast(msg: Strings.Transferred_owner_status.tr);
                })),
                Booster.horizontalSpace(7),
                Expanded(
                    child: MyButton(
                  title: Strings.back.tr,
                  onTap: () => Get.back(),
                  secondary: true,
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Item extends StatelessWidget {
  final String title ;
  const Item({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: LightColors.ACCENT_COLOR,
            borderRadius: BorderRadius.circular(15)
          ),
        ),
        Booster.horizontalSpace(10),
        Booster.textBody(context, title, fontWeight: FontWeight.bold)
      ],
    );
  }
}

