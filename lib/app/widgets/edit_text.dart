import 'package:asas/app/theme/lightColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../translations/strings_enum.dart';


class EditText extends StatelessWidget {
  final String hint;
  final String controlName;
  final bool isSecure;
  final bool multiline;
  final int lines;
  final bool isReadonly;
  final bool hasBorder;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final Color color;
  final double horizontal;
  final String? autofillHints;
  final bool finishAutofill;
  final double vertical;

  EditText(
      {required this.hint,
      required this.controlName,
      this.isSecure = false,
      this.multiline = false,
      this.lines = 3,
      this.inputType,
      this.isReadonly = false,
      this.inputAction,
      this.color = LightColors.EDIT_BACKGROUND_COLOR,
      this.hasBorder = true,
      this.horizontal = 16,
        this.autofillHints,
        this.finishAutofill = false,
      this.vertical = 8});

  @override
  Widget build(BuildContext context) {
    final textInputType = multiline ? TextInputType.multiline : TextInputType.text ;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReactiveTextField(
            minLines: multiline ? lines : 1,
            maxLines: multiline ? null : 1,
            keyboardType: inputType ?? textInputType,
            textInputAction: inputAction ?? TextInputAction.next,
            readOnly: isReadonly,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.normal),
            autofillHints: autofillHints == null ? null : [autofillHints!],
            onEditingComplete: !finishAutofill ? null : ()=> TextInput.finishAutofillContext(),
            decoration: InputDecoration(
                labelText: autofillHints == null ? null :hint,
                errorStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.redAccent),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: hint,
                hintStyle: TextStyle(color: LightColors.TEXT_HINT_COLOR, fontSize: 14.0),
                filled: true,
                fillColor: color,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: hasBorder ? LightColors.EDIT_BORDER_FOCUSED_COLOR : color),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  //borderSide: BorderSide(color: Colors.white),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                )),
            obscureText: isSecure,
            formControlName: controlName,
            showErrors: (control) => control.invalid && control.touched && control.dirty,
            validationMessages: (control) => {
              ValidationMessage.required: Strings.This_field_required.tr,
              ValidationMessage.email: Strings.Incorrect_mail_entry.tr,
              ValidationMessage.minLength: Strings.Password_less_characters.tr,
              ValidationMessage.mustMatch: Strings.Password_does_not_match.tr,
            },
          ),
        ],
      ),
    );
  }
}
