import 'package:asas/app/data/model/message.dart';
import 'package:asas/app/data/repository/portal_repository.dart';
import 'package:asas/app/data/repository/user_repository.dart';
import 'package:asas/app/helpers/custom_loading.dart';
import 'package:asas/app/helpers/owner_shared_pref.dart';
import 'package:asas/app/helpers/sharedPref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SharedChatController extends GetxController {
  late TextEditingController msgController;
  late int screenSource; // 1 -> for Company  | 2 -> for User
  late int id;
  late String name;
  late int myId;

  List<Message> messages = [];

  getMessages() async {
    CustomLoading.showLoading();
    if (screenSource == 1) {
      final data = await PortalRepository().getChat(myId, id);
      if (data != null) {
        messages = data;
        // messages = messages.reversed.toList();
      }
    } else {
      final data = await UserRepository().getChat(id, myId);
      if (data != null) {
        messages = data;
        // messages = messages.reversed.toList();
      }
    }
    CustomLoading.cancelLoading();
    update(['chat']);
  }

  sendMessages() async {
    CustomLoading.showLoading();
    print("asshole");
    try {
      if (screenSource == 1) {
        final result = await PortalRepository()
            .sendMessage(myId, id, msgController.text, 'company');
        if (result) {
          messages.insert(
              0,
              Message(
                id: 0,
                idCompany: myId.toString(),
                idFather: id.toString(),
                message: msgController.text,
                sender: 'company',
              ));
          msgController.clear();
        }
      } else {
        final result = await UserRepository()
            .sendMessage(id, myId, msgController.text, 'father');
        if (result) {
          messages.insert(
              0,
              Message(
                id: 0,
                idCompany: id.toString(),
                idFather: myId.toString(),
                message: msgController.text,
                sender: 'father',
              ));
          msgController.clear();
        }
      }
      CustomLoading.cancelLoading();
      update(['chat']);
    } catch (e) {
      print("ddllk err $e");
    }
  }

  @override
  void onInit() {
    super.onInit();
    screenSource = Get.arguments[0];
    id = Get.arguments[1];
    name = Get.arguments[2];

    if (screenSource == 1) {
      myId = OwnerSharedPref.getUserData()!.id!;
    } else {
      myId = PreferenceUtils.getUserData()!.id!;
    }
    getMessages();
    msgController = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    msgController.dispose();
  }
}
