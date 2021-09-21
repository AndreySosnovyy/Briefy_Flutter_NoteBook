import 'dart:io';
import 'package:briefy/db_handler.dart';
import 'package:briefy/model/note.dart';
import 'package:briefy/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  Function update;
  Function onNoteTap;
  final context;
  final isColoredNoteCard;

  NoteCard({
    required this.note,
    required this.update,
    required this.onNoteTap,
    required this.context,
    required this.isColoredNoteCard,
  });

  @override
  Widget build(BuildContext _) {
    var headerTextColor = isColoredNoteCard == true
        ? Utils.getMainColorByLevel(note.level)
        : Colors.black;
    var headerIconColor =
        isColoredNoteCard == true ? Colors.white : Colors.black54;

    final snackBar = SnackBar(
      content: Text('Отменить удаление?'),
      duration: Duration(seconds: 4),
      backgroundColor: Colors.grey.shade400,
      action: SnackBarAction(
        label: 'Да',
        onPressed: () {
          Note note = DeletedNotesBuffer().get();
          DBHandler().addNote(note);
          update();
        },
      ),
    );

    return InkWell(
      enableFeedback: false,
      splashFactory: NoSplash.splashFactory,
      onTap: () => onNoteTap(note.id),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        color: Colors.grey.shade50,
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ~~~~~~~~~~~ заголовок ~~~~~~~~~~~
            Container(
              margin: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.,
                children: [
                  if (note.isPinned)
                    Icon(Icons.push_pin, color: headerIconColor),
                  if (note.isPinned) SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      note.title,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: headerTextColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // Spacer(),
                  PopupMenuButton(
                    icon: Icon(Icons.more_vert, color: headerIconColor),
                    onSelected: (int value) async {
                      switch (value) {
                        case 0:
                          // todo: удалять заметку с анимацией
                          await DBHandler().deleteNote(note.id);
                          update();
                          DeletedNotesBuffer().add(note);
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          break;
                        case 1:
                          await DBHandler().pinNote(note.id);
                          update();
                          break;
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Row(
                          children: [
                            Icon(Icons.delete_outline, color: Colors.black),
                            SizedBox(width: 6),
                            Text("Удалить заметку"),
                          ],
                        ),
                        value: 0,
                      ),
                      PopupMenuItem(
                        child: Row(
                          children: [
                            Icon(Icons.push_pin_outlined, color: Colors.black),
                            SizedBox(width: 6),
                            Text(note.isPinned == true
                                ? 'Открепить'
                                : 'Закрепить'),
                          ],
                        ),
                        value: 1,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (note.images.length > 0)
              // ~~~~~~~~~~~ блок картинок ~~~~~~~~~~~
              Container(
                height: 140,
                margin: EdgeInsets.fromLTRB(16, 0, 16, 10),
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: note.images.length,
                  itemBuilder: (BuildContext context, int index) => ClipRRect(
                    clipBehavior: Clip.antiAlias,
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      File(note.images[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(width: 10),
                ),
              ),
            if (note.text.isNotEmpty)
              // ~~~~~~~~~~~ блок текста ~~~~~~~~~~~
              Container(
                margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Text(
                  note.text,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                  ),
                  maxLines: 5,
                  overflow: TextOverflow.fade,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
