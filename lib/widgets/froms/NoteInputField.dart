import 'package:flutter/material.dart';

class NoteInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isTitle;
  final int? maxLines;
  final double? width;

  const NoteInputField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.isTitle = false,
    this.maxLines,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      width: this.width ?? width * 0.9,
      margin: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          fillColor: Colors.red,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: width * 0.04,
            vertical: width * 0.03,
          ),
        ),
        style: TextStyle(
          fontSize: isTitle ? width * 0.06 : width * 0.045,
          fontWeight: isTitle ? FontWeight.bold : FontWeight.normal,
        ),
        maxLines: maxLines,
        keyboardType: TextInputType.multiline,
      ),
    );
  }
}