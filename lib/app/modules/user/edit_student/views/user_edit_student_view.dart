import 'package:asas/app/helpers/constance.dart';
import 'package:asas/app/helpers/dialog_utils.dart';
import 'package:asas/app/theme/lightColors.dart';
import 'package:asas/app/widgets/booster.dart';
import 'package:asas/app/widgets/edit_text.dart';
import 'package:asas/app/widgets/my_button.dart';
import 'package:asas/app/widgets/program_widget.dart';
import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../translations/strings_enum.dart';
import '../controllers/user_edit_student_controller.dart';

class UserEditStudentView extends GetView<UserEditStudentController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.Edit_student_formation.tr),
        centerTitle: true,
      ),
      body: GetBuilder<UserEditStudentController>(
        id: 'main',
        builder: (ctrl) {
          return ReactiveForm(
            formGroup: controller.form,
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Strings.Basic_student_data.tr ,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        ?.copyWith(
                        color: LightColors.TEXT_PRIMARY_COLOR),
                  ),
                  Booster.verticalSpace(10),
                  EditText(
                    controlName: 'name',
                    hint: Strings.student_name.tr,
                    horizontal: 0,
                  ),
                  EditText(
                    controlName: 'name_father',
                    hint: Strings.Parent_name.tr,
                    horizontal: 0,
                  ),
                  Booster.verticalSpace(8),
                  GetBuilder<UserEditStudentController>(
                      id: 'date_of_birth',
                      builder: (ctrl) {
                        return InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            picker.DatePicker.showDatePicker(context,
                                showTitleActions: true,
                                minTime: DateTime(2021, 1, 1),
                                onConfirm: (date) {
                                  ctrl.setDate(date);
                                }, currentTime: DateTime.now(), locale: picker.LocaleType.ar);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                                color: LightColors.EDIT_BACKGROUND_COLOR,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey[300]!)),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: (ctrl.dateOfBirth == null)
                                      ? Text(Strings.Student_birth.tr, style: TextStyle(fontSize: 12.0, color: LightColors.TEXT_HINT_COLOR),)
                                      : Text(ctrl.dateOfBirth!, style: TextStyle(fontSize: 12.0),),
                                ),
                                Icon(
                                  Icons.date_range,
                                  color: Theme.of(context).colorScheme.secondary,

                                )
                              ],
                            ),
                          ),
                        );
                      }
                  ),
                  Booster.verticalSpace(16),
                  GetBuilder<UserEditStudentController>(
                      id: 'gender',
                      builder: (context) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: LightColors.EDIT_BACKGROUND_COLOR,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey[300]!)),
                          child: DropdownButton<String>(
                            hint: Text(
                              Strings.Type.tr,
                              style: TextStyle(fontSize: 12.0, color: LightColors.TEXT_HINT_COLOR, fontFamily: 'JF'),
                            ),
                            value: controller.gender ,
                            isExpanded: true,
                            underline: Container(),
                            items: [Strings.female.tr, Strings.male.tr]
                                .map((e) => DropdownMenuItem<String>(
                              child: Text(
                                e,
                                style: TextStyle(fontSize: 12.0, fontFamily: 'JF'),
                              ),
                              value: e,
                            ))
                                .toList(),
                            onChanged: (value) {
                              controller.setGender(value);
                            },
                          ),
                        );
                      }
                  ),
                  Booster.verticalSpace(25),
                  Row(
                    children: [
                      Text(
                  Strings.extra_data.tr ,
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            ?.copyWith(
                            color: LightColors.TEXT_PRIMARY_COLOR),
                      ),
                      Booster.horizontalSpace(5),
                      Text(
                        "(${Strings.optional.tr})",
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            ?.copyWith(
                            color: LightColors.ACCENT_COLOR, fontSize: 13),
                      ),
                    ],
                  ),
                  Booster.verticalSpace(10),
                  EditText(
                    controlName: 'nationality',
                    hint: Strings.Nationality.tr,
                    horizontal: 0,
                  ),
                  EditText(
                    controlName: 'country_of_residence',
                    hint: Strings.country_of_residence.tr,
                    horizontal: 0,
                  ),
                  Booster.verticalSpace(8),
                  GetBuilder<UserEditStudentController>(
                      id: 'types',
                      builder: (ctrl) {
                        return CustomSearchableDropDown(
                          items: ctrl.curriculumTypeList,
                          label: Strings.Curriculum_type.tr,
                          initialIndex: ctrl.getCurriculumInitialIndex(),
                          decoration: BoxDecoration(
                              color: LightColors.EDIT_BACKGROUND_COLOR,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: LightColors.EDIT_BORDER_COLOR)),
                          suffixIcon: const Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                          ),
                          prefixIcon: SizedBox(),
                          labelStyle: TextStyle(
                              color: LightColors.TEXT_PRIMARY_COLOR, fontSize: 14),
                          dropDownMenuItems: ctrl.curriculumTypeList.map((e) => e.nameAr).toList(),
                          hint: Strings.Curriculum_type.tr,
                          dropdownHintText: Strings.Curriculum_type.tr,
                          onChanged: (value) {
                            //id_typeProgram
                            if(value == null){
                              return;
                            }
                            controller.setCurriculumType(value.id);
                          },
                        );
                      }
                  ),
                  Booster.verticalSpace(8),
                  EditText(
                    controlName: 'current_academic_certificates',
                    hint: Strings.Current_educational_certificates.tr,
                    horizontal: 0,
                  ),
                  Booster.verticalSpace(10),
                  GetBuilder<UserEditStudentController>(
                      id: 'images',
                      builder: (ctrl) {
                        return MediaSection(
                          imageModelList: controller.mediaList,
                          onAddClick: ()=> controller.addImages(),
                          title: Strings.Download_program_images.tr,
                          imageBaseUrl: Constance.imageStudentBaseUrl,
                          onDeleteClicked: (index, id)=> DialogUtils.showConfirmDialog(
                              context,
                              title: Strings.delImages.tr,
                              body: Strings.delete_this_photo.tr,
                              onConfirm: ()=> controller.deleteImages(index, id)),
                        );
                      }
                  ),
                  Booster.verticalSpace(10),
                  EditText(
                    controlName: 'sports_of_interest',
                    hint: Strings.Sports_of_interest.tr,
                    horizontal: 0,
                  ),
                  EditText(
                    controlName: 'artistic_activities_of_interest',
                    hint: Strings.Artistic_activities_interest.tr,
                    horizontal: 0,
                  ),
                  EditText(
                    controlName: 'religious_activities_of_interest',
                    hint: Strings.Religious_activities_interest.tr,
                    horizontal: 0,
                  ),
                  Booster.verticalSpace(50),
                  MyButton(title: Strings.Save.tr, onTap: ()=> controller.updateStudent(),)
                ],
              ),
            )
          );
        }
      ),
    );
  }
}
