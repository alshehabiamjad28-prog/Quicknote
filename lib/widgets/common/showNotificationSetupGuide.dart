import 'package:flutter/material.dart';

void showNotificationSetupGuide(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Row(
        children: [
          Icon(Icons.notifications, color: Colors.blue),
          SizedBox(width: 10),
          Text('كيف تفعل الإشعارات'),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStep('1️⃣', 'اذهب إلى إعدادات جهازك'),
            _buildStep('2️⃣', 'اضغط على "التطبيقات"'),
            _buildStep('3️⃣', 'ابحث عن "كويك نوت"'),
            _buildStep('4️⃣', 'اضغط على "الإشعارات"'),
            _buildStep('5️⃣', 'شغل خيار "السماح بالإشعارات"'),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                '✅ بعد التفعيل، يمكنك جدولة تنبيهات للملاحظات المهمة',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text('فهمت، شكراً'),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    ),
  );
}

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