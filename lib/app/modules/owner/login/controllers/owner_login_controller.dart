import 'package:asas/app/data/repository/auth_repository.dart';
import 'package:asas/app/helpers/custom_loading.dart';
import 'package:asas/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../translations/strings_enum.dart';

class OwnerLoginController extends GetxController {
  final form = FormGroup({
    'name': FormControl<String>(validators: [Validators.required]),
    'password': FormControl<String>(validators: [Validators.required, Validators.minLength(8)])
  });


  login() async {
    if(!form.valid){
      CustomLoading.showWrongToast(msg: Strings.All_fields_entered.tr);
      return;
    }

    final isLogged = await AuthRepository().login(form.rawValue['name']!.toString().trim(), form.rawValue['password']!.toString());

    if(isLogged){
      Get.offAllNamed(Routes.OWNER_BASE_DRAWER);
    }
  }

  @override
  void onInit() {
    super.onInit();
  }


  @override
  void onClose() {
    form.dispose();
  }
}
