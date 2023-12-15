import 'package:asas/app/helpers/constance.dart';
import 'package:asas/app/theme/lightColors.dart';
import 'package:asas/app/widgets/booster.dart';
import 'package:asas/app/widgets/my_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../translations/strings_enum.dart';
import '../controllers/owner_booking_details_controller.dart';

class OwnerBookingDetailsView extends GetView<OwnerBookingDetailsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.Reservation.tr),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: ()=> controller.getReservationDetails(controller.childrenProgramId),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          child: GetBuilder<OwnerBookingDetailsController>(
            builder: (ctrl) {
              if(ctrl.reservationDetailsStatus == ApiCallStatus.loading || ctrl.reservationDetails == null){
                return Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Center(child: CupertinoActivityIndicator()),
                );
              }
              if(ctrl.reservationDetailsStatus == ApiCallStatus.failed){
                return Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Center(child: Booster.textTitle(context, Strings.Failed_to_get_data.tr)),
                );
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Booster.textBody(context, Strings.additional_services.tr,
                        textSize: 15,
                        color: LightColors.PRIMARY_COLOR,
                        fontWeight: FontWeight.bold),
                    Booster.verticalSpace(10),
                    ...ctrl.reservationDetails?.moreService?.map((e) => OtherServiceItem(text: "${e.serviceAr}   ${ctrl.reservationDetails!.coins!.coinsNameAr!}  ${e.price} ",)).toList() ?? [Booster.textBody(context, "لا يوجد")],
                    Booster.verticalSpace(10),
                    Divider(color: LightColors.DIVIDER_COLOR,),
                    Booster.verticalSpace(10),
                    Booster.textBody(context, Strings.Reservation_data.tr,
                        textSize: 15,
                        color: LightColors.PRIMARY_COLOR,
                        fontWeight: FontWeight.bold),
                    Booster.verticalSpace(10),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Booster.textBody(context, Strings.Parent_name.tr),
                            Booster.textBody(context, Strings.Telephone_number.tr),
                            Booster.textBody(context, Strings.student_name.tr),
                            Booster.textBody(context, Strings.Student_birth.tr),
                          ],
                        ),
                        Booster.horizontalSpace(20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Booster.textBody(context, ctrl.reservationDetails?.fatherName ?? ctrl.reservationDetails!.fatherName2! , color: LightColors.TEXT_PRIMARY_COLOR),
                            Booster.textBody(context, ctrl.reservationDetails!.phone! , color: LightColors.TEXT_PRIMARY_COLOR),
                            Booster.textBody(context, ctrl.reservationDetails!.childName! , color: LightColors.TEXT_PRIMARY_COLOR),
                            Booster.textBody(context, ctrl.reservationDetails!.dateOfBirth!, color: LightColors.TEXT_PRIMARY_COLOR),
                          ],
                        )
                      ],
                    ),
                    Booster.verticalSpace(10),
                    Divider(color: LightColors.DIVIDER_COLOR,),
                    Booster.verticalSpace(10),
                    Booster.textBody(context, "تفاصيل السعر",
                        textSize: 15,
                        color: LightColors.PRIMARY_COLOR,
                        fontWeight: FontWeight.bold),
                    Booster.verticalSpace(10),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Booster.textBody(context, Strings.The_original_price_program.tr),
                            Booster.textBody(context, Strings.The_current_discount_program.tr),
                            Booster.textBody(context, Strings.The_price_after_discount.tr),

                          ],
                        ),
                        Booster.horizontalSpace(20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Booster.textBody(context, ctrl.reservationDetails!.price.toString() +' '+ ctrl.reservationDetails!.coins!.coinsNameAr!, color: LightColors.TEXT_PRIMARY_COLOR),
                            Booster.textBody(context, ctrl.getDiscount() +' '+ ctrl.reservationDetails!.coins!.coinsNameAr!, color: LightColors.TEXT_PRIMARY_COLOR),
                            Booster.textBody(context, ctrl.getPriceAfterDiscount() +' '+ ctrl.reservationDetails!.coins!.coinsNameAr!, color: LightColors.TEXT_PRIMARY_COLOR),

                          ],
                        )
                      ],
                    ),
                    Booster.verticalSpace(10),
                    Divider(color: LightColors.DIVIDER_COLOR,),
                    Booster.verticalSpace(10),
                    Booster.textBody(context, Strings.Notes_basic_program_price.tr,
                        textSize: 15,
                        color: LightColors.PRIMARY_COLOR,
                        fontWeight: FontWeight.bold),
                    Booster.textBody(context, "(${Strings.Without_additional_services.tr})",
                        textSize: 13,
                        color: LightColors.ACCENT_COLOR,
                        fontWeight: FontWeight.bold),
                    Booster.verticalSpace(10),
                    Booster.textBody(context, ctrl.reservationDetails!.priceNoteAr.toString(), color: LightColors.TEXT_PRIMARY_COLOR, textAlign: TextAlign.start),
                    Booster.verticalSpace(10),
                    Divider(color: LightColors.DIVIDER_COLOR,),
                    Booster.verticalSpace(10),
                    if(ctrl.getPriceAfterAddServices() != null)
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Booster.textBody(context, Strings.Price_after_adding_services.tr, color: LightColors.TEXT_PRIMARY_COLOR),
                          ],
                        ),
                        Booster.horizontalSpace(10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Booster.textTitle(context, (ctrl.reservationDetails?.priceAfterAddingService ?? "").toString() +' '+ ctrl.reservationDetails!.coins!.coinsNameAr!, color: LightColors.TEXT_ACCENT_COLOR),
                          ],
                        )
                      ],
                    ),
                    Booster.verticalSpace(40),
                    if(controller.showAddAction())
                    MyButton(title: Strings.action_action.tr,onTap: ()=> controller.addAction()),
                    Booster.verticalSpace(30),
                  ],
                ),
              );
            }
          ),
        ),
      ),
    );
  }
}

class OtherServiceItem extends StatelessWidget {
  final String text;
  const OtherServiceItem({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(
            color: LightColors.ACCENT_COLOR,
            borderRadius: BorderRadius.circular(50)
          ),
        ),
        Booster.horizontalSpace(10),
        Booster.textBody(context, text)
      ],
    );
  }
}

