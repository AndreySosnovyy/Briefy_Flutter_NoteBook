import 'package:briefy/model/note_model.dart';
import 'package:briefy/routes/edit_note_route.dart';
import 'package:briefy/utilities/utils.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart' as Logging;
import '../../constants.dart';

class CustomNavigationBar extends StatelessWidget {
  final Level level;
  final BuildContext context;
  final Function callback;

  CustomNavigationBar({
    required this.level,
    required this.context,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    var logger = Logging.Logger(printer: Logging.PrettyPrinter());

    return CurvedNavigationBar(
      animationDuration: const Duration(milliseconds: 240),
      color: Utils.getMainColorByLevel(level),
      index: Utils.getIndexByLevel(level),
      backgroundColor: Utils.getLightColorByLevel(level),
      height: 50,
      onTap: (index) {
        if (index == Utils.getIndexByLevel(level)) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      // todo: переделать создание заметки (брать id из базы данных)
                      EditNoteRoute(NoteModel.empty(id: 0, level: level))));
        } else {
          callback(Utils.getLevelByIndex(index));
        }
      },
      items: [
        for (var level in Level.values)
          if (level == level)
            createAddNoteItem(Utils.getMainColorByLevel(level))
          else
            createDefaultItem(Utils.getMainColorByLevel(level))
      ],
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

class CustomAppBar extends AppBar {
  final Level level;

  CustomAppBar(this.level)
      : super(
          brightness: Brightness.dark,
          title: Text(
            Constants.appName,
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Utils.getMainColorByLevel(level),
        );
}
