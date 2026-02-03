import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/constants/utils/extentions/Global_loc.dart';

void CustomDateTimePickerDialog({
  required BuildContext context,
  required TextEditingController dateTimeController,
  required VoidCallback onConfirm,
  required VoidCallback onCancel,
  required String confirmText,
  required String cancelText,
  DateTime? initialDate,
}) {
  DateTime? selectedDateTime = initialDate ?? DateTime.now();

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      return StatefulBuilder(
        builder: (context, setState) {
          // ✅ دالة تحويل TimeOfDay إلى 24 ساعة (المصححة)
          int _convertTimeOfDayTo24Hour(TimeOfDay time) {
            print('🔄 تحويل الوقت:');
            print('   time.hour: ${time.hour}');
            print('   time.hourOfPeriod: ${time.hourOfPeriod}');
            print('   time.period: ${time.period == DayPeriod.am ? "AM" : "PM"}');

            // ⭐⭐ استخدم hourOfPeriod (0-11) بدلاً من hour
            int hour24;
            if (time.period == DayPeriod.am) {
              hour24 = time.hourOfPeriod == 0 ? 0 : time.hourOfPeriod;
            } else {
              hour24 = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod + 12;
            }

            print('   hour24 الناتج: $hour24');
            return hour24;
          }
          // ✅ دالة تنسيق الوقت للعرض
          String _formatTimeForDisplay(DateTime dateTime) {
            int hour = dateTime.hour;
            int minute = dateTime.minute;

            int displayHour = hour % 12;
            displayHour = displayHour == 0 ? 12 : displayHour;

            String period = hour >= 12 ? 'م' : 'ص';

            return '${displayHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
          }

          // ✅ دالة تنسيق التاريخ والوقت معاً للعرض
          String _formatDateTimeForDisplay(DateTime dateTime) {
            final locale = Localizations.localeOf(context);
            final date = DateFormat('EEEE, d MMMM yyyy', locale.toString())
                .format(dateTime);
            final time = _formatTimeForDisplay(dateTime);
            return '$date - $time';
          }

          Future<void> pickDateTime() async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: selectedDateTime!,
              firstDate: DateTime.now(),
              lastDate: DateTime(2100),
            );

            if (picked == null) return;

            final TimeOfDay? time = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.fromDateTime(selectedDateTime!),
            );

            if (time != null) {
              final int hour24 = _convertTimeOfDayTo24Hour(time);

              final DateTime newDateTime = DateTime(
                picked.year,
                picked.month,
                picked.day,
                hour24,
                time.minute,
              );

              // ✅ طباعة التحقق
              print('══════════════════════════════════════');
              print('📅 تحقق من القيم:');
              print('   الوقت المحدد: ${time.hour}:${time.minute} ${time.period == DayPeriod.am ? "AM" : "PM"}');
              print('   hour24 المحول: $hour24');
              print('   التاريخ الكامل: $newDateTime');

              // ✅ تخزين timestamp بدلاً من ISO string
              String storedValue = newDateTime.millisecondsSinceEpoch.toString();

              print('   القيمة المخزنة (timestamp): $storedValue');
              print('══════════════════════════════════════');

              setState(() {
                selectedDateTime = newDateTime;
                // ✅ تخزين timestamp في الكنترولر
                dateTimeController.text = storedValue;
              });
            }
          }

          final width = MediaQuery.of(context).size.width;

          return Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: BorderSide(color: Colors.grey[300]!, width: 1),
            ),
            elevation: 10,
            child: Container(
              padding: EdgeInsets.all(width * 0.06),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // العنوان
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.calendar_month_outlined,
                        size: width * 0.06,
                        color: Colors.blueGrey[800],
                      ),
                      SizedBox(width: width * 0.02),
                      Text(
                        GlobalLoc.instance.scheduleNotification,
                        style: TextStyle(
                          fontSize: width * 0.045,
                          fontWeight: FontWeight.w700,
                          color: Colors.blueGrey[900],
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: width * 0.04),
                  Divider(color: Colors.grey[300], thickness: 1),

                  SizedBox(height: width * 0.05),

                  // عرض التاريخ المحدد
                  if (selectedDateTime != null)
                    Container(
                      padding: EdgeInsets.all(width * 0.04),
                      margin: EdgeInsets.only(bottom: width * 0.05),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.blueGrey[200]!, width: 1),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.check_circle_outline,
                                size: width * 0.05,
                                color: Colors.green[700],
                              ),
                              SizedBox(width: width * 0.02),
                              Text(
                                '',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green[800],
                                  fontSize: width * 0.04,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: width * 0.03),
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: width * 0.03,
                              horizontal: width * 0.04,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      size: width * 0.045,
                                      color: Colors.blueGrey[700],
                                    ),
                                    SizedBox(width: width * 0.02),
                                    Expanded(
                                      child: Text(
                                        _formatDateTimeForDisplay(selectedDateTime!),
                                        style: TextStyle(
                                          fontSize: width * 0.042,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.blueGrey[800],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: width * 0.02),
                                Divider(height: 1, color: Colors.grey[300]),


                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                  // زر اختيار التاريخ
                  ElevatedButton(
                    onPressed: pickDateTime,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blueGrey[800],
                      minimumSize: Size(width * 0.75, width * 0.14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Colors.blueGrey[300]!, width: 1.5),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.06,
                        vertical: width * 0.03,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          selectedDateTime != null
                              ? Icons.edit_calendar
                              : Icons.calendar_month,
                          size: width * 0.055,
                        ),
                        SizedBox(width: width * 0.03),
                        Text(
                          selectedDateTime != null
                              ? GlobalLoc.instance.updateNotification
                              : GlobalLoc.instance.newNotification,
                          style: TextStyle(
                            fontSize: width * 0.045,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: width * 0.06),

                  // أزرار التأكيد والإلغاء
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // زر الإلغاء
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            print('🚫 تم الإلغاء');
                            Navigator.of(context).pop();
                            onCancel();
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red[700],
                            side: BorderSide(color: Colors.red[300]!),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(vertical: width * 0.026),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: width * 0.02),
                              Text(
                                cancelText,
                                style: TextStyle(
                                  fontSize: width * 0.045,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(width: width * 0.04),

                      // زر الموافقة
                      Expanded(
                        child: ElevatedButton(
                          onPressed: selectedDateTime != null
                              ? () {
                            print('✅ تم التأكيد: ${dateTimeController.text}');
                            Navigator.of(context).pop();
                            onConfirm();
                          }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey[800],
                            disabledBackgroundColor: Colors.grey[300],
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(vertical: width * 0.026),
                            elevation: 3,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: width * 0.02),
                              Text(
                                confirmText,
                                style: TextStyle(
                                  fontSize: width * 0.045,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}