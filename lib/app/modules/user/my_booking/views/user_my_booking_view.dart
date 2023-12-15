import 'package:asas/app/data/model/booking.dart';
import 'package:asas/app/helpers/constance.dart';
import 'package:asas/app/theme/lightColors.dart';
import 'package:asas/app/widgets/booster.dart';
import 'package:asas/app/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../translations/strings_enum.dart';
import '../controllers/user_my_booking_controller.dart';

class UserMyBookingView extends GetView<UserMyBookingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Strings.Booking_requests.tr),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Booster.verticalSpace(10),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Booster.textTitle(
                  context, Strings.List_reservation_requests.tr,
                  color: LightColors.PRIMARY_COLOR),
            ),
            Booster.verticalSpace(10),
            Expanded(
              child: GetBuilder<UserMyBookingController>(builder: (ctrl) {
                if (ctrl.bookStatus == ApiCallStatus.success) {
                  return RefreshIndicator(
                    onRefresh: () => ctrl.onRefresh(),
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        controller: controller.bookScrollController,
                        itemCount: ctrl.bookList.length,
                        shrinkWrap: true,
                        primary: false,
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        itemBuilder: (context, index) => OrderListItem(
                              booking: ctrl.bookList[index],
                              onDeleteClicked: (index) =>
                                  ctrl.deleteBooking(index),
                              onRateClicked: (index) => ctrl
                                  .rateBooking(ctrl.bookList[index].companyId!),
                              index: index,
                              showCancelButton: ctrl.showCancelButton(
                                  ctrl.bookList[index].reservationStatusId!),
                              showRateButton: ctrl.showRateButton(
                                  ctrl.bookList[index].reservationStatusId!,
                                  index),
                              onTap: (booking) {
                                showBottom(context, booking);
                              },
                            )),
                  );
                } else if (ctrl.bookStatus == ApiCallStatus.loading) {
                  return LoadingList(
                    height: 120,
                  );
                } else if (ctrl.bookStatus == ApiCallStatus.failed) {
                  return Center(
                      child: Text(Strings.The_data_was_not_fetched.tr));
                } else {
                  // ctrl.sectionsStatus == ApiCallStatus.empty
                  return Center(
                      child: Text(
                    Strings.No_reservations.tr,
                  ));
                }
              }),
            )
          ],
        ));
  }
}

class OrderListItem extends StatelessWidget {
  final Booking booking;
  final int index;
  final Function onDeleteClicked;
  final Function onRateClicked;
  final bool showCancelButton;
  final bool showRateButton;
  final Function onTap;
  const OrderListItem(
      {Key? key,
      required this.booking,
      required this.onDeleteClicked,
      required this.index,
      required this.showCancelButton,
      required this.onRateClicked,
      required this.showRateButton,
      required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(booking),
      child: Container(
        height: 120,
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13),
            border: Border.all(color: LightColors.EDIT_BORDER_COLOR),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  offset: Offset(0, 0),
                  blurRadius: 8,
                  spreadRadius: 2)
            ]),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: 8,
                decoration: BoxDecoration(
                    color: LightColors.ACCENT_COLOR,
                    borderRadius: BorderRadiusDirectional.horizontal(
                        start: Radius.circular(13))),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: SvgPicture.asset('assets/svg/owner/card_zaz.svg'),
            ),
            Positioned(
              top: 5,
              bottom: 5,
              right: 8 + 10,
              left: 10,
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Booster.textBody(context, Strings.booking_date.tr),
                      Booster.textBody(context, Strings.student_name.tr),
                      Booster.textBody(context, Strings.name_corporation.tr),
                      Booster.textBody(context, Strings.the_program.tr),
                      Booster.textBody(context, Strings.Booking_Status.tr),
                    ],
                  ),
                  Booster.horizontalSpace(15),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Booster.textBody(
                                context, booking.createdAt!.split(' ').first,
                                color: LightColors.TEXT_PRIMARY_COLOR),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // if(showRateButton)
                                // SmallButton(title: 'تقييم', isPrimary: true, onClick: ()=> onRateClicked(index),),
                                Booster.horizontalSpace(5),
                                if (showCancelButton)
                                  SmallButton(
                                    title: Strings.Cancellation.tr,
                                    onClick: () => onDeleteClicked(index),
                                  )
                              ],
                            )
                          ],
                        ),
                        Booster.textBody(context, booking.childName!,
                            color: LightColors.TEXT_PRIMARY_COLOR),
                        Booster.textBody(context, booking.nameCompany!,
                            color: LightColors.TEXT_PRIMARY_COLOR),
                        Booster.textBody(context, booking.programNameAr!,
                            color: LightColors.TEXT_PRIMARY_COLOR),
                        Booster.textBody(
                            context, booking.reservationStatusStatusAr!,
                            color: LightColors.ICON_COLOR_GREEN,
                            fontWeight: FontWeight.bold),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

void showBottom(BuildContext context, Booking booking) {
  stat(String stg, String stg2, Color clr) {
    return Container(
        margin: EdgeInsets.only(top: 5, bottom: 5),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              children: [
                Booster.textBody(context, stg),
                Booster.textDetail(context, stg2, color: clr),
              ],
            ),
          ],
        ));
  }

  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      // enableDrag: true,
      // isScrollControlled: true,

      context: context,
      builder: (builder) {
        booking.discount ??= Strings.there_is_no_discount.tr;
        return Container(
          // margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3),

          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 223, 223, 223),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25), topLeft: Radius.circular(25))),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 55,
                    height: 8,
                    decoration: BoxDecoration(
                        color: LightColors.ACCENT_COLOR,
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Column(children: [
                  stat(
                      Strings.booking_date.tr,
                      booking.createdAt!.split(' ').first,
                      LightColors.TEXT_PRIMARY_COLOR),
                  stat(Strings.student_name.tr, booking.childName!,
                      LightColors.TEXT_PRIMARY_COLOR),
                  stat(Strings.name_corporation.tr, booking.nameCompany!,
                      LightColors.TEXT_PRIMARY_COLOR),
                  stat(Strings.the_program.tr, booking.programNameAr!,
                      LightColors.TEXT_PRIMARY_COLOR),
                  stat(
                    Strings.About_the_company.tr,
                    '${booking.descriptionProgramEn!.substring(0, 50)}\n'
                    '${booking.descriptionProgramEn!.substring(50, 100)}\n'
                    '${booking.descriptionProgramEn!.substring(100, 150)}\n'
                    '${booking.descriptionProgramEn!.substring(150, 200)}\n', // Continue as needed
                    LightColors.TEXT_PRIMARY_COLOR,
                  ),
                  stat(Strings.Evaluation.tr, booking.rateCompany!.toString(),
                      LightColors.TEXT_PRIMARY_COLOR),
                  stat(Strings.price.tr, booking.programPrice!.toString(),
                      LightColors.TEXT_PRIMARY_COLOR),
                  stat(Strings.The_current_discount_program.tr,
                      '${booking.discount!}%', LightColors.TEXT_PRIMARY_COLOR),
                  stat(
                    Strings.Booking_Status.tr,
                    booking.reservationStatusStatusAr!,
                    LightColors.ICON_COLOR_GREEN,
                  )
                ])
              ],
            ),
          ),
        );
      });
}

class SmallButton extends StatelessWidget {
  final String title;
  final Function onClick;
  final bool isPrimary;
  const SmallButton(
      {Key? key,
      required this.title,
      required this.onClick,
      this.isPrimary = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () => onClick(),
        borderRadius: BorderRadius.circular(3),
        child: Ink(
            height: 22,
            width: 60,
            decoration: BoxDecoration(
                color: isPrimary
                    ? LightColors.PRIMARY_COLOR
                    : LightColors.BUTTON_ACCENT_COLOR,
                borderRadius: BorderRadius.circular(3)),
            child: Center(
              child: Booster.textBody(context, title,
                  color: isPrimary
                      ? Colors.white
                      : LightColors.TEXT_SECONDARY_COLOR,
                  fontWeight: FontWeight.bold,
                  textSize: 11),
            )),
      ),
    );
  }
}
