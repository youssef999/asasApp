import 'package:asas/app/data/model/agreements.dart';
import 'package:asas/app/data/repository/portal_repository.dart';
import 'package:asas/app/helpers/constance.dart';
import 'package:get/get.dart';

class OwnerAgreementController extends GetxController {

  List<Agreement> agreement = [];
  ApiCallStatus agreementStatus = ApiCallStatus.loading;


  getAgreements() async {
    agreementStatus = ApiCallStatus.loading;
    update();
    final result = await PortalRepository().getAgreements();
    if(result == null){
      agreementStatus = ApiCallStatus.failed;
    }else if(result.isNotEmpty){
      agreementStatus = ApiCallStatus.success;
      agreement = result;
    }else{
      agreementStatus = ApiCallStatus.empty;
    }
    update();
  }

  @override
  void onInit() {
    getAgreements();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
