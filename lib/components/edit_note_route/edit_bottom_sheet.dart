import 'dart:io';
import 'package:briefy/model/note_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddingBottomSheet {
  static Future show(
      {required BuildContext context,
      required Function addImage,
      required Function update}) {
    final ImagePicker _picker = ImagePicker();
    return showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28),
          ),
        ),
        builder: (context) {
          return Wrap(children: [
            Column(
              children: [
                SizedBox(height: 20),
                Container(
                  height: 3,
                  width: 120,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.grey[700],
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                ),
                createTile(
                  context: context,
                  icon: Icons.photo_camera_outlined,
                  text: 'Сфотографировать',
                  function: () async {
                    final pickedFile = await _picker.pickImage(
                      source: ImageSource.camera,
                      imageQuality: 50,
                    );
                    if (pickedFile == null) {
                      return;
                    } else {
                      addImage(File(pickedFile.path));
                      update();
                    }
                  },
                ),
                createTile(
                  context: context,
                  icon: Icons.image_outlined,
                  text: 'Добавить из галереи',
                  function: () async {
                    final pickedFileList = await _picker.pickMultiImage(
                      imageQuality: 50,
                    );
                    if (pickedFileList == null) {
                      return;
                    } else {
                      pickedFileList.forEach((xFile) {
                        addImage(File(xFile.path));
                      });
                      update();
                    }
                  },
                ),
                createTile(
                  context: context,
                  icon: Icons.list_alt,
                  text: 'Добавить список',
                  function: () {},
                ),
                createTile(
                  context: context,
                  icon: Icons.label_outline,
                  text: 'Добавить тег',
                  function: () {},
                ),
              ],
            ),
          ]);
        }).whenComplete(() {});
  }

  static Widget createTile(
      {required BuildContext context,
      required IconData icon,
      required String text,
      required Function function}) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.grey[700],
      ),
      title: Text(
        text,
        style: TextStyle(fontSize: 18),
      ),
      onTap: () {
        function();
        Navigator.pop(context);
      },
    );
  }
}
