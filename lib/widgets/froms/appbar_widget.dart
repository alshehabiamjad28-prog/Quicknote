import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../common/CustomIconButton.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onUndo;
  final VoidCallback onRedo;
  final VoidCallback onColorPick;
  final String title;
  final IconData undoIcon;
  final IconData redoIcon;
  final IconData colorIcon;
  final Color? backgroundColor;

  const AppbarWidget({
    Key? key,
    required this.onUndo,
    required this.onRedo,
    required this.onColorPick,
    this.title = '',
    this.undoIcon = LineAwesomeIcons.arrow_left_solid,
    this.redoIcon = LineAwesomeIcons.arrow_right_solid,
    this.colorIcon = Icons.color_lens_outlined, this.backgroundColor,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery
        .of(context)
        .size
        .width;

    return AppBar(
      backgroundColor: backgroundColor,
      title: Text(title),
      actions: [
        Container(
          margin: EdgeInsets.only(right: width * 0.1),
          child: Row(
            children: [
              CustomIconButton(
                icon: undoIcon,
                onPressed: onUndo,
              ),
              SizedBox(width: width * 0.02),
              CustomIconButton(
                icon: redoIcon,
                onPressed: onRedo,
              ),
            ],
          ),
        ),
        SizedBox(height: 30,),
        CustomIconButton(
          size: width * 0.07,
          icon: colorIcon,
          onPressed: onColorPick,
        ),
      ],
    );
  }
}