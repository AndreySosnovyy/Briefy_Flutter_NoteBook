import 'package:briefy/model/note.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils.dart';
import 'edit_bottom_sheet.dart';

class EditBottomPanel extends StatelessWidget {
  final Function setDeletingImagesMode;
  final Function update;
  final Function addImage;
  final context;
  final Note note;

  EditBottomPanel(
      {required this.context,
      required this.note,
      required this.setDeletingImagesMode,
      required this.update,
      required this.addImage});

  @override
  Widget build(BuildContext _) {
    return Row(
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
            setDeletingImagesMode(false);
            update();
            FocusScope.of(context).unfocus();
            AddingBottomSheet.show(
                context: context, addImage: addImage, update: update);
          },
        ),
        Expanded(
          child: Center(
            child: Text(
              'Последнее изменение\n${Utils.editedTimeToString(note.edited)}',
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
    );
  }
}
