import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import '../../core/constants/utils/extentions/Global_loc.dart';
void openColorPicker({
  required Rx<Color?> selectedColor,
}) {
  Get.dialog(
    AlertDialog(
      title:  Text(GlobalLoc.instance.chooseColor),
      content: SingleChildScrollView(
        child: ColorPicker(
          pickerColor: selectedColor.value ?? Colors.white, // قيمة افتراضية للعرض
          onColorChanged: (color) {
            selectedColor.value = color; // يمكن أن يكون null الآن
            print("اللون المختار: ${selectedColor.value}");
          },
          enableAlpha: false,
          displayThumbColor: true,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child:  Text(GlobalLoc.instance.done),
        ),
      ],
    ),
  );
}