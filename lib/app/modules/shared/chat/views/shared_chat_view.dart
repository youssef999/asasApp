import 'package:asas/app/data/model/message.dart';
import 'package:asas/app/theme/lightColors.dart';
import 'package:asas/app/widgets/booster.dart';
import 'package:asas/app/widgets/custom_app_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../../translations/strings_enum.dart';
import '../controllers/shared_chat_controller.dart';

class SharedChatView extends GetView<SharedChatController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, controller.name),
      body: Container(
        margin: EdgeInsets.only(top: 10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35.0),
              topRight: Radius.circular(35.0)),
        ),
        child: Stack(
          children: <Widget>[
            GetBuilder<SharedChatController>(
              id: 'chat',
              builder: (context) {
                return Container(
                  margin: EdgeInsets.only(bottom: 50.0, top: 0),
                  child: ListView.builder(
                    itemCount: controller.messages.length,
                    shrinkWrap: true,
                    reverse: true,
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    itemBuilder: (context, index) => MessageItem(msg: controller.messages[index], screenSource: controller.screenSource,),
                  ),
                );
              }
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                margin: EdgeInsets.only(bottom: 10.0, right: 10.0, left: 10.0),
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    color: LightColors.EDIT_BORDER_COLOR.withOpacity(0.5),
                    border: Border.all(color: Colors.white, width: 2)),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 5, top: 5),
                      child: FloatingActionButton(
                        onPressed: () {
                          if (controller.msgController.text.trim().isNotEmpty) {
                            controller.sendMessages();
                          }
                        },
                        child: SvgPicture.asset(
                          "assets/svg/send_arrow.svg",
                          color: Colors.white,
                        ),
                        backgroundColor: LightColors.PRIMARY_COLOR,
                        elevation: 0,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: controller.msgController,
                        onSubmitted: (value){
                          if (controller.msgController.text.trim().isNotEmpty) {
                            controller.sendMessages();
                          }
                        },
                        style: TextStyle(
                          fontSize: 14.0,
                          fontFamily: 'JF'
                        ),
                        textInputAction: TextInputAction.send,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                            hintText: Strings.write_message.tr,
                            border: InputBorder.none),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}

class MessageItem extends StatelessWidget {
  final Message msg;
  final int screenSource; // 1 -> for Company  | 2 -> for User
  const MessageItem({Key? key, required this.msg, required this.screenSource}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 14),
        child: screenSource == 1 ?
        (
            msg.sender == "company"
            ? MyMessage(msg: msg,)
            : SenderMessage(msg: msg,)
        )
            :
        (
            msg.sender == "father"
                ? MyMessage(msg: msg,)
                : SenderMessage(msg: msg,)
        )
    );
  }
}

class MyMessage extends StatelessWidget {
  final Message msg;
  const MyMessage({Key? key, required this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsetsDirectional.only(end: MediaQuery.of(context).size.width * 0.2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(5),
                bottomLeft: Radius.circular(15),
                topLeft: Radius.circular(15),
                bottomRight: Radius.circular(15)),
            color: Theme.of(context).colorScheme.secondary.withAlpha(230),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 7),
          child: Text(
            msg.message ?? "",
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: 15, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class SenderMessage extends StatelessWidget {
  final Message msg;
  const SenderMessage({Key? key, required this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          margin: EdgeInsetsDirectional.only(start: MediaQuery.of(context).size.width * 0.2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
                bottomLeft: Radius.circular(15)),
            color: LightColors.PRIMARY_COLOR,
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 7),
          child: Booster.textBody(context, msg.message ?? "", color: Colors.white),
        ),
      ],
    );
  }
}


// class ListItem extends StatelessWidget {
//   const ListItem({Key? key,}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 80,
//       margin: EdgeInsets.symmetric(horizontal: 20,),
//       child: Row(
//         children: [
//           SizedBox(
//             height: 70,
//             width: 70,
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(100),
//               child: CachedNetworkImage(
//                 imageUrl: 'https://cdn.landesa.org/wp-content/uploads/default-user-image.png',
//                 progressIndicatorBuilder: (context, url, downloadProgress) =>
//                 const Center(child: CupertinoActivityIndicator()),
//                 errorWidget: (context, url, error) => Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12),
//                       color: LightColors.EDIT_BORDER_COLOR,
//                     ),
//                     child: Icon(
//                       Icons.error,
//                       color: LightColors.PRIMARY_COLOR,
//                     )),
//                 // width: 80,
//                 fit: BoxFit.fill,
//               ),
//             ),
//           ),
//           Booster.horizontalSpace(10),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Booster.textBody(context, Strings.Ahmed_Mohamed.tr, color: LightColors.TEXT_PRIMARY_COLOR, fontWeight: FontWeight.bold),
//                     Booster.textBody(context, "10:05")
//                   ],
//                 ),
//                 Booster.textBody(context, Strings.Hello_how_are_you.tr),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

