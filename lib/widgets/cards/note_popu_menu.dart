import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import '../../core/constants/utils/extentions/Global_loc.dart';
import '../../presentation/controllers/notes_controller.dart';

class MenuButton extends StatefulWidget {
  final id;

  final IconData icon;
  final bool showEdit;
  final bool showFavorite;
  final bool showDelete;
  final bool showShare;
  final bool showRetrieve;

  final void Function() removToggleFavorite;

  final VoidCallback onEdit;
  final void Function() onToggleFavorite;
  final VoidCallback onDelete;
  final VoidCallback onShare;
  final VoidCallback onRetrieve;


  final double iconSize;

  const MenuButton({
    Key? key,
    this.icon = Icons.more_vert,
    this.showEdit = true,
    this.showFavorite = true,
    this.showDelete = true,
    this.showShare = true,
    required this.onEdit,
    required this.onToggleFavorite,
    required this.onDelete,
    required this.onShare,
    this.iconSize = 24.0,
    required this.removToggleFavorite,
    required this.showRetrieve, required this.onRetrieve, this.id,
  }) : super(key: key);

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
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

    return PopupMenuButton<int>(
      icon: Icon(widget.icon, size: width * 0.06, color: Colors.grey[700]),
      offset: Offset(0, 40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(width * 0.03),
      ),
      elevation: 3,
      itemBuilder: (context) {
        List<PopupMenuItem<int>> items = [];
        int valueCounter = 0;

        // زر التعديل
        if (widget.showEdit) {
          items.add(
            PopupMenuItem(
              value: valueCounter++,
              child: Container(
                width: width * 0.35,
                child: Row(
                  children: [
                    Icon(Icons.edit, size: width * 0.05, color: Colors.blue),
                    SizedBox(width: width * 0.03),
                    Text(GlobalLoc.instance.update, style: TextStyle(fontSize: width * 0.038)),
                  ],
                ),
              ),
            ),
          );
        }

        // زر المفضلة
        if (widget.showFavorite) {
          items.add(
            PopupMenuItem(
              value: valueCounter++,
              child: Container(
                width: width * 0.35,
                child: Row(
                  children: [
                    Icon(
                      chang ? Icons.favorite : Icons.favorite_border,
                      size: width * 0.05,
                      color: Colors.red,
                    ),
                    SizedBox(width: width * 0.03),
                    Text(
                      chang ? GlobalLoc.instance.unfavorite: GlobalLoc.instance.favorite,
                      style: TextStyle(fontSize: width * 0.038),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        // زر الحذف
        if (widget.showDelete) {
          items.add(
            PopupMenuItem(
              value: valueCounter++,
              child: Container(
                width: width * 0.35,
                child: Row(
                  children: [
                    Icon(Icons.delete, size: width * 0.05, color: Colors.red),
                    SizedBox(width: width * 0.03),
                    Text(
                      GlobalLoc.instance.delete,
                      style: TextStyle(
                        fontSize: width * 0.038,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        // زر المشاركة
        if (widget.showShare) {
          items.add(
            PopupMenuItem(
              value: valueCounter++,
              child: Container(
                width: width * 0.35,
                child: Row(
                  children: [
                    Icon(Icons.share, size: width * 0.05, color: Colors.green),
                    SizedBox(width: width * 0.03),
                    Text(GlobalLoc.instance.share, style: TextStyle(fontSize: width * 0.038)),
                  ],
                ),
              ),
            ),
          );
        }
        if (widget.showRetrieve) {
          items.add(
            PopupMenuItem(
              value: valueCounter++,
              child: Container(
                width: width * 0.35,
                child: Row(
                  children: [
                    Icon(
                      Icons.restore_from_trash,
                      size: width * 0.05,
                      color: Colors.green,
                    ),
                    SizedBox(width: width * 0.03),
                    Text(GlobalLoc.instance.restoreNote, style: TextStyle(fontSize: width * 0.038)),
                  ],
                ),
              ),
            ),
          );
        }

        return items;
      },
      onSelected: (value) {
        int counter = 0;

        if (widget.showEdit && value == counter++) {
          widget.onEdit();
        } else if (widget.showFavorite && value == counter++) {
          chang == false ? widget.onToggleFavorite() : widget.removToggleFavorite();
          _loadFavoriteStatus();
        } else if (widget.showDelete && value == counter++) {
          widget.onDelete();
        } else if (widget.showShare && value == counter++) {
          widget.onShare();
        } else if (widget.showRetrieve && value == counter++) {
          widget.onRetrieve();
        }
      },
    );
  }
}
