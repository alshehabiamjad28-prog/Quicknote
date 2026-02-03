import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:myproject/presentation/screens/update_note_screen.dart';
import '../../core/constants/utils/extentions/Global_loc.dart';
import '../../widgets/cards/note_card.dart';
import '../../widgets/common/CustomIconButton.dart';
import '../../widgets/common/Custom_Dialog.dart';
import '../controllers/notes_controller.dart';


class TrashScreen extends StatelessWidget {
  final controller = Get.put(NotesController());

  TrashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(GlobalLoc.instance.trash),
        actions: [
          IconButton(
            onPressed: () => controller.toggleGridColumns(),
            icon: Obx(
              () => Icon(
                controller.viewMode.value == 2
                    ? Icons
                          .view_agenda // أيقونة صفين
                    : Icons.view_list, // أيقونة صف واحد
              ),
            ),
          ),
          CustomIconButton(

            icon: Icons.delete_forever_outlined,

            onPressed: () {
           controller.trash_notes.isEmpty ?null:   CustomDialog.show(
                destructiveAction: true,
                onCancel: () {},
                onConfirm: () {
                  controller.removeAlltrash();
                },
                textConfirm: GlobalLoc.instance.empty,
                textCancel: GlobalLoc.instance.cancel,
                title: GlobalLoc.instance.clearTrash,
                middleText: GlobalLoc.instance.areYouSureClearTrash,
              );
            },
          ),
        ],
      ),

      body: Obx(() {
        if (controller.isload == true) {
          return Center(child: CircularProgressIndicator());
        }
        
        if(controller.trash_notes.isEmpty){
          return Center(child: Text(GlobalLoc.instance.trashEmpty),);
        }
        

        return MasonryGridView.count(
          padding: EdgeInsets.only(
            left: width * 0.02,
            right: width * 0.02,
            top: width * 0.06,
          ),
          crossAxisCount: controller.favorite_notes.length <= 1
              ? 1
              : controller.viewMode.value,
          mainAxisSpacing: 13,
          crossAxisSpacing: 15,
          itemCount: controller.trash_notes.length,
          itemBuilder: (context, index) {
            final note = controller.trash_notes[index];
            return IntrinsicHeight(
              child: NoteCard(
                id: note.id,
                showRetrieve: true,
                showShare: false,
                showFavorite: false,
                showEdit: false,
                showDelete: true,
                cardColor: note.cardColor,
                title: note.title,
                content: note.content,
                date: note.updatedAt.toString(),
                onRetrieve: () {
                  controller.restoreFromTrash(note.id as int);
                },
                onTap: () {
                  Get.to(
                    UpdateNoteScreen(
                      id: note.id as int,

                      color: note.cardColor,
                      title: note.title,
                      content: note.content,
                    ),
                    duration: Duration(milliseconds: 500),
                    transition: Transition.topLevel,
                  );
                },
                onEdit: () {
                  Get.to(
                    UpdateNoteScreen(
                      id: note.id as int,

                      color: note.cardColor,
                      title: note.title,
                      content: note.content,
                    ),
                    duration: Duration(milliseconds: 500),
                    transition: Transition.topLevel,
                  );
                },
                onToggleFavorite: () {},
                onDelete: () {
                  controller.deletenote(note.id as int);
                },
                onShare: () {},
                removToggleFavorite: () {

                },
              ),
            );
          },
        );
      }),
    );
  }
}
