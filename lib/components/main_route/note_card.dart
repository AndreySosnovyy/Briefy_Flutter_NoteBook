import 'dart:io';
import 'package:briefy/db_handler.dart';
import 'package:briefy/model/note.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  Function update;
  Function onNoteTap;

  NoteCard({
    required this.note,
    required this.update,
    required this.onNoteTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      note.title,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  PopupMenuButton(
                      icon: Icon(Icons.more_vert, color: Colors.black54),
                      onSelected: (int value) async {
                        switch (value) {
                          case 0:
                          // todo: удалять заметку с анимацией
                            await DBHandler().deleteNote(note.id);
                            update();
                            break;
                        }
                      },
                      itemBuilder: (context) =>
                      [
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
                      ]),
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
                  itemBuilder: (BuildContext context, int index) =>
                      ClipRRect(
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
