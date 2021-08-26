import 'dart:io';

import 'package:briefy/model/note.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  late final Note note;

  NoteCard(this.note);

  @override
  Widget build(BuildContext context) {
    return Card(
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
                IconButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.black54,
                  ),
                  onPressed: () => {},
                )
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
                    File(note.images[index].path),
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
    );
  }
}
