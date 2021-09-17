import 'package:briefy/db_handler.dart';
import 'package:briefy/model/note.dart';
import 'package:briefy/routes/edit_note_route.dart';
import 'package:briefy/utils.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';

class CustomNavigationBar extends StatelessWidget {
  final Level level;
  final BuildContext context;
  final Function changeLevel;
  final Function updateNotesList;
  final Function setSearchMode;

  CustomNavigationBar({
    required this.level,
    required this.context,
    required this.changeLevel,
    required this.updateNotesList,
    required this.setSearchMode,
  });

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      animationDuration: const Duration(milliseconds: 240),
      color: Utils.getMainColorByLevel(level),
      index: Utils.getIndexByLevel(level),
      backgroundColor: Utils.getLightColorByLevel(level),
      height: 50,
      items: [
        for (var _level in Level.values)
          if (_level == level)
            createAddNoteItem(Utils.getMainColorByLevel(_level))
          else
            createDefaultItem(Utils.getMainColorByLevel(_level))
      ],
      onTap: (index) async {
        if (index == Utils.getIndexByLevel(level)) {
          var dbHandler = DBHandler();
          var id = dbHandler.getNewId();
          await dbHandler.addNote(Note.empty(id: id, level: level));
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditNoteRoute(
                id: id,
                pageType: PageType.newNote,
                updateNotesList: updateNotesList,
                setSearchMode: setSearchMode,
              ),
            ),
          );
        } else {
          changeLevel(Utils.getLevelByIndex(index));
        }
      },
    );
  }

  Widget createDefaultItem(Color color) {
    return Container(
      height: 40,
      width: 40,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          // border: Border.all(width: 5, color: Colors.white),
        ),
      ),
    );
  }

  Widget createAddNoteItem(Color color) {
    return Container(
      height: 40,
      width: 40,
      child: DecoratedBox(
        child: Icon(Icons.add, size: 36, color: Colors.white),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
    );
  }
}

class MainAppBar extends AppBar {
  final Level level;
  final isSearchingMode;
  final Function setSearchingMode;
  final Function update;
  final Function updateSearchQuery;

  MainAppBar(
      {required this.level,
      required this.isSearchingMode,
      required this.setSearchingMode,
      required List<Function> menuFunctions,
      required this.update,
      required this.updateSearchQuery})
      : super(
          brightness: Brightness.dark,
          leading: SizedBox(),
          title: Stack(children: [
            if (!isSearchingMode)
              Text(
                Constants.appName,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
            if (isSearchingMode)
              TextField(
                onChanged: (String searchQuery) =>
                    updateSearchQuery(searchQuery),
                autofocus: true,
                cursorColor: Colors.white,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
                decoration: new InputDecoration(
                  hintText: ' Поиск',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade200,
                    fontSize: 18,
                  ),
                  border: InputBorder.none,
                ),
              ),
          ]),
          actions: [
            if (!isSearchingMode)
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  setSearchingMode(!isSearchingMode);
                  update();
                },
              ),
            if (isSearchingMode)
              IconButton(
                icon: Icon(Icons.search_off),
                onPressed: () {
                  setSearchingMode(!isSearchingMode);
                  update();
                },
              ),
            PopupMenuButton(
                icon: Icon(Icons.more_vert),
                onSelected: (int value) {
                  menuFunctions[value]();
                },
                itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Row(
                          children: [
                            Icon(Icons.delete_outline, color: Colors.black),
                            SizedBox(width: 6),
                            Text("Удалить все заметки"),
                          ],
                        ),
                        value: 0,
                      ),
                    ])
          ],
          centerTitle: true,
          backgroundColor: Utils.getMainColorByLevel(level),
        );
}
