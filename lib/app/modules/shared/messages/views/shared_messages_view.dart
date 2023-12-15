import 'package:asas/app/data/model/main_chat.dart';
import 'package:asas/app/helpers/constance.dart';
import 'package:asas/app/routes/app_pages.dart';
import 'package:asas/app/theme/lightColors.dart';
import 'package:asas/app/widgets/booster.dart';
import 'package:asas/app/widgets/custom_app_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../translations/strings_enum.dart';
import '../controllers/shared_messages_controller.dart';

class SharedMessagesView extends GetView<SharedMessagesController> {
  @override
  Widget build(BuildContext context) {
    controller.getChatList();
    return Scaffold(
      appBar: customAppBar(context, Strings.Messages.tr),
      body: GetBuilder<SharedMessagesController>(
        builder: (ctrl) {
          if(ctrl.status == ApiCallStatus.loading){
            return Center(
              child: CupertinoActivityIndicator(),
            );
          }
          if(ctrl.status == ApiCallStatus.empty){
            return Center(
              child: Booster.textBody(context, "لا يوجد أي محادثات"),
            );
          }
          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: ctrl.list.length,
            padding: EdgeInsets.only(top: 25),
            separatorBuilder: (context, index) => Divider(color: Colors.grey.withOpacity(0.5)),
            itemBuilder: (context, index)=> ListItem(
              main: ctrl.list[index],
              screenSource: controller.screenSource,
              onClicked: ()=> Get.toNamed(Routes.SHARED_CHATE, arguments:
              [
                controller.screenSource,
                controller.screenSource == 2 ? int.parse(ctrl.list[index].idCompany!) : int.parse(ctrl.list[index].idFather!),
                controller.screenSource == 1 ? ctrl.list[index].name! : ctrl.list[index].nameCorporation!]
              ), // screenSource, userID, userName
            )
          );
        }
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final Function onClicked;
  final MainChat main;
  final int screenSource;
  const ListItem({Key? key, required this.onClicked, required this.main, required this.screenSource}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> onClicked(),
      child: Container(
        height: 80,
        color: Colors.white,
        margin: EdgeInsets.symmetric(horizontal: 20,),
        child: Row(
          children: [
            SizedBox(
              height: 70,
              width: 70,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                  imageUrl: 'https://cdn.landesa.org/wp-content/uploads/default-user-image.png',
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                  const Center(child: CupertinoActivityIndicator()),
                  errorWidget: (context, url, error) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: LightColors.EDIT_BORDER_COLOR,
                      ),
                      child: Icon(
                        Icons.error,
                        color: LightColors.PRIMARY_COLOR,
                      )),
                  // width: 80,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Booster.horizontalSpace(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Booster.textBody(context, screenSource == 1 ? main.name! : main.nameCorporation!, color: LightColors.TEXT_PRIMARY_COLOR, fontWeight: FontWeight.bold),
                     if(main.isRead == 0)
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(100)
                        ),
                      )
                    ],
                  ),
                  Booster.textBody(context, main.message ??"..."),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

