import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myproject/presentation/controllers/ThemeController.dart';
import 'package:myproject/presentation/controllers/notification_controller.dart';
import 'package:myproject/presentation/screens/create_note_screen.dart';
import 'package:myproject/presentation/screens/favorites_notes_screen.dart';
import 'package:myproject/presentation/screens/home_screen.dart';
import 'package:myproject/presentation/screens/notifications_screen.dart';
import 'package:myproject/presentation/screens/onboarding_screen.dart';
import 'package:myproject/presentation/screens/start_screen.dart';
import 'package:myproject/presentation/screens/trash_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app_binddings.dart';
import 'core/constants/services/notification_helper.dart';
import 'core/constants/theme/app_theme.dart';
import 'core/constants/utils/extentions/Global_loc.dart';
import 'l10n/arb/app_localizations.dart';

final getStorage = GetStorage();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationHelper().initialize();
  Get.put(NotificationsController());
  await GetStorage.init();
  Get.put(ThemeController());

  await Supabase.initialize(
    url: 'https://qklihnthoubxwusrsrwb.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFrbGlobnRob3VieHd1c3JzcndiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjcxODg0MTEsImV4cCI6MjA4Mjc2NDQxMX0.ykWIeZCCIA51ktOSd6fJrB7FHeHFZ3lj_KCdjhkEd4U',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: HomeBinding(),
      initialRoute:'StartScreen',
      getPages: [
        GetPage(name: '/HomeScreen', page: () => HomeScreen()),
        GetPage(name: '/creat_screen', page: () => CreateNoteScreen()),
        GetPage(name: '/favority_screen', page: () => FavoritesNotesScreen()),
        GetPage(name: '/trash_screen', page: () => TrashScreen()),
        GetPage(name: '/NotificationsScreen', page: () => NotificationsScreen()),
        GetPage(name: '/StartScreen', page: () => StartScreen()),

        GetPage(name: '/OnboardingScreen', page: () => OnboardingScreen(onFinish: () {  },

        )),



      ],

      builder: (context, child) {
        GlobalLoc.init(context);
        return child!;
      },

      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      // locale: Locale('ar'),
      theme: AppTheme.lightTheme(),

      darkTheme: AppTheme.darkTheme(),
      themeMode:ThemeController.to.themeMode.value,
    ));
  }
}
