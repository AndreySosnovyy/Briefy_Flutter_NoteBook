import 'dart:io';

import 'package:briefy/model/note.dart';
import 'package:briefy/routes/full_sreen_image_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../db_handler.dart';

class ImagesBlock extends StatelessWidget {
  final Note note;
  final deletingImagesMode;
  final Function setDeletingImagesMode;
  final Function update;

  ImagesBlock(
      {required this.note,
      required this.deletingImagesMode,
      required this.setDeletingImagesMode,
      required this.update,});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      margin: EdgeInsets.fromLTRB(16, 0, 16, 10),
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: note.images.length,
        itemBuilder: (BuildContext context, int index) => ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            enableFeedback: false,
            splashFactory: NoSplash.splashFactory,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FullScreenImageRoute(
                    Image.file(
                      File(
                        note.images[index],
                      ),
                    ),
                    'image$index'),
              ),
            ),
            onLongPress: () {
              setDeletingImagesMode(true);
              update();
            },
            child: Stack(
              children: [
                Hero(
                  tag: 'image$index',
                  child: Image.file(
                    File(note.images[index]),
                    fit: BoxFit.cover,
                  ),
                ),
                if (deletingImagesMode)
                  Positioned(
                    top: 5,
                    right: 5,
                    child: InkWell(
                      enableFeedback: false,
                      splashFactory: NoSplash.splashFactory,
                      onTap: () {
                        DBHandler()
                            .deleteImage(noteId: note.id, imageIndex: index);
                        update();
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
    );
  }
}
