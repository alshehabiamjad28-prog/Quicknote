import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../core/constants/theme/color_helper.dart';
import '../../presentation/controllers/notes_controller.dart';
import 'note_popu_menu.dart';

class NoteCard extends StatefulWidget {
  final id;
  final String title;
  final String content;
  final String date;
  final bool showEdit;
  final bool showFavorite;
  final bool showDelete;
  final bool showShare;
  final bool showRetrieve;
  final String cardColor;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onRetrieve;
  final void Function() onToggleFavorite;
  final void Function() removToggleFavorite;

  final VoidCallback onDelete;
  final VoidCallback onShare;

  const NoteCard({
    Key? key,
    required this.title,
    required this.content,
    required this.date,
    required this.onTap,
    required this.onEdit,
    required this.onToggleFavorite,
    required this.onDelete,
    required this.onShare,
    required this.showEdit,
    required this.showFavorite,
    required this.showDelete,
    required this.showShare,
    this.id,
    required this.removToggleFavorite,
    required this.showRetrieve,
    required this.onRetrieve,
    required this.cardColor,
  }) : super(key: key);

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  bool chang = false;

  var controller = Get.find<NotesController>();

  void initState() {
    super.initState(); // ⬅️ يجب أن يكون أول سطر
    _loadFavoriteStatus();
  }

  _loadFavoriteStatus() async {
    try {
      final isFavorite1 = await controller.isFavorites(widget.id);
      if (mounted) {
        setState(() {
          chang = isFavorite1;
        });
      }
    } catch (e) {
      print('❌ خطأ في تحميل حالة المفضلة: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context).colorScheme.background;

    // 🔒 الحد الأقصى لطول الكارد
    final maxCardHeight = width * 0.57;

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxCardHeight),
      child: Material(
        elevation: 2,

        borderRadius: BorderRadius.circular(width * 0.04),
        color: parseColor(widget.cardColor) == Colors.white
            ? theme
            : parseColor(widget.cardColor),
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(width * 0.04),
          child: Padding(
            padding: EdgeInsets.all(width * 0.04),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ===== العنوان + القائمة =====
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        widget.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: width * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    MenuButton(
                      onRetrieve: widget.onRetrieve,
                      showRetrieve: widget.showRetrieve,
                      showDelete: widget.showDelete,
                      showEdit: widget.showEdit,
                      showFavorite: widget.showFavorite,
                      showShare: widget.showShare,
                      onShare: widget.onShare,
                      icon: Icons.more_vert,
                      onEdit: widget.onEdit,
                      onToggleFavorite: widget.onToggleFavorite,
                      removToggleFavorite: widget.removToggleFavorite,
                      onDelete: widget.onDelete,
                      id: widget.id,
                    ),
                  ],
                ),

                SizedBox(height: width * 0.025),

                // ===== المحتوى (مقصوص عند الحد الأقصى) =====
                Expanded(
                  child: ClipRect(
                    child: Text(
                      widget.content,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: width * 0.038, height: 1.6),
                    ),
                  ),
                ),

                SizedBox(height: width * 0.03),

                // ===== التاريخ =====
                Align(
                  alignment: Alignment.centerRight,
                  child: Center(
                    child: Text(
                      "${formatDateLocalized(widget.date,context)}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: width * 0.032),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
