import 'package:asas/app/helpers/constance.dart';
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
import '../controllers/user_add_student_controller.dart';

class UserAddStudentView extends GetView<UserAddStudentController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('إضافة طالب'),
        centerTitle: true,
      ),
      body: ReactiveForm(
        formGroup: controller.form,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: GetBuilder<UserAddStudentController>(
            id: 'TabBarView',
            builder: (ctrl) {
              return TabBarView(
                controller: controller.tabBarController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Strings.Basic_student_data.tr,
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            ?.copyWith(
                            color: LightColors.TEXT_PRIMARY_COLOR),
                      ),
                      Booster.verticalSpace(10),
                      Text(
                        Strings.Fill_in_the_following_fields.tr,
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            ?.copyWith(
                            color: LightColors.PRIMARY_COLOR, fontSize: 13),
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
                      GetBuilder<UserAddStudentController>(
                        id: 'date_of_birth',
                        builder: (ctrl) {
                          return InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () {
                              picker.DatePicker.showDatePicker(context,
                                  showTitleActions: true,
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
                                        ? Text(Strings.Student_birth.tr , style: TextStyle(fontSize: 12.0, color: LightColors.TEXT_HINT_COLOR),)
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
                      GetBuilder<UserAddStudentController>(
                        id: 'gender',
                        builder: (ctrl) {
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
                      Booster.verticalSpace(50),
                      MyButton(title: Strings.tracking.tr, onTap: ()=> ctrl.tabBarToIndex(1),)
                    ],
                  ),
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                               Strings.extra_data.tr,
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
                        Text(
                          Strings.Additional_information.tr,
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(
                              color: LightColors.PRIMARY_COLOR, fontSize: 13),
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
                        GetBuilder<UserAddStudentController>(
                          id: 'types',
                          builder: (ctrl) {
                            return CustomSearchableDropDown(
                              items: ctrl.curriculumTypeList,
                              label: Strings.Curriculum_type.tr,
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
                        GetBuilder<UserAddStudentController>(
                            id: 'images',
                            builder: (context) {
                              return MediaSection(
                                imageModelList: controller.imageModelList,
                                onAddClick: ()=> controller.addImages(),
                                title: Strings.Upload_photos.tr,
                                imageBaseUrl: Constance.imageStudentBaseUrl,
                                onDeleteClicked: (index, _)=> controller.deleteImages(index),
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
                        Row(
                          children: [
                            Expanded(child: MyButton(title: Strings.tracking.tr, onTap: ()=> ctrl.addStudent(),)),
                            Booster.horizontalSpace(10),
                            Expanded(child: MyButton(title: Strings.back.tr, onTap: ()=> ctrl.tabBarToIndex(0), secondary: true,)),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}
