import 'package:get/get.dart';
import '../../core/constants/services/notification_helper.dart';
import '../../core/constants/utils/extentions/Global_loc.dart';
import '../../data/models/notification_model.dart';
import '../../data/repositories/notification_repository.dart';


class NotificationsController extends GetxController {
  final NotificationsRepository _repo = NotificationsRepository();
  final NotificationHelper _nh = NotificationHelper();

  final notifications = <NotificationModel>[].obs;
  final notificationsByID = <NotificationModel>[].obs;

  final isload = false.obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await inil();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
  //////////////////////////////////////////
  /////////////////////////////////////



  ///////////////////////////////////////
  Future<bool> addNotification(
    String title,
    String body,
    String scheduledTime,
    int noteId,
  ) async {
    try {
      // تحويل التاريخ
      DateTime convertedTime = DateTime.fromMillisecondsSinceEpoch(
        int.parse(scheduledTime),
      );

      // إضافة الإشعار
      final notificationId = await _repo.addNotification(
        title: title,
        body: body,
        scheduledTime: convertedTime,
        noteId: noteId,
      );

      // التحقق من النتيجة
      if (notificationId > 0) {
        await _nh.scheduleNotification(
          id: noteId,
          title: title,
          body: body,
          scheduledTime: convertedTime,
        );
        await inil();
        Get.showSnackbar(
          GetSnackBar(
            title: GlobalLoc.instance.success,
            message: GlobalLoc.instance.notificationsEnabledSuccess,
            duration: Duration(seconds: 2),
          ),
        );
        return true;
      } else {
        Get.showSnackbar(
          GetSnackBar(
            title: GlobalLoc.instance.failed,
            message: GlobalLoc.instance.addNotificationFailed,
            duration: Duration(seconds: 2),
          ),
        );
      }
      return false;
    } catch (e) {
      print("خطأ في addNotification: ${e.toString()}");
      Get.showSnackbar(
        GetSnackBar(
          title: GlobalLoc.instance.failed,
          message: GlobalLoc.instance.addNotificationFailed,
          duration: Duration(seconds: 2),
        ),
      );
      return false;
    }
  }

  Future<bool> updateNotificationForNote(
    String title,
    String body,
    String scheduledTime,
    int noteId,
  ) async {
    try {
      // تحويل التاريخ
      DateTime convertedTime = DateTime.fromMillisecondsSinceEpoch(
        int.parse(scheduledTime),
      );

      // تحديث الإشعار - الدالة ترجع bool
      final bool success = await _repo.updateNotificationForNote(
        noteId: noteId,
        title: title,
        body: body,
        scheduledTime: convertedTime,
      );

      // التحقق من النتيجة (success هي bool بالفعل)
      if (success) {
        await _nh.updateScheduledNotification(
          id: noteId,
          title: title,
          body: body,
          scheduledTime: convertedTime,
        );
        await inil();
        // ✅ تغيير هنا
        Get.showSnackbar(
          GetSnackBar(
            title: GlobalLoc.instance.success,
            message: GlobalLoc.instance.notificationsEnabledSuccess,
            duration: Duration(seconds: 2),
          ),
        );
        return true;
      } else {
        Get.showSnackbar(
          GetSnackBar(
            title: GlobalLoc.instance.failed,
            message: GlobalLoc.instance.addNotificationFailed,
            duration: Duration(seconds: 2),
          ),
        );
      }
      return false;
    } catch (e) {
      print(
        "خطأ في updateNotificationForNote: ${e.toString()}",
      ); // ✅ تغيير الاسم
      Get.showSnackbar(
        GetSnackBar(
          title: GlobalLoc.instance.failed,
          message: GlobalLoc.instance.addNotificationFailed,
          duration: Duration(seconds: 2),
        ),
      );
      return false;
    }
  }

  // 1. حذف إشعارات ملاحظة
  Future<bool> deleteNotificationsForNote(int noteId) async {
    try {
      final bool success = await _repo.deleteNotificationsForNote(noteId);

      if (success) {
        await _nh.cancelNotification(noteId);
        await inil();

        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("خطأ في deleteNotificationsForNote: ${e.toString()}");
      return false;
    }
  }

  ///////////////////
  // 1. حذف إشعارات ملاحظة
  Future<bool> deleteNotificationsForId(int id) async {
    try {
      final bool success = await _repo.deleteNotificationsForId(id);

      if (success) {
        await _nh.cancelNotification(id);
        await inil();

        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("خطأ في deleteNotificationsForNote: ${e.toString()}");
      return false;
    }
  }

  // 2. حذف جميع الإشعارات
  Future<bool> deleteAllNotifications() async {
    try {
      final bool success = await _repo.deleteAllNotifications();

      if (success) {
        await _nh.cancelAllNotifications();
        await inil();

        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("خطأ في deleteAllNotifications: ${e.toString()}");
      Get.showSnackbar(
        GetSnackBar(
          title: 'خطأ',
          message: 'حدث خطأ في حذف جميع الإشعارات: ${e.toString()}',
          duration: Duration(seconds: 3),
        ),
      );
      return false;
    }
  }

  // 3. التحقق من وجود إشعارات لملاحظة
  // في NotificationsController
  Future<bool> hasNoteNotifications(int noteId) async {
    return await _repo.hasNoteNotifications(noteId);
  }

  // 5. جلب جميع الإشعارات ← List<NotificationModel>

  Future<List<NotificationModel>> getAllNotifications() async {
    try {
      isload(true);
      notifications.value = await _repo.getAllNotifications();
      return notifications.value;
    } catch (e) {
      print("خطأ في getAllNotifications: ${e.toString()}");
      return [];
    } finally {
      isload(false);
    }
  }

  // 8. جلب إشعارات ملاحظة محددة ← List<NotificationModel>
  Future<List<NotificationModel>> getNotificationsByNoteId(int? noteid) async {
    try {
      isload(true);
      notificationsByID.value = await _repo.getNotificationsByNoteId(noteid);
      return notificationsByID.value;
    } catch (e) {
      print("خطأ في getAllNotifications: ${e.toString()}");
      return [];
    } finally {
      isload(false);
    }
  }

  Future<void> inil() async {
    await getAllNotifications();
  }
}
