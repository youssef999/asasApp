import 'package:asas/app/data/model/reservation.dart';
import 'package:asas/app/helpers/constance.dart';
import 'package:asas/app/routes/app_pages.dart';
import 'package:asas/app/theme/lightColors.dart';
import 'package:asas/app/translations/strings_enum.dart';
import 'package:asas/app/widgets/booster.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../../../../widgets/loading_widget.dart';
import '../controllers/owner_booking_requsets_controller.dart';

class OwnerBookingRequsetsView extends GetView<OwnerBookingRequsetsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.Booking_requests.tr),
        centerTitle: true,
      ),
      body: GetBuilder<OwnerBookingRequsetsController>(
        builder: (ctrl) {
          if(ctrl.reservationStatus == ApiCallStatus.success){
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,),
              child: RefreshIndicator(
                onRefresh: ()=> ctrl.onRefresh(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GridView(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(vertical: 25),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 10,
                          childAspectRatio: 2.5,
                          crossAxisSpacing: 10),
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      children: <Widget>[
                        ListItem(title: Strings.received.tr, count: ctrl.reservationResponse!.countStatus!.countReqBook.toString(), onClicked: ()=> ctrl.getReservationByStatusId(1, -1)),
                        ListItem(title: Strings.under_studying.tr, count: ctrl.reservationResponse!.countStatus!.countUnderStudying.toString(), onClicked: ()=> ctrl.getReservationByStatusId(1, ReservationStatus.underStudying)),
                        ListItem(title: Strings.acceptable.tr, count: ctrl.reservationResponse!.countStatus!.countAcceptable.toString(), onClicked: ()=> ctrl.getReservationByStatusId(1, ReservationStatus.acceptable)),
                        ListItem(title: Strings.rejected.tr, count: ctrl.reservationResponse!.countStatus!.countRejected.toString(), onClicked: ()=> ctrl.getReservationByStatusId(1, ReservationStatus.rejected)),
                        ListItem(title: Strings.canceled.tr, count: ctrl.reservationResponse!.countStatus!.countCanceled.toString(), onClicked: ()=> ctrl.getReservationByStatusId(1, ReservationStatus.canceled)),
                        ListItem(title: Strings.batch_confirmed.tr, count: ctrl.reservationResponse!.countStatus!.countBatchConfirmed.toString(), onClicked: ()=> ctrl.getReservationByStatusId(1, ReservationStatus.confirmedWithBatch)),
                      ],
                    ),
                    Divider(color: LightColors.BUTTON_DISABLED_COLOR),
                    Booster.verticalSpace(10),
                    Booster.textTitle(context, Strings.List_reservation_requests.tr, color: LightColors.PRIMARY_COLOR),
                    Booster.verticalSpace(10),
                    Expanded(
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          controller: controller.reservationScrollController,
                          itemCount: ctrl.reservationList.length,
                          shrinkWrap: true,
                          primary: false,
                          itemBuilder: (context, index) => OrderListItem(
                            reservation: ctrl.reservationList[index],
                            onDeleteClicked: (index)=> ctrl.deleteReservation(index),
                            index: index,
                            onDetailsClicked: (childProgId)=> ctrl.gotToDetailsPage(childProgId),
                            showCancelButton: ctrl.showCancelButton(ctrl.reservationList[index].reservationStatusId!),
                          )
                      ),
                    ),
                  ],
                ),
              ),
            );
          }else if(ctrl.reservationStatus == ApiCallStatus.loading){
            return LoadingList(
              height: 120,
            );
          }else if(ctrl.reservationStatus == ApiCallStatus.failed){
            return  Center(child: Text(Strings.The_data_was_not_fetched.tr));
          }else{
            // ctrl.sectionsStatus == ApiCallStatus.empty
            return  Center(child: Text(Strings.No_requests.tr));
          }
        }
      )
    );
  }
}

class OrderListItem extends StatelessWidget {
  final Reservation reservation;
  final int index;
  final bool showCancelButton;
  final Function onDeleteClicked;
  final Function onDetailsClicked;
  const OrderListItem({Key? key, required this.reservation, required this.index, required this.onDeleteClicked, required this.onDetailsClicked, required this.showCancelButton}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  borderRadius: BorderRadiusDirectional.horizontal(start: Radius.circular(13))
              ),
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
                          Booster.textBody(context, reservation.createdAt!.split(' ').first, color: LightColors.TEXT_PRIMARY_COLOR),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SmallButton(title: Strings.the_details.tr, onClick: ()=> onDetailsClicked(reservation.childProgId), isPrimary: true,),
                              Booster.horizontalSpace(5),
                              if(showCancelButton)
                              SmallButton(title: Strings.Cancellation.tr, onClick: ()=> onDeleteClicked(index),)
                            ],
                          )
                        ],
                      ),
                      Booster.textBody(context, reservation.childName!, color: LightColors.TEXT_PRIMARY_COLOR),
                      Booster.textBody(context, reservation.programNameAr!, color: LightColors.TEXT_PRIMARY_COLOR),
                      Booster.textBody(context, reservation.reservationStatusStatusAr! , color: LightColors.ICON_COLOR_GREEN, fontWeight: FontWeight.bold),
                    ],
                  ),
                ),
              ],
            ),
          )

        ],
      ),
    );
  }
}


class SmallButton extends StatelessWidget {
  final String title;
  final Function onClick;
  final bool isPrimary;
  const SmallButton({Key? key, required this.title, required this.onClick, this.isPrimary = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: ()=> onClick(),
        borderRadius: BorderRadius.circular(3),
        child: Ink(
          height: 22,
          width: 60,
          decoration: BoxDecoration(
            color: isPrimary ? LightColors.PRIMARY_COLOR : LightColors.BUTTON_ACCENT_COLOR,
            borderRadius: BorderRadius.circular(3)
          ),
          child: Center(
            child: Booster.textBody(context, title, color: isPrimary ? Colors.white : LightColors.TEXT_SECONDARY_COLOR, fontWeight: FontWeight.bold, textSize: 11),
          )
        ),
      ),
    );
  }
}


class ListItem extends StatelessWidget {
  final String title;
  final String count;
  final Function onClicked;
  const ListItem({Key? key, required this.title, required this.count, required this.onClicked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> onClicked(),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: LightColors.PRIMARY_COLOR
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Booster.textBody(context, title, color: Colors.white, textSize: 13, fontWeight: FontWeight.bold),
            Booster.textBody(context, count, color: Colors.white, textSize: 15),
          ],
        )
      ),
    );
  }
}
