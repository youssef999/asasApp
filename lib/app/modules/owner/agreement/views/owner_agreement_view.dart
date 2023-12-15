import 'package:asas/app/data/model/agreements.dart';
import 'package:asas/app/helpers/bottom_sheet.dart';
import 'package:asas/app/helpers/constance.dart';
import 'package:asas/app/theme/lightColors.dart';
import 'package:asas/app/widgets/booster.dart';
import 'package:asas/app/widgets/loading_widget.dart';
import 'package:asas/app/widgets/my_button.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../translations/strings_enum.dart';
import '../controllers/owner_agreement_controller.dart';

class OwnerAgreementView extends GetView<OwnerAgreementController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.conventions.tr),
        centerTitle: true,
      ),
      body: GetBuilder<OwnerAgreementController>(
        builder: (ctrl) {
          if(ctrl.agreementStatus == ApiCallStatus.loading){
            return LoadingList(
              height: 160,
              count: 6,
              margin: 20,
            );
          }else if(ctrl.agreementStatus == ApiCallStatus.success){
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              physics: const BouncingScrollPhysics(),
              itemCount: controller.agreement.length,
              itemBuilder: (_, index) => ListItem(agreement: controller.agreement[index]),
            );
          }else if(ctrl.agreementStatus == ApiCallStatus.empty){
            return Center(child: Booster.textTitle(context, Strings.There_are_no_agreements.tr),);
          }else {
            return Center(child: Booster.textTitle(context, Strings.ERROR_UNKNOWN.tr),);
          }
        }
      )
    );
  }
}


class ListItem extends StatelessWidget {
  final Agreement agreement;
  const ListItem({Key? key, required this.agreement}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: LightColors.EDIT_BACKGROUND_COLOR,
          border: Border.all(color: LightColors.EDIT_BORDER_COLOR),
          borderRadius: BorderRadius.circular(6)
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Booster.textTitle(context, agreement.nameAr!, color: LightColors.PRIMARY_COLOR),
          Booster.verticalSpace(5),
          Row(
            children: [
              Booster.textBody(context, agreement.status!, color: LightColors.ACCENT_COLOR, fontWeight: FontWeight.bold),
              Booster.horizontalSpace(5),
              Booster.textBody(context, "${Strings.mast_until.tr} ${agreement.endDate}",),
            ],
          ),
          Divider(color: Colors.grey.withOpacity(0.5),),
          SizedBox(
            height: 25,
            child: Booster.textBody(context, (agreement.shortDescriptionAr ?? "") + " ...", color: LightColors.TEXT_PRIMARY_COLOR),
          ),
          Booster.verticalSpace(10),
          MyButton(title: Strings.Agreement_details.tr, onTap: ()=> BottomSheetUtils.showAgreementBottomSheet(context, agreement.descriptionAr!),)

        ],
      ),
    );
  }
}
