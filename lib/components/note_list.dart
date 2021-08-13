import 'dart:math';
import 'package:briefy/model/note_model.dart';
import 'package:briefy/utilities/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'note_card.dart';

class NoteList extends StatelessWidget {
  late final Level level;

  NoteList(this.level);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.all(6),
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          // todo: переделать создание карточек с класса Data на класс DBHandler:
          // получать данные в список объектов класса NoteModel
          return NoteCard(
            NoteModel(
              id: index,
              level: Level.red,
              title: Data.getRandomTitle(),
              text: Data.getRandomText(),
              images: [
                for (var i = 0; i < Random().nextInt(5); i++)
                  Data.getRandomNetworkImageURI()
              ],
            ),
          );
        },
      ),
    );
  }
}
