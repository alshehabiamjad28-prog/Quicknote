import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDialog {
  static void show({
    required String title,
    required String middleText,
    String textConfirm = 'موافق',
    String textCancel = 'إلغاء',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool showCancel = true,
    bool destructiveAction = false,
  }) {
    final colorScheme = Get.theme.colorScheme;
    final textTheme = Get.textTheme;

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        backgroundColor: colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // العنوان
              Text(
                title,
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 16),

              // النص الرئيسي
              Text(
                middleText,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.8),
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 24),

              // الأزرار
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (showCancel)
                    TextButton(
                      onPressed: () {
                        // ✅ أولاً: إغلاق الدايلوج
                        Get.back();
                        // ✅ ثم: تنفيذ الدالة إذا كانت موجودة
                        onCancel?.call();
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: colorScheme.onSurface,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                      child: Text(textCancel),
                    ),

                  const SizedBox(width: 12),

                  ElevatedButton(
                    onPressed: () {
                      // ✅ أولاً: إغلاق الدايلوج
                      Get.back();
                      // ✅ ثم: تنفيذ الدالة إذا كانت موجودة
                      onConfirm?.call();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: destructiveAction
                          ? colorScheme.error
                          : colorScheme.primary,
                      foregroundColor: destructiveAction
                          ? colorScheme.onError
                          : colorScheme.onPrimary,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(textConfirm),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true, // ✅ يسمح بالإغلاق بالضغط خارج الدايلوج
    );
  }
}