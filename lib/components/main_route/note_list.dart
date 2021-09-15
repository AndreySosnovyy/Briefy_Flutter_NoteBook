import 'package:briefy/model/note.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'note_card.dart';

class NoteList extends StatelessWidget {
  List<Note> notes;
  Function update;
  Function onNoteTap;
  final context;

  NoteList({
    required this.notes,
    required this.update,
    required this.onNoteTap,
    required this.context,
  });

  @override
  Widget build(BuildContext _) {
    return Container(
      constraints: BoxConstraints.expand(),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.all(6),
        itemCount: notes.length,
        itemBuilder: (BuildContext context, int index) {
          return NoteCard(
            note: notes[index],
            update: update,
            onNoteTap: onNoteTap,
            context: context,
          );
        },
      ),
    );
  }
}
