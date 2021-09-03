import 'package:briefy/components/main_route/main_route_bars.dart';
import 'package:briefy/components/main_route/note_list.dart';
import 'package:briefy/db_handler.dart';
import 'package:briefy/model/note.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainRoute extends StatefulWidget {
  final dbHandler = DBHandler();
  var level = Level.red;
  var notes;

  MainRoute() {
    notes = dbHandler.getNotes(level);
  }

  @override
  _MainRouteState createState() => _MainRouteState();
}

class _MainRouteState extends State<MainRoute> {
  void _updateNotesList() {
    Future.delayed(
        const Duration(milliseconds: 0),
        () => setState(
            () => widget.notes = widget.dbHandler.getNotes(widget.level)));
  }

  void _changeLevel(Level level) {
    widget.level = level;
    setState(() => widget.notes = widget.dbHandler.getNotes(widget.level));
  }

  void _clearNotesBox() async {
    await widget.dbHandler.clearNotesBox();
    setState(() => widget.notes = widget.dbHandler.getNotes(widget.level));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(widget.level, [_clearNotesBox]),
      body: DecoratedBox(
        decoration: BoxDecoration(color: Colors.grey.shade100),
        child: NoteList(widget.notes, _updateNotesList),
      ),
      bottomNavigationBar: CustomNavigationBar(
        level: widget.level,
        context: context,
        changeLevel: _changeLevel,
        updateNotesList: _updateNotesList,
      ),
    );
  }
}
