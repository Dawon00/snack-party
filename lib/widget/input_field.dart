import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  const InputField({
    Key? key,
    required this.textEditingController,
    this.isPass = false,
    required this.hintText,
    this.textInputType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
      ),
      keyboardType: textInputType,
      controller: textEditingController,
      obscureText: isPass,
    );
  }
}
