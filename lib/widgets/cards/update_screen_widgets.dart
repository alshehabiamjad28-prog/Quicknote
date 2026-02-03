import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../common/CustomIconButton.dart';

class UpdateScreenWidgets extends StatelessWidget
    implements PreferredSizeWidget {
  final VoidCallback onUndo;
  final VoidCallback onRedo;
  final VoidCallback onColorPick;
  final VoidCallback ondelete;
  final VoidCallback onfavorite;
  final VoidCallback onDeletefavorite;

  final VoidCallback onNotification;

  final String title;
  final bool ischang;
  final IconData undoIcon;
  final IconData redoIcon;
  final IconData colorIcon;
  final IconData deltedIcon;

  final Color? color;

  const UpdateScreenWidgets(
     {
    Key? key, required this.ischang,
    required this.onUndo,
    required this.onRedo,
    required this.onColorPick,
    this.title = '',
    this.undoIcon = LineAwesomeIcons.arrow_left_solid,
    this.redoIcon = LineAwesomeIcons.arrow_right_solid,
    this.colorIcon = Icons.color_lens_outlined,
    required this.onfavorite,
    required this.ondelete,
    required this.color,
    required this.onNotification,
    required this.deltedIcon, required this.onDeletefavorite,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return AppBar(
      backgroundColor: color,
      title: Text(title),
      actions: [
        Container(
          margin: EdgeInsets.only(right: width * 0.03),
          child: Row(
            children: [
              CustomIconButton(icon: undoIcon, onPressed: onUndo),
              SizedBox(width: width * 0.02),
              CustomIconButton(icon: redoIcon, onPressed: onRedo),
            ],
          ),
        ),
        CustomIconButton(
          size: width * 0.06,
          icon: colorIcon,
          onPressed: onColorPick,
        ),
        CustomIconButton(
          size: width * 0.06,
          icon: Icons.edit_notifications_outlined,
          onPressed: onNotification,
        ),

        CustomIconButton(
          size: width * 0.06,
          icon: ischang == false ? Icons.favorite_border : Icons.favorite,
          iconColor: ischang == false ? null : Colors.red,
          onPressed: ischang == false ? onfavorite :onDeletefavorite,
        ),

        CustomIconButton(
          size: width * 0.06,
          icon: Icons.delete_outlined,
          onPressed: ondelete,
        ),
      ],
    );
  }
}
