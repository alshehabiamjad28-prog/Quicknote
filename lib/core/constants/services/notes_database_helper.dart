import 'dart:io';
import 'dart:ui';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NotesDatabaseHelper {
  static Database? _database;
  static const String _dbName = 'notes_database_helper65.db';

  // الحصول على قاعدة البيانات
  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // التهيئة
  static Future<Database> _initDatabase() async {
    final String dbPath = await getDatabasesPath();
    final String path = join(dbPath, _dbName);
    print('////////initDatabase/////////////');
    return await openDatabase(path, version: 1, onCreate: _createTable);
  }

  // إنشاء جدول الملاحظات فقط
  static Future<void> _createTable(Database db, int version) async {
    await db.execute('''
    CREATE TABLE notes (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      content TEXT NOT NULL,
      created_at TEXT NOT NULL,
      updated_at TEXT NOT NULL,
      is_deleted INTEGER DEFAULT 0,
      is_favorite INTEGER DEFAULT 0,
      card_color TEXT NULL
    )
  ''');

    await db.execute('''
   CREATE TABLE notifications (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  scheduled_time INTEGER NOT NULL, 
  is_shown INTEGER DEFAULT 0,
  note_id INTEGER NULL,
  created_at INTEGER NOT NULL, 
  updated_at INTEGER NOT NULL, 
  FOREIGN KEY (note_id) 
    REFERENCES notes(id) 
    ON DELETE CASCADE
)
  ''');
  }



  // //============ دوال الملاحظات  ============// //
  Future<bool> insert(
    String title,
    String content, {
    String? cardColor, // ⬅️ تغيير إلى nullable
  }) async {
    try {
      final db = await database;
      Map<String, dynamic> data = {
        'title': title,
        'content': content,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
        'is_deleted': 0,
        'is_favorite': 0,
      };

      // ⬅️ أضف اللون فقط إذا وُفر
      if (cardColor != null) {
        data['card_color'] = cardColor;
      }

      await db.insert('notes', data);
      return true;
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  Future<bool> update(
    String title,
    String content,
    int id, {
    String? cardColor,
  }) async {
    try {
      final db = await database;
      Map<String, dynamic> data = {
        'title': title,
        'content': content,
        'updated_at': DateTime.now().toIso8601String(),
      };

      if (cardColor != null) {
        data['card_color'] = cardColor;
      }

      await db.update('notes', data, where: 'id=?', whereArgs: [id]);
      return true;
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  Future<bool> delete(int id) async {
    try {
      final db = await database;
      await db.delete('notes', where: 'id=?', whereArgs: [id]);
      print('Operation completed successfully');
      return true;
    } catch (e) {
      print("Operation failed");
      return false;
    }
  }

  Future<bool> deleteAll() async {
    try {
      final db = await database;
      await db.delete('notes');
      print('Operation completed successfully');
      return true;
    } catch (e) {
      print("Operation failed");
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> getallnotes() async {
    try {
      final db = await database;
      final notes = await db.query(
        'notes',
        where: 'is_deleted = 0',
        orderBy: 'updated_at DESC',
      );
      return notes.map((element) => element as Map<String, dynamic>).toList();
    } catch (e) {
      print("Operation failed");
      return [];
    }
  }

  // 1. دالة عرض عدد جميع الملاحظات النشطة
  Future<int> getNotesCount() async {
    try {
      final db = await database;
      final result = await db.rawQuery(
        'SELECT COUNT(*) FROM notes WHERE is_deleted = 0',
      );
      return result.first.values.first as int;
    } catch (e) {
      return 0;
    }
  }

  Future<List<Map<String, dynamic>>> searchNotes(String query) async {
    final db = await database;

    return await db.query(
      'notes',
      where: 'title LIKE ? OR content LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
    );
  }

  //////////////////////////////////////////////////////
  Future<bool> moveToTrash(int id) async {
    try {
      final db = await database;
      await db.update(
        'notes',
        {'is_deleted': 1, 'updated_at': DateTime.now().toIso8601String()},
        where: 'id=?',
        whereArgs: [id],
      );
      print('Operation completed successfully');
      return true;
    } catch (e) {
      print("Operation failed");
      return false;
    }
  }

  Future<bool> restoreFromTrash(int id) async {
    try {
      final db = await database;
      await db.update(
        'notes',
        {'is_deleted': 0, 'updated_at': DateTime.now().toIso8601String()},
        where: 'id=?',
        whereArgs: [id],
      );
      print('Operation completed successfully');
      return true;
    } catch (e) {
      print("Operation failed");
      return false;
    }
  }

  Future<bool> trashAll() async {
    try {
      final db = await database;
      await db.delete('notes', where: 'is_deleted=1');
      print('Operation completed successfully');
      return true;
    } catch (e) {
      print("Operation failed");
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> getDeletedNotes() async {
    try {
      final db = await database;
      final notes = await db.query(
        'notes',
        where: 'is_deleted = 1',
        orderBy: 'updated_at DESC',
      );
      return notes.map((element) => element as Map<String, dynamic>).toList();
    } catch (e) {
      print("object");
      return [];
    }
  }

  // 3. دالة عرض عدد المحذوفات
  Future<int> getTrashCount() async {
    try {
      final db = await database;
      final result = await db.rawQuery(
        'SELECT COUNT(*) FROM notes WHERE is_deleted = 1',
      );
      return result.first.values.first as int;
    } catch (e) {
      return 0;
    }
  }

  //////////////////////////
  Future<bool> toggleFavorite(int id) async {
    try {
      final db = await database;
      await db.update(
        'notes',
        {'is_favorite': 1, 'updated_at': DateTime.now().toIso8601String()},
        where: 'id=?',
        whereArgs: [id],
      );
      print('Operation completed successfully');
      return true;
    } catch (e) {
      print("Operation failed");
      return false;
    }
  }

  Future<bool> removeFromFavorites(int id) async {
    try {
      final db = await database;
      await db.update(
        'notes',
        {'is_favorite': 0, 'updated_at': DateTime.now().toIso8601String()},
        where: 'id=?',
        whereArgs: [id],
      );
      print('Operation completed successfully');
      return true;
    } catch (e) {
      print("Operation failed");
      return false;
    }
  }

  Future<bool> delertAllfav() async {
    try {
      final db = await database;
      await db.update(
        'notes',
        {'is_favorite': 0},
        where: 'is_favorite=?',
        whereArgs: [1],
      );
      print('Operation completed successfully');
      return true;
    } catch (e) {
      print("Operation failed");
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> getFavoriteNotes() async {
    try {
      final db = await database;
      final notes = await db.query(
        'notes',
        where: 'is_favorite = 1 AND is_deleted=0',
        orderBy: 'updated_at DESC',
      );
      return notes.map((element) => element as Map<String, dynamic>).toList();
    } catch (e) {
      print("Operation failed");
      return [];
    }
  }

  // 2. دالة عرض عدد المفضلات
  Future<int> getFavoritesCount() async {
    try {
      final db = await database;
      final result = await db.rawQuery(
        'SELECT COUNT(*) FROM notes WHERE is_favorite = 1 AND is_deleted = 0',
      );
      return result.first.values.first as int;
    } catch (e) {
      return 0;
    }
  }

  Future<bool> isFavorite(int id) async {
    try {
      final db = await database;
      final result = await db.query(
        'notes',
        columns: ['is_favorite'],
        where: 'id = ?',
        whereArgs: [id],
      );

      if (result.isEmpty) return false;
      return result.first['is_favorite'] == 1;
    } catch (e) {
      return false;
    }
  }

  ////////////////////////////////////////////
  //////////////////////////////////////////////
  // ============ عمليات الإشعارات ============

  // 1. الإضافة (يرجع ID الإشعار المنشأ)
  Future<int> addNotification({
    required String title,
    required String body,
    required DateTime scheduledTime,
    required int noteId,
  }) async {
    try {
      final db = await database;
      final insertedId = await db.insert('notifications', {
        'title': title,
        'body': body,
        'scheduled_time': scheduledTime.millisecondsSinceEpoch, // INTEGER
        'is_shown': 0,
        'note_id': noteId,
        'created_at': DateTime.now().millisecondsSinceEpoch, // INTEGER
        'updated_at': DateTime.now().millisecondsSinceEpoch, // INTEGER
      });
      return insertedId;
    } catch (e) {
      print("Error adding notification: $e");
      return -1;
    }
  }

// 2. التعديل (يعدل إشعارات ملاحظة محددة)
  Future<bool> updateNotificationForNote({
    required int noteId,
    String? title,
    String? body,
    DateTime? scheduledTime,
  }) async {
    try {
      final db = await database;
      Map<String, dynamic> data = {
        'updated_at': DateTime.now().millisecondsSinceEpoch, // INTEGER
      };

      if (title != null) data['title'] = title;
      if (body != null) data['body'] = body;
      if (scheduledTime != null) {
        data['scheduled_time'] = scheduledTime.millisecondsSinceEpoch; // INTEGER
      }

      await db.update(
          'notifications',
          data,
          where: 'note_id = ?',
          whereArgs: [noteId]
      );
      return true;
    } catch (e) {
      print("Error updating notification: $e");
      return false;
    }
  }

// 3. الحذف (يحذف إشعارات ملاحظة محددة)
  Future<bool> deleteNotificationsForNote(int noteId) async {
    try {
      final db = await database;
      // يحذف جميع إشعارات هذه الملاحظة
      await db.delete(
          'notifications',
          where: 'note_id = ?', // ⬅️ يعتمد على noteId فقط
          whereArgs: [noteId]
      );
      return true;
    } catch (e) {
      print("Error deleting notifications: $e");
      return false;
    }
  }
  // 3. الحذف (يحذف إشعارات ملاحظة محددة)
  Future<bool> deleteNotificationsForId(int id) async {
    try {
      final db = await database;
      // يحذف جميع إشعارات هذه الملاحظة
      await db.delete(
          'notifications',
          where: 'id = ?', // ⬅️ يعتمد على noteId فقط
          whereArgs: [id]
      );
      return true;
    } catch (e) {
      print("Error deleting notifications: $e");
      return false;
    }
  }



  // 5. حذف جميع الإشعارات (كل الجدول)'
  Future<bool> deleteAllNotifications() async {
    try {
      final db = await database;
      await db.delete('notifications');
      return true;
    } catch (e) {
      print("Error deleting all notifications: $e");
      return false;
    }
  }

  Future<bool> hasNotificationsForNote(int noteId) async {
    try {
      final db = await database;

      final result = await db.rawQuery(
        'SELECT 1 FROM notifications WHERE note_id = ? LIMIT 1',
        [noteId],
      );

      return result.isNotEmpty;
    } catch (e) {
      print("Error checking notifications: $e");
      return false;
    }
  }

  // 4. جلب جميع الإشعارات
  Future<List<Map<String, dynamic>>> getAllNotifications() async {
    try {
      final db = await database;
      final result = await db.query(
        'notifications',
        orderBy: 'scheduled_time DESC',
      );
      return result.map((item) => item.cast<String, dynamic>()).toList();
    } catch (e) {
      print("Error getting notifications: $e");
      return [];
    }
  }

  // 5. تحديد إشعار كمعروض
  Future<bool> markAsShown(int id) async {
    try {
      final db = await database;
      await db.update(
        'notifications',
        {'is_shown': 1, 'updated_at': DateTime.now().toIso8601String()},
        where: 'id = ?',
        whereArgs: [id],
      );
      return true;
    } catch (e) {
      print("Error marking notification as shown: $e");
      return false;
    }
  }

  // 6. جلب الإشعارات المعلقة (لم تعرض بعد)
  Future<List<Map<String, dynamic>>> getPendingNotifications() async {
    try {
      final db = await database;
      final result = await db.query(
        'notifications',
        where: 'is_shown = 0 AND scheduled_time > ?',
        whereArgs: [DateTime.now().toIso8601String()],
        orderBy: 'scheduled_time ASC',
      );
      return result.map((item) => item.cast<String, dynamic>()).toList();
    } catch (e) {
      print("Error getting pending notifications: $e");
      return [];
    }
  }

  // 7. جلب إشعارات ملاحظة محددة
  Future<List<Map<String, dynamic>>> getNotificationsByNoteId(
    int? noteId,
  ) async {
    try {
      final db = await database;
      final result = await db.query(
        'notifications',
        where: 'note_id = ?',
        whereArgs: [noteId],
        orderBy: 'scheduled_time DESC',
      );
      return result.map((item) => item.cast<String, dynamic>()).toList();
    } catch (e) {
      print("Error getting note notifications: $e");
      return [];
    }
  }
}
