import 'package:asas/app/data/model/student.dart';
import 'package:asas/app/helpers/constance.dart';
import 'package:asas/app/helpers/dialog_utils.dart';
import 'package:asas/app/routes/app_pages.dart';
import 'package:asas/app/theme/lightColors.dart';
import 'package:asas/app/widgets/booster.dart';
import 'package:asas/app/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../../translations/strings_enum.dart';
import '../controllers/user_student_controller.dart';

class UserStudentView extends GetView<UserStudentController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=> controller.addStudent(),
        backgroundColor: LightColors.PRIMARY_COLOR,
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Strings.Student_List.tr,
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(
                  color: LightColors.TEXT_PRIMARY_COLOR),
            ),
            Booster.verticalSpace(25),
            Expanded(
              child: GetBuilder<UserStudentController>(
                builder: (ctrl){
                  if(ctrl.studentStatus == ApiCallStatus.loading){
                    return LoadingList(
                      height: 75,
                      margin: 10,
                      scrollDirection: Axis.vertical,
                      count: 5,
                    );
                  }else if(ctrl.studentStatus == ApiCallStatus.success){
                    return RefreshIndicator(
                      onRefresh: ()=> controller.onRefresh(),
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                        itemCount: ctrl.studentList.length,
                        itemBuilder: (context, index) => ListItem(
                            index: index,
                            student: ctrl.studentList[index],
                            onDeleteClicked: (id)=> DialogUtils.showConfirmDialog(
                                Get.context!,
                                title: Strings.delete_student.tr,
                                body: Strings.Are_you_sure_to_delete_this_student.tr,
                                isDelete: true,
                                onConfirm: () async {
                                  controller.deleteStudents(id);
                                }),
                            onEditClicked: (id)=> Get.toNamed(Routes.USER_EDIT_STUDENT, arguments: [id])),
                      ),
                    );
                  }else if(ctrl.studentStatus == ApiCallStatus.empty){
                    return Center(child: Booster.textSecondaryTitle(context, Strings.There_are_no_children.tr),);
                  }else{
                    return Center(child: Booster.textSecondaryTitle(context, Strings.Download_failed.tr),);
                  }
                },
              )
            )
          ],
        ),
      ),
    );
  }
}


class ListItem extends StatelessWidget {
  final Student student ;
  final int index;
  final Function onDeleteClicked;
  final Function onEditClicked;
  const ListItem({Key? key, required this.index, required this.student, required this.onDeleteClicked, required this.onEditClicked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: LightColors.EDIT_BORDER_COLOR),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            child: SvgPicture.asset('assets/svg/owner/card_zaz_right.svg'),
          ),
          Positioned(
            top: 5,
            bottom: 5,
            right: 8 + 10,
            left: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Booster.textSecondaryTitle(context, student.name!),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => onEditClicked(student.id),
                      child: Container(
                        height: 35,
                        width: 35,
                        padding:
                        const EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                            color:
                            LightColors.PRIMARY_COLOR,
                            borderRadius:
                            BorderRadius.circular(5)),
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: ()=> onDeleteClicked(student.id),
                      child: Container(
                        height: 35,
                        width: 35,
                        padding:
                        const EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                            color:
                            LightColors.ICON_COLOR_DELETE,
                            borderRadius:
                            BorderRadius.circular(5)),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )

        ],
      ),
    );
  }
}