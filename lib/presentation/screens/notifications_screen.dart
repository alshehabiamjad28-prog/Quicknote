import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:myproject/presentation/screens/update_note_screen.dart';
import 'package:myproject/widgets/common/CustomIconButton.dart';
import 'package:myproject/widgets/cards/notification_card.dart';
import 'package:myproject/widgets/froms/show_date_pickerD.dart';
import '../../core/constants/utils/extentions/Global_loc.dart';
import '../../widgets/common/Custom_Dialog.dart';
import '../controllers/notification_controller.dart';


class NotificationsScreen extends StatelessWidget {
  final controller = Get.find<NotificationsController>();
  TextEditingController _NotidateController = TextEditingController();

  NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(GlobalLoc.instance.notifications),
        actions: [
          CustomIconButton(
            icon: Icons.delete_forever_outlined,

            onPressed: () {
           controller.notifications.isEmpty ?null:   CustomDialog.show(
                onCancel: () {},
                onConfirm: () {
                  controller.deleteAllNotifications();
                },
                textCancel: GlobalLoc.instance.cancel,
                textConfirm: GlobalLoc.instance.empty,
                title: GlobalLoc.instance.deleteAllNotifications,
                middleText: GlobalLoc.instance.areYouSureDeleteNotifications,
              );
            },
          ),
        ],
      ),

      body: Obx(() {
        if (controller.isload == true) {
          return Center(child: CircularProgressIndicator());
        }
        if (controller.notifications.isEmpty) {
          return Center(child: Text('is empty'));
        }

        return ListView.builder(
          itemCount: controller.notifications.length,
          itemBuilder: (context, index) {
            final NTF = controller.notifications[index];
            return NotificationCard(
              title: NTF.title,
              body: NTF.body,
              ontap: () {
                print("object");
                Get.to(
                  UpdateNoteScreen(
                    id: NTF.noteId as int,
                    title: NTF.title,
                    content: NTF.body,
                  ),
                  duration: Duration(milliseconds: 500),
                  transition: Transition.topLevel,
                );

              },
              scheduledTime: NTF.scheduledTime,
              onDonePressed: () {
                controller.deleteNotificationsForNote(NTF.noteId as int);
              },
              onEditPressed: () {
                CustomDateTimePickerDialog(
                  context: context,
                  dateTimeController: _NotidateController,
                  onConfirm: () {
                    controller.updateNotificationForNote(
                      NTF.title,
                      NTF.body,
                      _NotidateController.text,
                      NTF.noteId as int,
                    );
                  },
                  onCancel: () {},
                  confirmText: GlobalLoc.instance.confirm,
                  cancelText: GlobalLoc.instance.back,
                );
              },
              onDeletePressed: () {
                controller.deleteNotificationsForNote(NTF.noteId as int);
              },
            );
          },
        );
      }),
    );
  }
}
