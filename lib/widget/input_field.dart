import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  final int minLines;
  final int maxLines;

  const InputField({
    Key? key,
    required this.textEditingController,
    required this.minLines,
    required this.maxLines,
    this.isPass = false,
    required this.hintText,
    this.textInputType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: hintText,
        hintText: hintText,
      ),
      keyboardType: textInputType,
      controller: textEditingController,
      maxLines: maxLines,
      minLines: minLines,
      obscureText: isPass,
    );
  }
}
