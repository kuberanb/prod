import 'package:flutter/material.dart';
import 'package:prod/utils/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final double? height;
  final double width;
  final bool isObscure;
  final TextInputType keyboardType;
  final String? Function(String?)? validatorFunction;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
    this.height,
    required this.width,
    required this.isObscure,
    required this.validatorFunction,
    this.keyboardType = TextInputType.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      height: height,
      width: width,
      child: TextFormField(
        obscureText: isObscure,
        controller: controller,
        maxLines: 1,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          filled: true,
          fillColor: Colors.white,
          hintMaxLines: 1,
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(
              color: ktextFormFieldBorderColor,
              width: 1.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(
              color: ktextFormFieldBorderColor,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(
              color: ktextFormFieldBorderColor,
              width: 1.0,
            ),
          ),
        ),
        validator: validatorFunction,
      ),
    );
  }
}
