import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main.dart';

class ThemeController extends GetxController {
  static ThemeController get to => Get.find();

  final _key = 'theme_mode';

  Rx<ThemeMode> themeMode = ThemeMode.system.obs;

  @override
  void onInit() {
    super.onInit();
    _loadTheme();
  }

  void _loadTheme() {
    final savedTheme = getStorage.read(_key) ?? 'system';

    themeMode.value = savedTheme == 'dark'
        ? ThemeMode.dark
        : savedTheme == 'light'
        ? ThemeMode.light
        : ThemeMode.system;

    update(); // ✅ أضف هذا
  }

  void changeTheme(ThemeMode mode) {
    themeMode.value = mode;

    getStorage.write(_key,
        mode == ThemeMode.dark
            ? 'dark'
            : mode == ThemeMode.light
            ? 'light'
            : 'system'
    );

    update(); // ✅ تأكد من وجود هذا
  }

  bool get isDarkMode {
    if (themeMode.value == ThemeMode.dark) return true;
    if (themeMode.value == ThemeMode.light) return false;
    return Get.isPlatformDarkMode;
  }

  void toggleTheme() {
    changeTheme(isDarkMode ? ThemeMode.light : ThemeMode.dark);
  }
}