import 'package:asas/app/data/model/my_notification.dart';
import 'package:asas/app/helpers/constance.dart';
import 'package:asas/app/theme/lightColors.dart';
import 'package:asas/app/widgets/booster.dart';
import 'package:asas/app/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../translations/strings_enum.dart';
import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.Notification.tr
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: GetBuilder<NotificationController>(
          builder: (ctrl) {
            if(ctrl.notificationStatus == ApiCallStatus.success){
              return RefreshIndicator(
                onRefresh: ()=> ctrl.getNotifications(1),
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: controller.notificationScrollController,
                    itemCount: ctrl.notificationList.length,
                    shrinkWrap: true,
                    primary: false,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) => ListItem(myNotification: ctrl.notificationList[index],)
                ),
              );
            }else if(ctrl.notificationStatus == ApiCallStatus.loading){
              return LoadingList(
                height: 75,
              );
            }else if(ctrl.notificationStatus == ApiCallStatus.failed){
              return  Center(child: Text(Strings.The_data_was_not_fetched.tr));
            }else{
              // ctrl.sectionsStatus == ApiCallStatus.empty
              return  Center(child: Text(Strings.No_notifications.tr));
            }
          },
        ),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final MyNotification myNotification;
  const ListItem({Key? key, required this.myNotification}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    try{
      myNotification.createdAt = DateFormat('dd/MM/yyyy - hh:mm a').format(DateFormat("yyyy-MM-ddTHH:mm:ss.SSSSSS'Z").parse(myNotification.createdAt!));
    }catch(_){}

    return Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            color: myNotification.isRead! ? Colors.transparent : LightColors.PRIMARY_COLOR.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: LightColors.EDIT_BORDER_COLOR)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Booster.textBody(context, myNotification.title ?? "",color: LightColors.PRIMARY_COLOR, fontWeight: FontWeight.bold, textSize: 16),
                ),
                Row(
                  children: [
                    Icon(Icons.access_time, color: LightColors.TEXT_SECONDARY_COLOR, size: 14),
                    Booster.horizontalSpace(5),
                    Booster.textBody(context, myNotification.createdAt ?? "", textSize: 10),
                  ],
                )
              ],
            ),
            Booster.verticalSpace(10),
            Booster.textBody(context, myNotification.body ?? "")
          ],
        )
    );
  }
}
