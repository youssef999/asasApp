import 'package:asas/app/data/model/program.dart';
import 'package:asas/app/helpers/constance.dart';
import 'package:asas/app/helpers/dialog_utils.dart';
import 'package:asas/app/theme/lightColors.dart';
import 'package:asas/app/widgets/booster.dart';
import 'package:asas/app/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../translations/strings_enum.dart';
import '../controllers/owner_programs_controller.dart';

class OwnerProgramsView extends GetView<OwnerProgramsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.List_of_Enterprise_Programs.tr),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.addProgram(),
        backgroundColor: LightColors.PRIMARY_COLOR,
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Booster.textBody(context, Strings.enterprise_software.tr,
                color: LightColors.PRIMARY_COLOR),
            Booster.verticalSpace(20),
            Expanded(child: GetBuilder<OwnerProgramsController>(
              builder: (ctrl) {
                if (ctrl.programStatus == ApiCallStatus.success) {
                  return RefreshIndicator(
                    onRefresh: () => ctrl.getPrograms(1),
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      controller: controller.programScrollController,
                      itemCount: ctrl.programList.length,
                      itemBuilder: (context, index) => ListItem(
                        program: ctrl.programList[index],
                        index: index,
                        onDeleteClicked: (id) => DialogUtils.showConfirmDialog(
                            Get.context!,
                            title: Strings.delete_program.tr,
                            body: Strings.delete_program_from_organization.tr,
                            isDelete: true, onConfirm: () async {
                          controller.deleteProgram(id);
                        }),
                        onEditClicked: (id) => ctrl.editProgram(id, index),
                      ),
                    ),
                  );
                } else if (ctrl.programStatus == ApiCallStatus.loading) {
                  return LoadingList(
                    height: 75,
                  );
                } else if (ctrl.programStatus == ApiCallStatus.failed) {
                  return Center(
                      child: Text(Strings.The_data_was_not_fetched.tr));
                } else {
                  // ctrl.sectionsStatus == ApiCallStatus.empty
                  return Center(child: Text(Strings.There_are_no_programs.tr));
                }
              },
            ))
          ],
        ),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final Program program;
  final int index;
  final Function onDeleteClicked;
  final Function onEditClicked;
  const ListItem(
      {Key? key,
      required this.index,
      required this.program,
      required this.onDeleteClicked,
      required this.onEditClicked})
      : super(key: key);

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
                Booster.textSecondaryTitle(context, program.nameAr!),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => onEditClicked(program.id),
                      child: Container(
                        height: 35,
                        width: 35,
                        padding: const EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                            color: LightColors.PRIMARY_COLOR,
                            borderRadius: BorderRadius.circular(5)),
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
                      onTap: () => onDeleteClicked(program.id),
                      child: Container(
                        height: 35,
                        width: 35,
                        padding: const EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                            color: LightColors.ICON_COLOR_DELETE,
                            borderRadius: BorderRadius.circular(5)),
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
