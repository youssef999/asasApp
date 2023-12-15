import 'package:asas/app/data/model/discount.dart';
import 'package:asas/app/data/model/service.dart';
import 'package:asas/app/helpers/bottom_sheet.dart';
import 'package:asas/app/helpers/constance.dart';
import 'package:asas/app/helpers/dialog_utils.dart';
import 'package:asas/app/theme/lightColors.dart';
import 'package:asas/app/widgets/booster.dart';
import 'package:asas/app/widgets/edit_text.dart';
import 'package:asas/app/widgets/my_button.dart';
import 'package:asas/app/widgets/program_widget.dart';
import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../translations/strings_enum.dart';
import '../controllers/owner_edit_program_controller.dart';

class OwnerEditProgramView extends GetView<OwnerEditProgramController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.Program_modification.tr),
        centerTitle: true,
      ),
      body: GetBuilder<OwnerEditProgramController>(
          id: 'main',
          builder: (ctrl) {
            if (controller.program == null) {
              print('prog is null');
              return Center(
                child: CupertinoActivityIndicator(),
              );
            } else {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: ReactiveForm(
                    formGroup: controller.form,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        EditText(
                          controlName: 'name_en',
                          hint: Strings.name_en.tr,
                          horizontal: 0,
                        ),
                        EditText(
                          controlName: 'name_ar',
                          hint: Strings.name_ar.tr,
                          horizontal: 0,
                        ),
                        EditText(
                          controlName: 'description_en',
                          hint: Strings.Program_Details_en.tr,
                          horizontal: 0,
                          multiline: true,
                          lines: 4,
                        ),
                        EditText(
                          controlName: 'description_ar',
                          hint: Strings.Program_Details_ar.tr,
                          horizontal: 0,
                          multiline: true,
                          lines: 4,
                        ),
                        EditText(
                          controlName: 'sort',
                          hint: Strings.Add_sort.tr,
                          horizontal: 0,
                        ),
                        Booster.verticalSpace(8),
                        GetBuilder<OwnerEditProgramController>(
                            id: 'types',
                            builder: (ctrl) {
                              return Column(
                                children: [
                                  CustomSearchableDropDown(
                                    items: ctrl.timeTypeList,
                                    label: Strings.time_type.tr,
                                    initialIndex: ctrl.getTimeInitialIndex(),
                                    decoration: BoxDecoration(
                                        color:
                                            LightColors.EDIT_BACKGROUND_COLOR,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color:
                                                LightColors.EDIT_BORDER_COLOR)),
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
                                    dropDownMenuItems: ctrl.timeTypeList
                                        .map((e) => e.timeTypeAr)
                                        .toList(),
                                    hint: Strings.time_type.tr,
                                    dropdownHintText: Strings.time_type.tr,
                                    onChanged: (value) {
                                      //id_timeType
                                      if (value == null) {
                                        return;
                                      }
                                      controller.setTimeType(value.id);
                                    },
                                  ),
                                  Booster.verticalSpace(16),
                                  CustomSearchableDropDown(
                                    items: ctrl.programTypeList,
                                    label: Strings.Program_type.tr,
                                    initialIndex: ctrl.getProgramInitialIndex(),
                                    decoration: BoxDecoration(
                                        color:
                                            LightColors.EDIT_BACKGROUND_COLOR,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color:
                                                LightColors.EDIT_BORDER_COLOR)),
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
                                    dropDownMenuItems: ctrl.programTypeList
                                        .map((e) => e.programTypeAr)
                                        .toList(),
                                    hint: Strings.Program_type.tr,
                                    dropdownHintText: Strings.Program_type.tr,
                                    onChanged: (value) {
                                      //id_typeProgram
                                      if (value == null) {
                                        return;
                                      }
                                      controller.setProgramType(value.id);
                                    },
                                  ),
                                  Booster.verticalSpace(16),
                                  CustomSearchableDropDown(
                                    items: ctrl.curriculumTypeList,
                                    label: Strings.Curriculum_type.tr,
                                    initialIndex:
                                        ctrl.getCurriculumInitialIndex(),
                                    decoration: BoxDecoration(
                                        color:
                                            LightColors.EDIT_BACKGROUND_COLOR,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color:
                                                LightColors.EDIT_BORDER_COLOR)),
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
                                    dropDownMenuItems: ctrl.curriculumTypeList
                                        .map((e) => e.nameAr)
                                        .toList(),
                                    hint: Strings.Curriculum_type.tr,
                                    dropdownHintText:
                                        Strings.Curriculum_type.tr,
                                    onChanged: (value) {
                                      //id_typeProgram
                                      if (value == null) {
                                        return;
                                      }
                                      controller.setCurriculumType(value.id);
                                    },
                                  ),
                                  Booster.verticalSpace(8),
                                ],
                              );
                            }),
                        EditText(
                          controlName: 'price_main',
                          hint: Strings.Price_before_discount.tr,
                          horizontal: 0,
                          inputType: TextInputType.number,
                        ),
                        Booster.verticalSpace(10),
                        GetBuilder<OwnerEditProgramController>(
                            id: 'discount',
                            builder: (ctrl) {
                              return DiscountSection(
                                discountList: controller.discountList,
                                onDeleteClicked: (index, id) =>
                                    DialogUtils.showConfirmDialog(context,
                                        title: Strings.delete_discount.tr,
                                        body:
                                            Strings.Are_sure_delete_discount.tr,
                                        onConfirm: () => controller
                                            .deleteDiscount(index, id)),
                                onAddClick: () =>
                                    BottomSheetUtils.showAddDiscountBottomSheet(
                                        context,
                                        onSubmit: (discount, dateFrom, dataTo) {
                                  controller.addDiscount(Discount(
                                      priceRateDiscount: discount,
                                      startDiscount: dateFrom,
                                      endDiscount: dataTo));
                                }),
                              );
                            }),
                        Booster.verticalSpace(10),
                        EditText(
                          controlName: 'price_note_en',
                          hint: Strings.price_note_en.tr,
                          horizontal: 0,
                        ),
                        EditText(
                          controlName: 'price_note_ar',
                          hint: Strings.price_note_ar.tr,
                          horizontal: 0,
                        ),
                        EditText(
                          controlName: 'age_conditions_en',
                          hint: Strings.age_conditions_en.tr,
                          horizontal: 0,
                        ),
                        EditText(
                          controlName: 'age_conditions_ar',
                          hint: Strings.age_conditions_ar.tr,
                          horizontal: 0,
                        ),
                        EditText(
                          controlName: 'other_conditions_en',
                          hint: Strings.other_conditions_en.tr,
                          horizontal: 0,
                        ),
                        EditText(
                          controlName: 'other_conditions_ar',
                          hint: Strings.other_conditions_ar.tr,
                          horizontal: 0,
                        ),
                        EditText(
                          controlName: 'url_viedo',
                          hint: Strings.url_viedo.tr,
                          horizontal: 0,
                        ),
                        Booster.verticalSpace(10),
                        GetBuilder<OwnerEditProgramController>(
                            id: 'images',
                            builder: (ctrl) {
                              return MediaSection(
                                imageModelList: controller.mediaList,
                                onAddClick: () => controller.addImages(),
                                title: Strings.Download_program_images.tr,
                                imageBaseUrl: Constance.imageProgramBaseUrl,
                                onDeleteClicked: (index, id) =>
                                    DialogUtils.showConfirmDialog(context,
                                        title: Strings.delImages.tr,
                                        body: Strings.delete_this_photo.tr,
                                        onConfirm: () =>
                                            controller.deleteImages(index, id)),
                              );
                            }),
                        Booster.verticalSpace(20),
                        GetBuilder<OwnerEditProgramController>(
                            id: 'service',
                            builder: (ctrl) {
                              return OtherServices(
                                serviceList: controller.serviceList,
                                onDeleteClicked: (index, id) =>
                                    DialogUtils.showConfirmDialog(context,
                                        title: Strings.delete_service.tr,
                                        body: Strings.Are_delete_service.tr,
                                        onConfirm: () => controller
                                            .deleteService(index, id)),
                                onAddClick: () =>
                                    BottomSheetUtils.showAddServiceBottomSheet(
                                        context, onSubmit:
                                            (price, serviceAr, serviceEn) {
                                  controller.addService(Service(
                                      price: price,
                                      serviceAr: serviceAr,
                                      serviceEn: serviceEn));
                                }),
                              );
                            }),
                        Booster.verticalSpace(10),
                        Divider(
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        Booster.verticalSpace(10),
                        Booster.textBody(
                            context, Strings.customize_exclusive_features.tr,
                            color: LightColors.PRIMARY_COLOR,
                            fontWeight: FontWeight.bold,
                            textSize: 14,
                            textAlign: TextAlign.start),
                        Booster.verticalSpace(10),
                        EditText(
                          controlName: 'other_fute',
                          hint: Strings.Exclusive_features.tr,
                          horizontal: 0,
                          multiline: true,
                          lines: 8,
                          inputAction: TextInputAction.done,
                        ),
                        Booster.verticalSpace(10),
                        MyButton(
                          title: Strings.Save.tr,
                          onTap: () => controller.updateProgram(),
                        )
                      ],
                    )),
              );
            }
          }),
    );
  }
}
