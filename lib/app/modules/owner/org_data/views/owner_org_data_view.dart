import 'dart:io';

import 'package:asas/app/helpers/constance.dart';
import 'package:asas/app/helpers/dialog_utils.dart';
import 'package:asas/app/theme/lightColors.dart';
import 'package:asas/app/widgets/booster.dart';
import 'package:asas/app/widgets/edit_text.dart';
import 'package:asas/app/widgets/my_button.dart';
import 'package:asas/app/widgets/program_widget.dart';
import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../translations/strings_enum.dart';
import '../controllers/owner_org_data_controller.dart';

class OwnerOrgDataView extends GetView<OwnerOrgDataController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.Enterprise_data.tr),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: ReactiveForm(
            formGroup: controller.form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Booster.textTitle(
                    context, Strings.Update_your_organization_data.tr,
                    color: LightColors.PRIMARY_COLOR),
                Booster.verticalSpace(20),
                EditText(
                  hint: Strings.name_corporation2.tr,
                  controlName: 'name_corporation',
                  horizontal: 0,
                  vertical: 0,
                ),
                Booster.verticalSpace(16),
                EditText(
                  hint: Strings.name_corporation_ar.tr,
                  controlName: 'name_corporation_ar',
                  horizontal: 0,
                  vertical: 0,
                ),
                GetBuilder<OwnerOrgDataController>(
                  id: 'types',
                  builder: (ctrl) {
                    return Column(
                      children: [
                        Booster.verticalSpace(16),
                        CustomSearchableDropDown(
                          items: ctrl.companyTypeList,
                          label: Strings.type_corporation.tr,
                          initialIndex: ctrl.getCompanyIndex(),
                          decoration: BoxDecoration(
                              color: LightColors.EDIT_BACKGROUND_COLOR,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: LightColors.EDIT_BORDER_COLOR)),
                          suffixIcon: const Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                          ),
                          prefixIcon: SizedBox(),
                          labelStyle: TextStyle(
                              color: LightColors.TEXT_PRIMARY_COLOR,
                              fontSize: 14),
                          dropDownMenuItems: ctrl.companyTypeList
                              .map((e) => e.typeNameAr)
                              .toList(),
                          hint: Strings.type_corporation.tr,
                          dropdownHintText: Strings.type_corporation.tr,
                          onChanged: (value) {
                            //id_typeProgram
                            if (value == null) {
                              return;
                            }
                            controller.setCompanyType(value.id);
                          },
                        ),
                        Booster.verticalSpace(16),
                        CustomSearchableDropDown(
                          items: ctrl.countryList,
                          label: Strings.Choose_the_country.tr,
                          initialIndex: ctrl.getCountryIndex(),
                          decoration: BoxDecoration(
                              color: LightColors.EDIT_BACKGROUND_COLOR,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: LightColors.EDIT_BORDER_COLOR)),
                          suffixIcon: const Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                          ),
                          prefixIcon: SizedBox(),
                          labelStyle: TextStyle(
                              color: LightColors.TEXT_PRIMARY_COLOR,
                              fontSize: 14),
                          dropDownMenuItems:
                              ctrl.countryList.map((e) => e.nameAr).toList(),
                          hint: Strings.Choose_the_country.tr,
                          dropdownHintText: Strings.Choose_the_country.tr,
                          onChanged: (value) {
                            //id_typeProgram
                            if (value == null) {
                              return;
                            }
                            controller.setCountryType(value.id);
                          },
                        ),
                        if (ctrl.showCity()) ...[
                          Booster.verticalSpace(16),
                          CustomSearchableDropDown(
                            items: ctrl.cityList,
                            label: Strings.Choose_the_city.tr,
                            initialIndex: ctrl.getCityIndex(),
                            decoration: BoxDecoration(
                                color: LightColors.EDIT_BACKGROUND_COLOR,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: LightColors.EDIT_BORDER_COLOR)),
                            suffixIcon: const Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                            ),
                            prefixIcon: SizedBox(),
                            labelStyle: TextStyle(
                                color: LightColors.TEXT_PRIMARY_COLOR,
                                fontSize: 14),
                            dropDownMenuItems:
                                ctrl.cityList.map((e) => e.nameAr).toList(),
                            hint: Strings.Choose_the_city.tr,
                            dropdownHintText: Strings.Choose_the_city.tr,
                            onChanged: (value) {
                              //id_typeProgram
                              if (value == null) {
                                return;
                              }
                              controller.setCityType(value.id);
                            },
                          ),
                        ],
                        if (ctrl.showDistrict()) ...[
                          Booster.verticalSpace(16),
                          CustomSearchableDropDown(
                            items: ctrl.districtList,
                            label: Strings.Choose_the_district.tr,
                            initialIndex: ctrl.getDistrictIndex(),
                            decoration: BoxDecoration(
                                color: LightColors.EDIT_BACKGROUND_COLOR,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: LightColors.EDIT_BORDER_COLOR)),
                            suffixIcon: const Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                            ),
                            prefixIcon: SizedBox(),
                            labelStyle: TextStyle(
                                color: LightColors.TEXT_PRIMARY_COLOR,
                                fontSize: 14),
                            dropDownMenuItems:
                                ctrl.districtList.map((e) => e.nameAr).toList(),
                            hint: Strings.Choose_the_district.tr,
                            dropdownHintText: Strings.Choose_the_district.tr,
                            onChanged: (value) {
                              //id_typeProgram
                              if (value == null) {
                                return;
                              }
                              controller.setDistrictType(value.id);
                            },
                          ),
                        ],
                        Booster.verticalSpace(16),
                        CustomSearchableDropDown(
                          items: ctrl.currencyList,
                          label: Strings.Choose_the_currency.tr,
                          initialIndex: ctrl.getCurrencyIndex(),
                          decoration: BoxDecoration(
                              color: LightColors.EDIT_BACKGROUND_COLOR,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: LightColors.EDIT_BORDER_COLOR)),
                          suffixIcon: const Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                          ),
                          prefixIcon: SizedBox(),
                          labelStyle: TextStyle(
                              color: LightColors.TEXT_PRIMARY_COLOR,
                              fontSize: 14),
                          dropDownMenuItems: ctrl.currencyList
                              .map((e) => e.coinsNameAr)
                              .toList(),
                          hint: Strings.Choose_the_currency.tr,
                          dropdownHintText: Strings.Choose_the_currency.tr,
                          onChanged: (value) {
                            //id_typeProgram
                            if (value == null) {
                              return;
                            }
                            controller.setCurrency(value.id);
                          },
                        ),
                      ],
                    );
                  },
                ),
                Booster.verticalSpace(16),
                GetBuilder<OwnerOrgDataController>(
                    id: 'images',
                    builder: (ctrl) {
                      return MediaSection(
                        imageModelList: controller.company?.media ?? [],
                        onAddClick: () => controller.addImages(),
                        title: Strings.Add_company_photos.tr,
                        imageBaseUrl: Constance.imageCompanyBaseUrl,
                        onDeleteClicked: (index, id) =>
                            DialogUtils.showConfirmDialog(context,
                                title: Strings.delImages.tr,
                                body: Strings.delete_this_photo.tr,
                                onConfirm: () =>
                                    controller.deleteImages(index, id)),
                      );
                    }),
                Booster.verticalSpace(12),
                GetBuilder<OwnerOrgDataController>(
                    id: 'logo',
                    builder: (ctrl) {
                      return LogoSection(
                        onClicked: () => ctrl.addLogo(),
                        imageBaseUrl: Constance.imageCompanyBaseUrl,
                        path: ctrl.path,
                        url: ctrl.logo,
                      );
                    }),
                Booster.verticalSpace(12),
                EditText(
                  hint: Strings.Description_of_the_Arabic.tr,
                  controlName: 'desception_ar',
                  multiline: true,
                  lines: 5,
                  horizontal: 0,
                  vertical: 0,
                ),
                Booster.verticalSpace(12),
                EditText(
                  hint: Strings.Description_of_the_en.tr,
                  controlName: 'desception_en',
                  multiline: true,
                  lines: 5,
                  horizontal: 0,
                  vertical: 0,
                ),
                Booster.verticalSpace(12),
                Booster.textSecondaryTitle(
                    context, Strings.Locate_your_organization_on_the_map.tr),
                Booster.verticalSpace(10),
                GestureDetector(
                    onTap: () => controller.getLocationData(),
                    child: Image.asset("assets/images/map.png")),
                Booster.verticalSpace(40),
                MyButton(
                    title: Strings.Updating_data.tr,
                    onTap: () => controller.updateData()),
                Booster.verticalSpace(30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LogoSection extends StatelessWidget {
  final String? path;
  final String? url;
  final Function onClicked;
  final String imageBaseUrl; //
  const LogoSection(
      {Key? key,
      required this.imageBaseUrl,
      this.path,
      required this.onClicked,
      this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
          border: Border.all(color: LightColors.EDIT_BORDER_COLOR),
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Booster.textBody(
              context, Strings.Upload_the_image_of_the_company_logo.tr,
              color: LightColors.TEXT_PRIMARY_COLOR),
          Booster.verticalSpace(10),
          GestureDetector(
            onTap: () => onClicked(),
            child: Row(
              children: [
                if (url == null && path == null) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SvgPicture.asset('assets/svg/owner/logo_upload.svg',
                        width: 50, height: 50),
                  ),
                  Booster.horizontalSpace(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Booster.textBody(context, Strings.upload_photo.tr,
                          color: LightColors.PRIMARY_COLOR),
                      Booster.textBody(
                        context,
                        Strings.Click_to_select_manually.tr,
                      ),
                    ],
                  ),
                ] else ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: path == null
                        ? Image.network(imageBaseUrl + url!,
                            width: 50, height: 50)
                        : Image.file(File(path!), width: 50, height: 50),
                  ),
                  Booster.horizontalSpace(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Booster.textBody(context, Strings.Enterprise_logo.tr),
                    ],
                  )
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
