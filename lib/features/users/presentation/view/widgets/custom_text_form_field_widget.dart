import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final String labelText;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatter;
  final String? Function(String)? validator;

  const CustomTextFormFieldWidget(
      {super.key,
      required this.controller,
      required this.labelText,
      this.hintText,
      required this.keyboardType,
      this.inputFormatter,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField();
  }
}
