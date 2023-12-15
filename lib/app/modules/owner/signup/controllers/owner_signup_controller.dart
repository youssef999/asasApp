import 'package:asas/app/data/repository/auth_repository.dart';
import 'package:asas/app/helpers/custom_loading.dart';
import 'package:asas/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../translations/strings_enum.dart';

class OwnerSignupController extends GetxController {
  final form = FormGroup({
    'name': FormControl<String>(validators: [Validators.required]),
    'name_corporation': FormControl<String>(validators: [Validators.required]),
    'name_corporation_ar': FormControl<String>(validators: [Validators.required]),
    'phone': FormControl<String>(validators: [Validators.required]),
    'password': FormControl<String>(validators: [Validators.required, Validators.minLength(8)]),
    're_password': FormControl<String>()
  },
      validators: [Validators.mustMatch('password', 're_password'),]
  );


  signup() async {
    //Get.toNamed(Routes.OWNER_OTP),
    if(!form.valid){
      CustomLoading.showWrongToast(msg: Strings.All_fields_entered.tr);
      return;
    }

    final isLogged = await AuthRepository().ownerSignup(
        form.rawValue['name']!.toString().trim(),
        form.rawValue['name_corporation']!.toString().trim(),
        form.rawValue['name_corporation_ar']!.toString().trim(),
        form.rawValue['phone']!.toString().trim(),
        form.rawValue['password']!.toString().trim()
    );

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

  }
}
