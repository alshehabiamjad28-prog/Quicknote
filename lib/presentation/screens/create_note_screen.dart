import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../../core/constants/utils/extentions/Global_loc.dart';
import '../../widgets/common/custom_floating_button.dart';
import '../../widgets/common/openColorPicker.dart';
import '../../widgets/froms/UndoRedoHandler.dart';
import '../../widgets/froms/appbar_widget.dart';
import '../controllers/notes_controller.dart';


class CreateNoteScreen extends StatefulWidget {
  const CreateNoteScreen({super.key});

  @override
  State<CreateNoteScreen> createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  final controller = Get.find<NotesController>();

  ValueNotifier<String> _colorNotifier = ValueNotifier('#FFFFFF');
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  late UndoRedoHandler _titleUndoRedo;
  late UndoRedoHandler _contentUndoRedo;
  String _lastActiveField = 'content';

  @override
  void initState() {
    super.initState();
    _titleUndoRedo = UndoRedoHandler(_titleController);
    _contentUndoRedo = UndoRedoHandler(_contentController);

    _titleController.addListener(() {
      _lastActiveField = 'title';
    });

    _contentController.addListener(() {
      _lastActiveField = 'content';
    });
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

  void _onColorPick() {}

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme.background;
    final width = MediaQuery.of(context).size.width;

    return Obx(() {
      return Scaffold(
        backgroundColor: controller.noteColor.value == Colors.white
            ? null
            : controller.noteColor.value,
        floatingActionButton: CustomFloatingButton(
          icon: LineAwesomeIcons.check_solid,
          onPressed: () {
            controller.insertnote(
              _titleController.text,
              _contentController.text,
              cardColor: controller.noteColor.value,
            );

            print(controller.noteColor.value);
          },
          size: 60.0,
        ),

        appBar: AppbarWidget(
          backgroundColor: controller.noteColor.value == Colors.white
              ? null
              : controller.noteColor.value,
          onUndo: _undo,
          onRedo: _redo,
          onColorPick: () {
            openColorPicker(selectedColor: controller.noteColor);
          },
          title: GlobalLoc.instance.createNote,
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
