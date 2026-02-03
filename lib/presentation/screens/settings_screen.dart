import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:myproject/widgets/cards/setting_card.dart';
import '../../core/constants/services/notification_helper.dart';
import '../../core/constants/utils/extentions/Global_loc.dart';
import '../controllers/ThemeController.dart';
import '../controllers/notes_controller.dart';


class SettingsScreen extends StatelessWidget {
  final themecontroller = Get.find<ThemeController>();
  final controller = Get.find<NotesController>();
  TextEditingController _searchController = TextEditingController();
 final NotificationHelper _nh=NotificationHelper();



  SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(GlobalLoc.instance.settings),
      ),
      body: ListView(
        children: [
          SizedBox(height: 20),
          GetBuilder<ThemeController>(
            builder: (controller) {
              return SettingsSwitchCard(
                icon: controller.isDarkMode
                    ? Icons.light_mode
                    : Icons.dark_mode,
                title: controller.isDarkMode ?GlobalLoc.instance.darkMode : GlobalLoc.instance.lightMode,
                subtitle: GlobalLoc.instance.toggleDarkMode,
                value: controller.isDarkMode,
                onChanged: (value) {
                  controller.toggleTheme();
                },
              );
            },
          ),

          SettingsSwitchCard(
            icon: Icons.notifications_active_outlined,
            title: GlobalLoc.instance.enableNotifications,
            subtitle: GlobalLoc.instance.notificationsToggle,
            value: themecontroller.isDarkMode,
            onChanged: (value) {

            },
          ),




        ],
      ),
    );
  }
}
