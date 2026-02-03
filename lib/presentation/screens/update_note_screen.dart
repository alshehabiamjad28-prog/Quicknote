import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:myproject/widgets/common/Custom_Dialog.dart';
import 'package:myproject/widgets/froms/show_date_pickerD.dart';
import '../../core/constants/services/notification_helper.dart';
import '../../core/constants/theme/color_helper.dart';
import '../../core/constants/utils/extentions/Global_loc.dart';
import '../../widgets/cards/update_screen_widgets.dart';
import '../../widgets/common/custom_floating_button.dart';
import '../../widgets/common/openColorPicker.dart';
import '../../widgets/froms/UndoRedoHandler.dart';
import '../controllers/notes_controller.dart';
import '../controllers/notification_controller.dart';


class UpdateNoteScreen extends StatefulWidget {
  final int id;
  final content;
  final title;
  final String? color;
  var colos;

  UpdateNoteScreen({
    super.key,
    this.content,
    this.title,
    this.color,
    required this.id,
  });

  @override
  State<UpdateNoteScreen> createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<UpdateNoteScreen> {
  final controller = Get.find<NotesController>();
  final noticontroller = Get.find<NotificationsController>();

  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  TextEditingController _NotititleController = TextEditingController();
  TextEditingController _NoticontentController = TextEditingController();
  TextEditingController _NotidateController = TextEditingController();

  late UndoRedoHandler _titleUndoRedo;
  late UndoRedoHandler _contentUndoRedo;
  String _lastActiveField = 'content';

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
    noticontroller.getNotificationsByNoteId(widget.id);
    dd();
    _titleUndoRedo = UndoRedoHandler(_titleController);
    _contentUndoRedo = UndoRedoHandler(_contentController);

    _titleController.addListener(() {
      _lastActiveField = 'title';
    });

    _contentController.addListener(() {
      _lastActiveField = 'content';
    });
  }

  void dd() {
    _contentController.text = widget.content.toString();
    _titleController.text = widget.title.toString();
  }

  @override
  void dispose() {
    _titleUndoRedo.dispose();
    _contentUndoRedo.dispose();
    super.dispose();
  }

  void _undo() {
    if (_lastActiveField == 'title') {
      _titleUndoRedo.undo();
    } else {
      _contentUndoRedo.undo();
    }
  }

  void _redo() {
    if (_lastActiveField == 'title') {
      _titleUndoRedo.redo();
    } else {
      _contentUndoRedo.redo();
    }
  }

  bool chang = false;

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
  void checkNotifiacion() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) async {
      if (!isAllowed) {


       NotificationHelper().requestPermission();


      }else{
        await noticontroller.hasNoteNotifications(widget.id) == false
            ? CustomDateTimePickerDialog(
          context: context,
          dateTimeController: _NotidateController,
          onConfirm: () async {
            noticontroller.addNotification(
              _titleController.text,
              _contentController.text,
              _NotidateController.text,
              widget.id as int,
            );
          },
          onCancel: () {},
          confirmText: GlobalLoc.instance.confirm,
          cancelText: GlobalLoc.instance.cancel,
        )
            : CustomDialog.show(
          textConfirm: GlobalLoc.instance.updateNotification,
          textCancel: GlobalLoc.instance.back,
          title: '',
          middleText: GlobalLoc.instance.notificationAlreadyExists,
          onConfirm: () {
            CustomDateTimePickerDialog(
              context: context,
              dateTimeController: _NotidateController,
              onConfirm: () {
                noticontroller.updateNotificationForNote(
                  _titleController.text,
                  _contentController.text,
                  _NotidateController.text,
                  widget.id as int,
                );
              },
              onCancel: () {},
              confirmText: GlobalLoc.instance.confirm,
              cancelText: GlobalLoc.instance.back,
            );
          },
          onCancel: () {},
        );
      }
    },
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    controller.noteColor.value = parseColor(widget.color);
    final theme = Theme.of(context).colorScheme.background;

    return Obx(() {
      return Scaffold(
        backgroundColor: controller.noteColor.value == Colors.white
            ? null
            : controller.noteColor.value,
        floatingActionButton: CustomFloatingButton(
          icon: Icons.check,
          onPressed: () {
            controller.updatenote(
              _titleController.text,
              _contentController.text,
              widget.id,
              cardColor: controller.noteColor.value,
            );
            Get.back();
          },
          size: 60.0,
        ),

        appBar: UpdateScreenWidgets(
          ischang: chang,
          color: controller.noteColor.value == Colors.white
              ? null
              : controller.noteColor.value,
          onUndo: _undo,
          onRedo: _redo,
          onColorPick: () {
            openColorPicker(selectedColor: controller.noteColor);
          },
          ondelete: () {
            controller.deletenote(widget.id);
            Get.back();
            // Navigator.of(context).pop();
          },
          onfavorite: () async {
            await controller.toggleFavorite(widget.id as int);
            _loadFavoriteStatus();
          },
          onDeletefavorite: () async {

            await controller.removeFromFavorites(widget.id as int);
            _loadFavoriteStatus();
          },
          onNotification: () async {
            checkNotifiacion();
          },
          title: GlobalLoc.instance.noteUpdated,
          deltedIcon: Icons.delete_outline,
          undoIcon: LineAwesomeIcons.undo_solid,
          redoIcon: LineAwesomeIcons.redo_solid,
          colorIcon: Icons.color_lens_outlined,
        ),
        body: Column(
          children: [
            // حقل العنوان
            Container(
              width: width * 0.9,
              margin: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: TextField(
                controller: _titleController,
                onChanged: (value) => _titleUndoRedo.onTextChanged(),
                decoration: InputDecoration(
                  hintText: GlobalLoc.instance.title,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: width * 0.04,
                    vertical: width * 0.03,
                  ),
                ),
                style: TextStyle(
                  fontSize: width * 0.06,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
              ),
            ),

            // حقل المحتوى
            Expanded(
              child: Container(
                width: width * 0.9,
                margin: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: TextField(
                  controller: _contentController,
                  onChanged: (value) => _contentUndoRedo.onTextChanged(),
                  decoration: InputDecoration(
                    hintText: GlobalLoc.instance.startWriting,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: width * 0.04,
                      vertical: width * 0.03,
                    ),
                  ),
                  style: TextStyle(fontSize: width * 0.045),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
