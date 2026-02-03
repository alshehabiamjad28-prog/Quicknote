import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main.dart';


class LocaleController extends GetxController {
  static LocaleController get to => Get.find();

  Rx<Locale> selectedLocale = Rx<Locale>(const Locale('ar'));

  @override
  void onInit() {
    super.onInit();
    _loadSavedLocale();
  }

  // تحميل اللغة المحفوظة
  void _loadSavedLocale() {
    final savedCode = getStorage.read('selected_locale') ?? 'ar';
    selectedLocale.value = Locale(savedCode);
    Get.updateLocale(selectedLocale.value);
  }

  // تغيير اللغة
  void changeLanguage(String languageCode) {
    selectedLocale.value = Locale(languageCode);

    // حفظ في الذاكرة
    getStorage.write('selected_locale', languageCode);

    // تحديث اللغة في التطبيق
    Get.updateLocale(selectedLocale.value);

    update(); // تحديث الواجهة
  }

  // الحصول على اللغة الحالية
  String get currentLanguage => selectedLocale.value.languageCode;

  // هل اللغة عربية؟
  bool get isArabic => currentLanguage == 'ar';

  // قائمة اللغات المدعومة
  List<Map<String, String>> get supportedLanguages => [
    {'code': 'ar', 'name': 'العربية'},
    {'code': 'en', 'name': 'English'},
  ];
}