import 'package:asas/app/theme/lightColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../translations/strings_enum.dart';


class PhoneInput extends StatelessWidget {
  final TextEditingController? controller;
  final String? initialCountryCode;
  final bool haseFormGroup;
  const PhoneInput({Key? key, this.controller, this.haseFormGroup = true, this.initialCountryCode = 'PS'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: IntlPhoneField(
        textAlign: TextAlign.right,
        dropdownTextStyle: Theme.of(context).textTheme.bodyLarge,
        onChanged: (value) {
          if(haseFormGroup){
            (ReactiveForm.of(context) as FormGroup).controls['phone']!.value = value.completeNumber;
          }else{
            controller!.text = value.completeNumber;
          }
        },
        cursorColor: Get.theme.colorScheme.secondary,
        initialCountryCode: initialCountryCode,
        //initialValue: controller!.text,
        isArabic: true,
        dropdownIconPosition: IconPosition.leading,
        decoration: InputDecoration(
          counterText: "",
          counterStyle: Theme.of(context).textTheme.bodyLarge,
            errorStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.redAccent),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            hintText: Strings.Telephone_number.tr,
            hintStyle: TextStyle(color: LightColors.TEXT_HINT_COLOR, fontSize: 14.0),
            filled: true,
            fillColor: LightColors.EDIT_BACKGROUND_COLOR,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: LightColors.EDIT_BORDER_FOCUSED_COLOR ),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              //borderSide: BorderSide(color: Colors.white),
              borderSide: BorderSide(color: Colors.grey[300]!),
            )),
        style: Theme.of(context).textTheme.bodyLarge,
        // searchText: "إسم الدولة",
        pickerDialogStyle: PickerDialogStyle(searchFieldInputDecoration: InputDecoration(labelText: Strings.Name_country.tr)),
        invalidNumberMessage: Strings.Invalid_phone_number.tr,
        keyboardType: TextInputType.phone,
      ),
    );
  }
}
