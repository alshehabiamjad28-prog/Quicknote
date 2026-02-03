import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/constants/utils/extentions/Global_loc.dart';

class NotificationCard extends StatelessWidget {
  final String title;
  final String body;
  final DateTime scheduledTime;
  final VoidCallback onDonePressed;
  final VoidCallback onEditPressed;
  final VoidCallback onDeletePressed;
  final VoidCallback ontap;

  const NotificationCard({
    Key? key,
    required this.ontap,
    required this.title,
    required this.body,
    required this.scheduledTime,
    required this.onDonePressed,
    required this.onEditPressed,
    required this.onDeletePressed,
  }) : super(key: key);

  // ✅ دالة تحويل 24 ساعة → 12 ساعة للعرض
  String _formatTimeForDisplay(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final hour = scheduledTime.hour; // 0-23
    final minute = scheduledTime.minute;

    // التحويل إلى 12 ساعة
    int displayHour = hour % 12;
    displayHour = displayHour == 0 ? 12 : displayHour;

    if (locale.languageCode == 'ar') {
      String period = hour >= 12 ? 'م' : 'ص';
      return '${displayHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
    } else {
      String period = hour >= 12 ? 'PM' : 'AM';
      return '${displayHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
    }
  }

  // ✅ دالة لعرض التاريخ والوقت معاً
  String _formatDateTimeForDisplay(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final date = DateFormat('dd/MM/yyyy', locale.toString()).format(scheduledTime);
    final time = _formatTimeForDisplay(context);
    return '$date - $time';
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: ontap,
      borderRadius: BorderRadius.circular(12),
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.01,
        ),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          padding: EdgeInsets.all(width * 0.04),
          constraints: BoxConstraints(
            minHeight: height * 0.15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // العنوان
              Row(
                children: [
                  Icon(
                    Icons.notifications,
                    size: width * 0.045,
                    color: CupertinoColors.systemYellow,
                  ),
                  SizedBox(width: width * 0.02),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: width * 0.045,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),

              SizedBox(height: height * 0.01),

              // المحتوى
              Text(
                body,
                style: TextStyle(
                  fontSize: width * 0.04,
                  height: 1.4,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              SizedBox(height: height * 0.015),

              // التاريخ والوقت (المصحح)
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.03,
                  vertical: width * 0.02,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.grey[200]!,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.access_time_filled,
                      size: width * 0.04,
                      color: Colors.blueGrey[600],
                    ),
                    SizedBox(width: width * 0.015),
                    Text(
                      _formatDateTimeForDisplay(context),
                      style: TextStyle(
                        fontSize: width * 0.035,
                        color: Colors.blueGrey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: height * 0.015),

              // الأزرار
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // زر التمام
                  Expanded(
                    child: InkWell(
                      onTap: onDonePressed,
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: height * 0.008),
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.check_circle_outline,
                              size: width * 0.045,
                              color: Colors.green[700],
                            ),
                            SizedBox(height: height * 0.004),
                            Text(
                              GlobalLoc.instance.done,
                              style: TextStyle(
                                fontSize: width * 0.035,
                                color: Colors.green[700],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: width * 0.02),

                  // زر التعديل
                  Expanded(
                    child: InkWell(
                      onTap: onEditPressed,
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: height * 0.008),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.edit_outlined,
                              size: width * 0.045,
                              color: Colors.blue[700],
                            ),
                            SizedBox(height: height * 0.004),
                            Text(
                              GlobalLoc.instance.update,
                              style: TextStyle(
                                fontSize: width * 0.035,
                                color: Colors.blue[700],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: width * 0.02),

                  // زر الحذف
                  Expanded(
                    child: InkWell(
                      onTap: onDeletePressed,
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: height * 0.008),
                        decoration: BoxDecoration(
                          color: Colors.red[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.delete_outline,
                              size: width * 0.045,
                              color: Colors.red[700],
                            ),
                            SizedBox(height: height * 0.004),
                            Text(
                              GlobalLoc.instance.delete,
                              style: TextStyle(
                                fontSize: width * 0.035,
                                color: Colors.red[700],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}