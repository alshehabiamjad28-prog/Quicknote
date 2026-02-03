import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Color hexToColor(String hex) {
  hex = hex.replaceAll('#', '');
  return Color(int.parse('FF$hex', radix: 16));
}




// دالة لتحويل اللون من Hex إلى Color مع قيمة افتراضية
Color parseColor(String? colorHex, {Color defaultColor = Colors.white}) {
  if (colorHex == null || colorHex.isEmpty) {
    return defaultColor;
  }

  try {
    return Color(int.parse(colorHex.replaceFirst('#', '0xff')));
  } catch (e) {
    print("خطأ في تحويل اللون: $e");
    return defaultColor;
  }
}

DateTime parseDate(String dateString, {DateTime? defaultDate}) {
  try {
    final dateFormat = DateFormat('yyyy-MM-dd');
    return dateFormat.parse(dateString);
  } catch (e) {
    return defaultDate ?? DateTime.now();
  }
}




String formatDateLocalized(String dateString, BuildContext context) {
  try {
    DateTime date = DateTime.parse(dateString);
    final locale = Localizations.localeOf(context);

    return DateFormat.yMd(locale.toString()).format(date);
  } catch (e) {
    return dateString;
  }




}