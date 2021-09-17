import 'package:briefy/components/main_route/empty_list_icon.dart';
import 'package:briefy/components/main_route/main_route_bars.dart';
import 'package:briefy/components/main_route/note_list.dart';
import 'package:briefy/db_handler.dart';
import 'package:briefy/model/note.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'edit_note_route.dart';

class MainRoute extends StatefulWidget {
  final dbHandler = DBHandler();
  var level = Level.red;
  List<Note> notes = [];
  var isSearchingMode = false;
  var searchQuery;

  MainRoute() {
    notes = dbHandler.getNotes(level);
  }

  @override
  _MainRouteState createState() => _MainRouteState();
}

class _MainRouteState extends State<MainRoute> {
  void _updateNotesList() {

    if (widget.isSearchingMode) {
      widget.notes = widget.dbHandler.getNotes();
      widget.notes.sort((a, b) => a.level.index.compareTo(b.level.index));
    } else {
      widget.notes = widget.dbHandler.getNotes(widget.level);
    }

    Future.delayed(const Duration(milliseconds: 0), () => setState(() {}));
  }

  void _update() => setState(() => _updateNotesList());

  void _updateSearchQuery(String searchQuery) {
    setState(() {
      if (widget.isSearchingMode) {
        widget.notes = widget.dbHandler.searchNotes(searchQuery);
        widget.notes.sort((a, b) => a.level.index.compareTo(b.level.index));
      }
    });
  }

  void _onNoteTap(int id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditNoteRoute(
          id: id,
          pageType: PageType.editNote,
          updateNotesList: _updateNotesList,
          setSearchMode: _setSearchingMode,
        ),
      ),
    );
  }

  void _changeLevel(Level level) {
    widget.level = level;
    setState(() => widget.notes = widget.dbHandler.getNotes(widget.level));
  }

  void _clearNotesBox() async {
    await widget.dbHandler.clearNotesBox();
    setState(() => widget.notes = widget.dbHandler.getNotes(widget.level));
  }

  void _setSearchingMode(bool mode) => widget.isSearchingMode = mode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        level: widget.level,
        isSearchingMode: widget.isSearchingMode,
        setSearchingMode: _setSearchingMode,
        menuFunctions: [_clearNotesBox],
        update: _update,
        updateSearchQuery: _updateSearchQuery,
      ),
      body: Stack(
        children: [
          if (widget.notes.isEmpty && !widget.isSearchingMode)
            EmptyListIconWidget(),
          if (widget.notes.isNotEmpty)
            DecoratedBox(
              decoration: BoxDecoration(color: Colors.grey.shade100),
              child: NoteList(
                notes: widget.notes,
                update: _updateNotesList,
                onNoteTap: _onNoteTap,
                context: context,
                isColoredNoteCard: widget.isSearchingMode,
              ),
            ),
        ],
      ),
      bottomNavigationBar: widget.isSearchingMode == false
          ? CustomNavigationBar(
              level: widget.level,
              context: context,
              changeLevel: _changeLevel,
              updateNotesList: _updateNotesList,
              setSearchMode: _setSearchingMode,
            )
          : SizedBox(),
    );
  }
}
