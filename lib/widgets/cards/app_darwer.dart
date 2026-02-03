import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../core/constants/utils/extentions/Global_loc.dart';
import '../../presentation/controllers/notes_controller.dart';
import '../../presentation/controllers/notification_controller.dart';
import '../../presentation/screens/create_note_screen.dart';
import '../../presentation/screens/favorites_notes_screen.dart';
import '../../presentation/screens/notifications_screen.dart';
import '../../presentation/screens/settings_screen.dart';
import '../../presentation/screens/trash_screen.dart';
import 'drawer_card.dart';

class AppDrawer extends StatelessWidget {
  final controller = Get.find<NotesController>();
  final noticontroller = Get.find<NotificationsController>();

  AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // الهيدر
          Container(
            height: 120,
            color: Theme.of(context).primaryColor,
            child: Center(
              child: Text(
                GlobalLoc.instance.appTitle,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // العناصر
          Expanded(
            child: Obx(() {
              return ListView(
                children: [
                  DrawerCard(
                    count: controller.count_notes.bitLength,
                    icon: Icons.note_add_outlined,
                    text: GlobalLoc.instance.notes,
                    onPressed: () {
                      Get.back();
                    },
                  ),

                  DrawerCard(
                    icon: Icons.add,
                    text: GlobalLoc.instance.createNote,
                    onPressed: () {
                      Get.to(CreateNoteScreen(),duration: Duration(milliseconds: 400),transition:Transition.rightToLeft );
                    },
                  ),

                  DrawerCard(
                    count: controller.favorite_notes.length,
                    icon: Icons.favorite_border,
                    text: GlobalLoc.instance.favorites,
                    onPressed: () {
                      Get.to(FavoritesNotesScreen(),duration: Duration(milliseconds: 400),transition:Transition.rightToLeft );
                    },
                  ),
                  DrawerCard(
                    count: noticontroller.notifications.length,
                    icon: Icons.notifications_active_outlined,
                    text: GlobalLoc.instance.notifications,
                    onPressed: () {
                      Get.to(NotificationsScreen(),duration: Duration(milliseconds: 400),transition:Transition.rightToLeft );
                    },
                  ),
                  DrawerCard(
                    count: controller.trash_notes.length,
                    icon: Icons.delete_outline,
                    text: GlobalLoc.instance.trash,
                    onPressed: () {
                      Get.to(TrashScreen(),duration: Duration(milliseconds: 400),transition:Transition.rightToLeft );
                    },
                  ),

                  DrawerCard(
                    icon: Icons.settings_outlined,
                    text: GlobalLoc.instance.settings,
                    onPressed: () {
                      Get.to(SettingsScreen(),duration: Duration(milliseconds: 400),transition:Transition.rightToLeft );
                    },
                  ),
                  DrawerCard(
                    icon: Icons.help_outline,
                    text: GlobalLoc.instance.helpSupport,
                    onPressed: () {},
                  ),

                  const Divider(),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
