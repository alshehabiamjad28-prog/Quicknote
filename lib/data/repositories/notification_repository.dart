import '../../core/constants/services/notes_database_helper.dart';
import '../models/notification_model.dart';

class NotificationsRepository {
  final NotesDatabaseHelper _dbHelper = NotesDatabaseHelper();

  // 1. إضافة إشعار (جديدة: ترجع int وإجباري noteId)
  Future<int> addNotification({
    required String title,
    required String body,
    required DateTime scheduledTime,
    required int noteId, // ⬅️ أصبح required
  }) async {
    return await _dbHelper.addNotification(
      title: title,
      body: body,
      scheduledTime: scheduledTime,
      noteId: noteId, // ⬅️ إجباري
    );
  }

  // 2. تعديل إشعار (جديدة: تعتمد على noteId)
  Future<bool> updateNotificationForNote({
    required int noteId, // ⬅️ تعتمد على noteId
    String? title,
    String? body,
    DateTime? scheduledTime,
  }) async {
    return await _dbHelper.updateNotificationForNote(
      noteId: noteId,
      title: title,
      body: body,
      scheduledTime: scheduledTime,
    );
  }

  // 3. حذف إشعارات ملاحظة (جديدة: تعتمد على noteId)
  Future<bool> deleteNotificationsForNote(int noteId) async {
    return await _dbHelper.deleteNotificationsForNote(noteId);
  }

  // 3. حذف إشعاار  (جديدة: تعتمد على noteId)
  Future<bool> deleteNotificationsForId(int id) async {
    return await _dbHelper.deleteNotificationsForId(id);
  }

  // 4. حذف جميع الإشعارات (جديدة)
  Future<bool> deleteAllNotifications() async {
    return await _dbHelper.deleteAllNotifications();
  }


  // التحقق من وجود إشعارات لملاحظة
  Future<bool> hasNoteNotifications(int noteId) async {
      return   await _dbHelper.hasNotificationsForNote(noteId);

  }

  // 5. جلب جميع الإشعارات ← List<NotificationModel>
  Future<List<NotificationModel>> getAllNotifications() async {
    List<Map<String,dynamic>> data = await _dbHelper.getAllNotifications();
    return data.map((map) => NotificationModel.fromMap(map)).toList();
  }

  // 6. تحديد إشعار كمعروض
  Future<bool> markAsShown(int id) async {
    return await _dbHelper.markAsShown(id);
  }

  // 7. جلب الإشعارات المعلقة ← List<NotificationModel>
  Future<List<NotificationModel>> getPendingNotifications() async {
    List<Map<String,dynamic>> data  = await _dbHelper.getPendingNotifications();
    return data.map((map) => NotificationModel.fromMap(map)).toList();
  }

  // 8. جلب إشعارات ملاحظة محددة ← List<NotificationModel>
  Future<List<NotificationModel>> getNotificationsByNoteId(int ?noteId) async {
    List<Map<String,dynamic>> data  = await _dbHelper.getNotificationsByNoteId(noteId);
    return data.map((map) => NotificationModel.fromMap(map)).toList();
  }

  // 9. التحقق من وجود إشعارات لملاحظة
  Future<bool> hasNotificationsForNote(int noteId) async {
    return await _dbHelper.hasNotificationsForNote(noteId);
  }
}