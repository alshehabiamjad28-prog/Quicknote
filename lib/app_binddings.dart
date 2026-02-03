import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:myproject/presentation/controllers/ThemeController.dart';
import 'package:myproject/presentation/controllers/notes_controller.dart';
import 'package:myproject/presentation/controllers/notification_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotesController>(() => NotesController(), fenix: true);
    Get.lazyPut<ThemeController>(() => ThemeController(), fenix: true);

    Get.lazyPut<NotificationsController>(
      () => NotificationsController(),
      fenix: true,
    );
  }
}
