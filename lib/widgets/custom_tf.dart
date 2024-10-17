import 'package:flutter/material.dart';
import 'package:music_app/values/color_scheme.dart';
import 'package:music_app/values/styles.dart';

class CustomTextFieldWidget extends StatelessWidget {
  String? hintText;
  TextStyle? style =
      const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w700);
  Widget? suffixxIcon;

  TextInputType? keyboard;
  TextEditingController? controller;
  final FormFieldValidator<String>? validation;
  final void Function(String)? onChanged;
  final bool readOnly;
  int? maxLines;
  TextCapitalization? textCapitalization;

  CustomTextFieldWidget({
    super.key,
    this.hintText,
    this.style,
    this.suffixxIcon,
    this.keyboard,
    this.controller,
    this.onChanged,
    this.validation,
    this.onSaved,
    this.textCapitalization,
    this.readOnly= false,
    this.maxLines=1
     
  });

  FormFieldSetter<String>? onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines:maxLines ,
      readOnly: readOnly,
      validator: validation,
      controller: controller,
      onChanged: onChanged,
      onSaved: onSaved,
      cursorColor: Colors.white,
      
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      autofocus: false,
      style: Styles.customTextStylePopins(fontSize: 16,color: Colors.white),
      keyboardType: keyboard,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        filled: true,
        fillColor: CustomColorScheme.textFieldColor,
        hintText: hintText,
        suffixIconConstraints: const BoxConstraints(
          maxHeight: 24,
          maxWidth: 24,
        ),
        suffixIcon: suffixxIcon,
        hintStyle: style,
        border: InputBorder.none,
      
       enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0), // Set rounded corners
          borderSide: const BorderSide(color: CustomColorScheme.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0), // Set rounded corners
          borderSide: const BorderSide(color: CustomColorScheme.white),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0), // Set rounded corners
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0), // Set rounded corners
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
