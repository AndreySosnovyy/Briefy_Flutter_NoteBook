import 'dart:io';
import 'package:briefy/components/edit_note_route/edit_bottom_sheet.dart';
import 'package:briefy/components/edit_note_route/appbar_action_oval.dart';
import 'package:briefy/db_handler.dart';
import 'package:briefy/model/note.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        brightness: Brightness.light,
        title: Text(
          appbarTitle,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          appbarActionOval,
          SizedBox(width: 14),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          // ~~~~~~~~~~~~~~~~~ блок картинок ~~~~~~~~~~~~~~~~~
          if (widget.note.images.isNotEmpty)
            Container(
              height: 140,
              margin: EdgeInsets.fromLTRB(16, 0, 16, 10),
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: widget.note.images.length,
                itemBuilder: (BuildContext context, int index) => ClipRRect(
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    enableFeedback: false,
                    splashFactory: NoSplash.splashFactory,
                    onTap: () {
                      // todo: показывать изображение во весь экран
                    },
                    onLongPress: () =>
                        setState(() => widget.deletingImagesMode = true),
                    child: Stack(
                      children: [
                        Image.file(
                          File(widget.note.images[index]),
                          fit: BoxFit.cover,
                        ),
                        if (widget.deletingImagesMode)
                          Positioned(
                            top: 5,
                            right: 5,
                            child: InkWell(
                              enableFeedback: false,
                              splashFactory: NoSplash.splashFactory,
                              onTap: () {
                                DBHandler().deleteImage(
                                    noteId: widget.note.id, imageIndex: index);
                                setState(() {});
                              },
                              child: Container(
                                width: 42,
                                height: 42,
                                decoration: BoxDecoration(
                                  color: Color(0x96FFFFFF),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.clear,
                                  size: 36,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                separatorBuilder: (BuildContext context, int index) =>
                    SizedBox(width: 10),
              ),
            ),
          // ~~~~~~~~~~~~~~~~~ поле заголовка ~~~~~~~~~~~~~~~~~
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              onTap: () => setState(() => widget.deletingImagesMode = false),
              controller: noteTitleFieldController,
              onChanged: (text) => _updateTitle(text),
              maxLength: 128,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 4.0),
                counterText: '',
                border: InputBorder.none,
                hintText: 'Название',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          // ~~~~~~~~~~~~~~~~~ поле текста ~~~~~~~~~~~~~~~~~
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ScrollConfiguration(
                behavior: NoGlowBehavior(),
                child: TextField(
                  onTap: () =>
                      setState(() => widget.deletingImagesMode = false),
                  controller: noteTextFieldController,
                  onChanged: (text) => _updateText(text),
                  maxLength: 2000,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  maxLines: null,
                  decoration: InputDecoration(
                    counterText: '',
                    border: InputBorder.none,
                    hintText: 'Текст',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ),
          ),
          // ~~~~~~~~~~~~~~~~~ панель тегов ~~~~~~~~~~~~~~~~~
          // добавить теги (pub.dev)
          // ~~~~~~~~~~~~~~~~~ нижняя панель ~~~~~~~~~~~~~~~~~
          Row(
            children: [
              InkWell(
                enableFeedback: false,
                splashFactory: NoSplash.splashFactory,
                child: Container(
                  width: 50,
                  height: 50,
                  child: Center(
                    child: Icon(
                      Icons.add_circle_outline,
                      color: Colors.grey[700],
                      size: 28,
                    ),
                  ),
                ),
                onTap: () {
                  setState(() => widget.deletingImagesMode = false);
                  FocusScope.of(context).unfocus();
                  AddingBottomSheet.show(
                      context: context, addImage: _addImage, update: _update);
                },
              ),
              Expanded(
                child: Center(
                  child: Text(
                    'Последнее изменение\n${Utils.editedTimeToString(widget.note.edited)}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              InkWell(
                enableFeedback: false,
                splashFactory: NoSplash.splashFactory,
                child: Container(
                  width: 50,
                  height: 50,
                  child: Center(
                    child: Icon(
                      Icons.more_vert,
                      color: Colors.grey[700],
                      size: 28,
                    ),
                  ),
                ),
                onTap: () {},
              ),
            ],
          ),
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
