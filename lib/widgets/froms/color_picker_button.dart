import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerButton extends StatelessWidget {
  final ValueNotifier<String> colorNotifier;
  final IconData icon;
  final double size;

  const ColorPickerButton({
    Key? key,
    required this.colorNotifier,
    this.icon = Icons.color_lens_outlined,
    this.size = 24.0,
  }) : super(key: key);

  Future<void> _showColorPicker(BuildContext context) async {
    Color currentColor = Color(int.parse(colorNotifier.value.replaceFirst('#', '0xff')));

    final Color? pickedColor = await showDialog<Color>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('اختر لون الكارد'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: currentColor,
              onColorChanged: (color) {
                currentColor = color;
              },
              pickerAreaHeightPercent: 0.7,
              enableAlpha: false,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('إلغاء'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, currentColor),
              child: Text('موافق'),
            ),
          ],
        );
      },
    );

    if (pickedColor != null) {
      String hexColor = '#${pickedColor.value.toRadixString(16).substring(2)}';
      colorNotifier.value = hexColor; // التحديث التلقائي
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: colorNotifier,
      builder: (context, colorValue, child) {
        return IconButton(
          icon: Icon(
            icon,
            size: size,
          ),
          onPressed: () => _showColorPicker(context),
        );
      },
    );
  }
}