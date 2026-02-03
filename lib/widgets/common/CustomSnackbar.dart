import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackbar {
  static void show({
    required String title,
    required String content,
    Color backgroundColor = Colors.green,
    Color textColor = Colors.white,
  }) {
    Get.snackbar(
      title,
      content,
      backgroundColor: backgroundColor,
      colorText: textColor,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(16),
      borderRadius: 12,
      duration: Duration(seconds: 3),
      animationDuration: Duration(milliseconds: 300),
      forwardAnimationCurve: Curves.easeOutCubic,
      reverseAnimationCurve: Curves.easeInCubic,
      icon: Icon(
        backgroundColor == Colors.green ? Icons.check_circle : Icons.error,
        color: Colors.white,
      ),
      shouldIconPulse: true,
    );
  }

  // اختصارات
  static void success({required String content}) {
    show(
      title: 'نجاح',
      content: content,
      backgroundColor: Colors.green,
    );
  }

  static void error({required String content}) {
    show(
      title: 'خطأ',
      content: content,
      backgroundColor: Colors.red,
    );
  }

  static void info({required String content}) {
    show(
      title: 'ملاحظة',
      content: content,
      backgroundColor: Colors.blue,
    );
  }
}