import 'dart:math';
import 'package:briefy/model/note_model.dart';
import 'package:briefy/utilities/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'note_card.dart';

class NoteList extends StatelessWidget {
  List<NoteModel> notes;

  NoteList(this.notes);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.all(6),
        itemCount: notes.length,
        itemBuilder: (BuildContext context, int index) {
          // todo: переделать создание карточек с класса Data на класс DBHandler:
          // получать данные в список объектов класса NoteModel
          return NoteCard(
            NoteModel.empty(
              id: notes[index].id,
              level: notes[index].level,
              // title: notes[index].title,
              // text: notes[index].text,
              // images: notes[index].images,
            ),
          );
        },
      ),
    );
  }
}