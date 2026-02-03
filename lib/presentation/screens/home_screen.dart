import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:myproject/presentation/screens/update_note_screen.dart';
import 'package:myproject/widgets/common/CustomIconButton.dart';
import 'package:myproject/widgets/common/search_widget.dart';
import '../../core/constants/utils/extentions/Global_loc.dart';
import '../../data/models/notes_model.dart';
import '../../widgets/cards/app_darwer.dart';
import '../../widgets/cards/note_card.dart';
import '../../widgets/common/custom_floating_button.dart';
import '../controllers/ThemeController.dart';
import '../controllers/notes_controller.dart';
import 'create_note_screen.dart';

class HomeScreen extends StatelessWidget {
  final controller = Get.find<NotesController>();
  final themecontroller = Get.find<ThemeController>();
  TextEditingController _searchController = TextEditingController();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: CustomFloatingButton(
        icon: Icons.add,
        onPressed: () {
          Get.to(
            CreateNoteScreen(),
            duration: Duration(milliseconds: 400),
            transition: Transition.downToUp,
          );
        },
        size: 60.0,
      ),

      appBar: AppBar(
        title: Text(GlobalLoc.instance.notes),
        actions: [
          SearchWidget(
            controller: _searchController,
            hintText: GlobalLoc.instance.searchNotes,
            onPressed: () => controller.ischang(),
            onCancel: () {
              controller.ischang();
              _searchController.clear();
              controller.onClose();
            },
            showCancelButton: controller.ischangs,
            onChanged: (query) {
              if (query.isNotEmpty) {
                controller.searchNotes(query);
              } else {
                controller.searchResults.clear();
              }
            },
          ),
          GetBuilder<ThemeController>(
            builder: (controller) {
              return CustomIconButton(
                icon: controller.isDarkMode
                    ? Icons.light_mode
                    : Icons.dark_mode,

                onPressed: () {
                  controller.toggleTheme();
                },
              );
            },
          ),

          IconButton(
            onPressed: () => controller.toggleGridColumns(),
            icon: Obx(
              () => Icon(
                size: 25,
                controller.viewMode.value == 2
                    ? Icons
                          .view_agenda // أيقونة صفين
                    : Icons.view_list, // أيقونة صف واحد
              ),
            ),
          ),

          ///////////
        ],
      ),
      drawer: AppDrawer(),

      body: Obx(() {
        // تحديد البيانات المعروضة
        final List<NotesModel> displayData;
        if (controller.ischangs.value) {
          // حالة البحث
          displayData = controller.searchResults;
        } else {
          // الحالة العادية
          displayData = controller.notes;
        }

        // إذا كانت البيانات فارغة
        if (displayData.isEmpty) {
          return Center(child: Text(GlobalLoc.instance.noNotes));
        }

        // عرض الشبكة
        return MasonryGridView.count(
          padding: EdgeInsets.only(
            left: width * 0.02,
            right: width * 0.02,
            top: width * 0.06,
          ),
          crossAxisCount: displayData.length <= 1
              ? 1
              : controller.viewMode.value,
          mainAxisSpacing: 13,
          crossAxisSpacing: 15,
          itemCount: displayData.length,
          itemBuilder: (context, index) {
            final note = displayData[index];
            return IntrinsicHeight(
              child: NoteCard(
                showRetrieve: false,
                showShare: true,
                showFavorite: true,
                showEdit: true,
                showDelete: true,
                id: note.id,
                cardColor: note.cardColor,
                title: note.title,
                content: note.content,
                date: note.updatedAt.toIso8601String(),
                onTap: () {
                  Get.to(
                    UpdateNoteScreen(
                      id: note.id as int,
                      color: note.cardColor,
                      title: note.title,
                      content: note.content,
                    ),
                    duration: Duration(milliseconds: 700),
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
                    duration: Duration(milliseconds: 700),
                    transition: Transition.topLevel,
                  );
                },
                onToggleFavorite: () {
                  controller.toggleFavorite(note.id as int);
                },
                removToggleFavorite: () {
                  controller.removeFromFavorites(note.id as int);
                },
                onDelete: () {
                  controller.moveToTrash(note.id as int);
                },
                onShare: () async {},
                onRetrieve: () {},
              ),
            );
          },
        );
      }),
    );
  }
}
