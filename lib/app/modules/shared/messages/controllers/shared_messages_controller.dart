import 'package:asas/app/data/model/main_chat.dart';
import 'package:asas/app/data/repository/portal_repository.dart';
import 'package:asas/app/data/repository/user_repository.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../../helpers/constance.dart';

class SharedMessagesController extends GetxController {

  late int screenSource; // 1 -> for Company  | 2 -> for User

  List<MainChat> list = [];
  ApiCallStatus status = ApiCallStatus.loading;

  getChatList() async {
    Logger().w(screenSource);
    if(screenSource == 2){
      final result = await UserRepository().getChatList();
      if(result != null && result.isNotEmpty){
        list = result;
        status = ApiCallStatus.success;
      }else{
        status = ApiCallStatus.empty;
      }
    }else if(screenSource == 1){
      final result = await PortalRepository().getChatList();
      if(result != null && result.isNotEmpty){
        list = result;
        status = ApiCallStatus.success;
      }else{
        status = ApiCallStatus.empty;
      }
    }
    update();
  }



  @override
  void onInit() {
    super.onInit();
    screenSource = Get.arguments[0];

  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
