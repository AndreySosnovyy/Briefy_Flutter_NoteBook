import 'dart:io';
import 'package:briefy/components/edit_note_route/edit_appbar.dart';
import 'package:briefy/components/edit_note_route/edit_bottom_panel.dart';
import 'package:briefy/components/edit_note_route/edit_bottom_sheet.dart';
import 'package:briefy/components/edit_note_route/appbar_action_oval.dart';
import 'package:briefy/components/edit_note_route/edit_images_block.dart';
import 'package:briefy/components/edit_note_route/edit_textfields.dart';
import 'package:briefy/db_handler.dart';
import 'package:briefy/model/note.dart';
import 'package:briefy/routes/full_sreen_image_route.dart';
import 'package:briefy/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart' as Logging;
import 'package:path_provider/path_provider.dart';

enum PageType { newNote, editNote }

class EditNoteRoute extends StatefulWidget {
  final dbHandler = DBHandler();
  late final Note note;
  final PageType pageType;
  late final Function updateNotesList;
  var deletingImagesMode = false;

  EditNoteRoute({
    required int id,
    required this.pageType,
    required this.updateNotesList,
  }) {
    note = DBHandler().getNoteById(id);
  }

  @override
  _EditNoteRoute createState() => _EditNoteRoute();
}

class _EditNoteRoute extends State<EditNoteRoute> {
  // var logger = Logging.Logger(printer: Logging.PrettyPrinter());

  void _update() {
    Future.delayed(Duration(milliseconds: 1), () => setState(() {}));
  }

  void _addImage(File image) async {
    var docPath = (await getApplicationDocumentsDirectory()).path;
    var newPath = docPath + '/images/${image.path.split('/').last}';
    widget.note.images.add(newPath);
    image.copy(newPath);
    image.delete();
  }

  void _updateEditedTime() => widget.note.edited = DateTime.now();

  void _updateNoteLevel() => widget.note.level = appbarActionOval.getLevel();

  void _updateTitle(String title) => widget.note.title = title.trimRight();

  void _updateText(String text) => widget.note.text = text;

  void _setDeletingImagesMode(bool mode) => widget.deletingImagesMode = mode;

  var appbarActionOval = AppbarActionOval();
  var noteTitleFieldController = TextEditingController();
  var noteTextFieldController = TextEditingController();

  @override
  void dispose() {
    _updateEditedTime();
    widget.note.save();
    super.dispose();
    widget.updateNotesList();
  }

  @override
  Widget build(BuildContext context) {
    appbarActionOval.level = widget.note.level;
    appbarActionOval.updateLevel = _updateNoteLevel;

    noteTitleFieldController.text =
        widget.note.title == 'Новая заметка' ? '' : widget.note.title;
    noteTextFieldController.text = widget.note.text;

    final appbarTitle =
        widget.pageType == PageType.newNote ? 'Новая заметка' : 'Редактировать';

    return Scaffold(
      appBar: EditAppbar(appbarTitle, appbarActionOval),
      body: Column(
        children: [
          SizedBox(height: 20),
          // ~~~~~~~~~~~~~~~~~ блок картинок ~~~~~~~~~~~~~~~~~
          if (widget.note.images.isNotEmpty)
            ImagesBlock(
              note: widget.note,
              deletingImagesMode: widget.deletingImagesMode,
              setDeletingImagesMode: _setDeletingImagesMode,
              update: _update,
            ),
          // ~~~~~~~~~~~~~~~~~ поле заголовка ~~~~~~~~~~~~~~~~~
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: NoteTitleTextField(
              controller: noteTitleFieldController,
              setDeletingImagesMode: _setDeletingImagesMode,
              update: _update,
              updateTitle: _updateTitle,
            ),
          ),
          // ~~~~~~~~~~~~~~~~~ поле текста ~~~~~~~~~~~~~~~~~
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ScrollConfiguration(
                behavior: NoGlowBehavior(),
                child: NoteTextTextField(
                  controller: noteTextFieldController,
                  setDeletingImagesMode: _setDeletingImagesMode,
                  update: _update,
                  updateText: _updateText,
                ),
              ),
            ),
          ),
          // ~~~~~~~~~~~~~~~~~ панель тегов ~~~~~~~~~~~~~~~~~
          // добавить теги (pub.dev)
          // ~~~~~~~~~~~~~~~~~ нижняя панель ~~~~~~~~~~~~~~~~~
          EditBottomPanel(
            context: context,
            note: widget.note,
            setDeletingImagesMode: _setDeletingImagesMode,
            update: _update,
            addImage: _addImage,
          )
        ],
      ),
    );
  }
}

class NoGlowBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
