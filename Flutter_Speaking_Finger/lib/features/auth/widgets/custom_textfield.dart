import 'package:flutter/material.dart';

import '../../../core/theming/text_styles.dart';


class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      this.controller,
      this.suffixIcon,
      this.onTapIcon,
      this.obscureText = false,
      required this.valid,
      required this.isNumber,
      this.text,
      this.readOnly = false});
  final TextEditingController? controller;
  final IconData? suffixIcon;
  final void Function()? onTapIcon;
  final bool? obscureText;
  final String? text;
  final String? Function(String?) valid;
  final bool isNumber;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      
      keyboardType: isNumber == true
          ? const TextInputType.numberWithOptions(decimal: true)
          : TextInputType.text,
      validator: valid,
      obscureText: obscureText ?? false,
      controller: controller,
      style:TextStyles.font14BlackLight,
      cursorColor: Colors.grey,
      decoration: InputDecoration(
        hintText: text,
        contentPadding: EdgeInsets.all(10),
        suffixIcon: InkWell(
          onTap: onTapIcon,
          child: Icon(suffixIcon,
        color: Colors.grey,
          ),
        ),
        focusColor: Colors.grey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey.withOpacity(.14),
      ),
      readOnly: readOnly ?? false,
    );
  }
}
