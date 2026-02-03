class NotificationModel {
  int id;
  String title;
  String body;
  DateTime scheduledTime;
  bool isShown;
  int? noteId;
  DateTime createdAt;
  DateTime updatedAt;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.scheduledTime,
    required this.isShown,
    this.noteId,
    required this.createdAt,
    required this.updatedAt,
  });

  // تحويل من Map إلى Model
  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    print('🔍 قراءة scheduled_time:');
    print('   الخام: ${map['scheduled_time']}');
    print('   النوع: ${map['scheduled_time'].runtimeType}');

    DateTime scheduledTime;
    DateTime createdAt;
    DateTime updatedAt;

    // قراءة scheduled_time (يدعم INT و STRING للتوافق)
    if (map['scheduled_time'] is int) {
      scheduledTime = DateTime.fromMillisecondsSinceEpoch(
          map['scheduled_time'] as int
      );
      print('   ⭐ scheduled_time من INTEGER: $scheduledTime');
    } else if (map['scheduled_time'] is String) {
      // دعم للبيانات القديمة
      String str = map['scheduled_time'] as String;
      // إذا كان string يحتوي على timestamp
      try {
        int timestamp = int.parse(str);
        scheduledTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
        print('   ⭐ scheduled_time من String timestamp: $scheduledTime');
      } catch (e) {
        // إذا كان ISO string
        scheduledTime = DateTime.parse(str).toLocal();
        print('   scheduled_time من ISO string: $scheduledTime');
      }
    } else {
      scheduledTime = DateTime.now();
      print('   ⚠️ scheduled_time افتراضي: $scheduledTime');
    }

    // قراءة created_at و updated_at (يدعم INT و STRING للتوافق)
    if (map['created_at'] is int) {
      createdAt = DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int);
    } else if (map['created_at'] is String) {
      createdAt = DateTime.parse(map['created_at'] as String).toLocal();
    } else {
      createdAt = DateTime.now();
    }

    if (map['updated_at'] is int) {
      updatedAt = DateTime.fromMillisecondsSinceEpoch(map['updated_at'] as int);
    } else if (map['updated_at'] is String) {
      updatedAt = DateTime.parse(map['updated_at'] as String).toLocal();
    } else {
      updatedAt = DateTime.now();
    }

    print('   الساعة النهائية: ${scheduledTime.hour}:${scheduledTime.minute}');

    return NotificationModel(
      id: map['id'] as int,
      title: map['title'] as String,
      body: map['body'] as String,
      scheduledTime: scheduledTime,
      isShown: (map['is_shown'] as int) == 1,
      noteId: map['note_id'] as int?,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  // تحويل من Model إلى Map - ⭐ مطابق للجدول INTEGER
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'scheduled_time': scheduledTime.millisecondsSinceEpoch, // ⭐ INTEGER
      'is_shown': isShown ? 1 : 0,
      'note_id': noteId,
      'created_at': createdAt.millisecondsSinceEpoch, // ⭐ INTEGER
      'updated_at': updatedAt.millisecondsSinceEpoch, // ⭐ INTEGER
    };
  }
}