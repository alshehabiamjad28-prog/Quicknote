import 'dart:typed_data';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:myproject/widgets/common/Custom_Dialog.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/extentions/Global_loc.dart';


class NotificationHelper {


  // ========================
  // 📌 1. التهيئة والإعداد
  // ========================
  /// تهيئة قنوات الإشعارات (تنفذ مرة واحدة في main.dart)
  Future<bool> initialize() async {
    try {
      await AwesomeNotifications().initialize(
        null,
        [
          NotificationChannel(
            channelKey: 'basic_channel',
            channelName: 'التنبيهات الأساسية',
            channelDescription: 'قناة الإشعارات الرئيسية',
            defaultColor: Colors.blue,
            ledColor: Colors.white,
            channelShowBadge: true,
            importance: NotificationImportance.High,
            playSound: true,
            enableVibration: true,
            vibrationPattern: Int64List.fromList([200, 100, 200]),
          ),
          NotificationChannel(
            channelKey: 'scheduled_channel',
            channelName: 'الإشعارات المجدولة',
            channelDescription: 'قناة للإشعارات المجدولة مسبقاً',
            defaultColor: Colors.green,
            ledColor: Colors.white,
            channelShowBadge: true,
            importance: NotificationImportance.High,
            playSound: true,
            enableVibration: true,
            vibrationPattern: Int64List.fromList([200, 100, 200]),
          ),
        ],
      );
      print('✅ تم تهيئة الإشعارات بنجاح');
      return true;
    } catch (e) {
      print('❌ فشل تهيئة الإشعارات: ${e.toString()}');
      return false;
    }
  }

  // ========================
  // 📌 2. عمليات الإضافة
  // ========================

  /// إضافة إشعار مجدول (للتذكير بالمهام)
  Future<bool> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime, // ⬅️ تغيير String → DateTime
  }) async {
    try {
      // ⭐⭐ الآن scheduledTime هو DateTime مباشرة
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: id,
          channelKey: 'scheduled_channel',
          title: title,
          body: body,
        ),
        schedule: NotificationCalendar(
          year: scheduledTime.year,
          month: scheduledTime.month,
          day: scheduledTime.day,
          hour: scheduledTime.hour,
          minute: scheduledTime.minute,
          second: 0,
          millisecond: 0,
          repeats: true,
        ),
      );

      print('✅ تم جدولة الإشعار بنجاح (ID: $id) للوقت: $scheduledTime');
      return true;
    } catch (e) {
      print('❌ فشل جدولة الإشعار: ${e.toString()}');
      return false;
    }
  }

  // ========================
// 📌 3. عمليات التعديل
// ========================
  /// تعديل إشعار مجدول (تلغي القديم وتضيف الجديد)
  Future<bool> updateScheduledNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime, // ⬅️ تغيير String → DateTime
  }) async {
    try {
      // 1. إلغاء الإشعار القديم
      await AwesomeNotifications().cancel(id);
      print('📝 تم إلغاء الإشعار القديم (ID: $id)');

      // 2. ⭐⭐ scheduledTime هو DateTime بالفعل (لا حاجة لتحويل)

      // 3. إضافة الإشعار الجديد
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: id,
          channelKey: 'scheduled_channel',
          title: title,
          body: body,
        ),
        schedule: NotificationCalendar(
          year: scheduledTime.year,
          month: scheduledTime.month,
          day: scheduledTime.day,
          hour: scheduledTime.hour,
          minute: scheduledTime.minute,
          second: 0,
          // ⭐ استخدم 0 بدلاً من scheduledTime.second
          millisecond: 0,
          repeats: true,
        ),
      );

      print('✅ تم تحديث الإشعار المجدول بنجاح (ID: $id) للوقت: $scheduledTime');
      return true;
    } catch (e) {
      print('❌ فشل تحديث الإشعار المجدول: ${e.toString()}');
      return false;
    }
  }

  // ========================
  // 📌 4. عمليات الحذف
  // ========================
  /// حذف إشعار مجدول محدد
  Future<bool> cancelNotification(int id) async {
    try {
      await AwesomeNotifications().cancel(id);
      print('🗑️ تم حذف الإشعار (ID: $id)');
      return true;
    } catch (e) {
      print('❌ فشل حذف الإشعار: ${e.toString()}');
      return false;
    }
  }

  /// حذف جميع الإشعارات
  Future<bool> cancelAllNotifications() async {
    try {
      await AwesomeNotifications().cancelAll();
      print('🗑️ تم حذف جميع الإشعارات');
      return true;
    } catch (e) {
      print('❌ فشل حذف جميع الإشعارات: ${e.toString()}');
      return false;
    }
  }

  // ========================
  // 📌 5. أدوات مساعدة
  // ========================
  /// تحويل نص التاريخ إلى DateTime
  DateTime parseDate(String dateString) {
    try {
      return DateTime.parse(dateString);
    } catch (e) {
      print('⚠️ تحذير: تاريخ غير صحيح، استخدام التاريخ الافتراضي');
      return DateTime.now().add(const Duration(days: 1));
    }
  }

  ////////////////////////////////////


  Widget _buildStep(String emoji, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 10),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }


  void requestPermission() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) async {
      if (!isAllowed) {
        CustomDialog.show(title: GlobalLoc.instance.notificationsDisabled,
          middleText: GlobalLoc.instance.enableFromSettings,
          textCancel:GlobalLoc.instance. cancel,
          textConfirm:GlobalLoc.instance.enable ,
          onCancel: () {

          },
          onConfirm: () =>
              AwesomeNotifications()
                  .requestPermissionToSendNotifications(),


        );
      }
    },
    );
  }


}