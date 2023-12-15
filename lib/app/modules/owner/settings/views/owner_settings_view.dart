import 'package:asas/app/theme/lightColors.dart';
import 'package:asas/app/translations/localization_service.dart';
import 'package:asas/app/widgets/booster.dart';
import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../translations/strings_enum.dart';
import '../controllers/owner_settings_controller.dart';

class OwnerSettingsView extends GetView<OwnerSettingsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.Settings.tr),
        centerTitle: true,
      ),
      body: GetBuilder<OwnerSettingsController>(
        builder: (ctrl) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Booster.textBody(context, 'اللغة'),
                // Booster.verticalSpace(10),
                // CustomSearchableDropDown(
                //   items: LocalizationService.langs,
                //   label: 'اللغة',
                //   decoration: BoxDecoration(
                //       color: LightColors.EDIT_BACKGROUND_COLOR,
                //       borderRadius: BorderRadius.circular(10),
                //       border: Border.all(color: LightColors.EDIT_BORDER_COLOR)),
                //   prefixIcon: const Padding(
                //     padding: EdgeInsets.only(left: 5),
                //     child: Icon(
                //       Icons.search,
                //       color: Colors.grey,
                //     ),
                //   ),
                //   suffixIcon: SizedBox(),
                //   labelStyle: TextStyle(
                //       color: LightColors.TEXT_HINT_COLOR, fontSize: 14),
                //   dropDownMenuItems: LocalizationService.langs,
                //   hint: 'اللغة',
                //   dropdownHintText: 'اللغة',
                //   onChanged: (value) {
                //     if(value == null){
                //       return;
                //     }
                //     LocalizationService().changeLocale(value!);
                //   },
                // ),
                //
                // Booster.verticalSpace(20),
                //
                // Booster.textBody(context, 'العملة'),
                // Booster.verticalSpace(10),
                // CustomSearchableDropDown(
                //   items: ctrl.currencyList,
                //   label: "العملة",
                //   initialIndex: ctrl.getCurrencyIndex(),
                //   decoration: BoxDecoration(
                //       color: LightColors.EDIT_BACKGROUND_COLOR,
                //       borderRadius: BorderRadius.circular(10),
                //       border: Border.all(color: LightColors.EDIT_BORDER_COLOR)),
                //   prefixIcon: const Padding(
                //     padding: EdgeInsets.only(left: 5),
                //     child: Icon(
                //       Icons.search,
                //       color: Colors.grey,
                //     ),
                //   ),
                //   suffixIcon: SizedBox(),
                //   labelStyle: TextStyle(
                //       color: LightColors.TEXT_HINT_COLOR, fontSize: 14),
                //   dropDownMenuItems: ctrl.currencyList.map((e) => e.coinsNameAr).toList(),
                //   hint: 'العملة',
                //   dropdownHintText: 'العملة',
                //   onChanged: (value) {
                //     if(value == null){
                //       return;
                //     }
                //     controller.setCurrency(value.id);
                //   },
                // ),
                //
                // Booster.verticalSpace(20),

                Booster.textBody(context, Strings.notification.tr),
                Booster.verticalSpace(5),
                Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      value: controller.checkbox,
                      visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                      fillColor: MaterialStateProperty.resolveWith(controller.getColor),
                      onChanged: (bool? value) {
                        controller.checkboxChange(value!);
                      },
                    ),
                    Booster.horizontalSpace(4),
                    Booster.textBody(context, Strings.Activate_notifications.tr)
                  ],
                )
              ],
            ),
          );
        }
      ),
    );
  }
}
