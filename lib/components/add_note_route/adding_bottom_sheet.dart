import 'dart:ui';
import 'package:flutter/material.dart';

class AddingBottomSheet {
  static Future show(BuildContext context) {
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
                      ),),
                  ),
                ),
                // todo: вынести создание плитки в функцию
                ListTile(
                  leading: Icon(
                    Icons.photo_camera_outlined,
                    color: Colors.grey[700],
                  ),
                  title: Text(
                    'Сфотографировать',
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.image_outlined,
                    color: Colors.grey[700],
                  ),
                  title: Text(
                    'Добавить из галереи',
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.list_alt,
                    color: Colors.grey[700],
                  ),
                  title: Text(
                    'Добавить список',
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.label_outline,
                    color: Colors.grey[700],
                  ),
                  title: Text(
                    'Добавить тег',
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ]);
        }).whenComplete(() {});
  }
}
