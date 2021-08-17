import 'package:briefy/model/note_model.dart';
import 'package:briefy/routes/add_note_route.dart';
import 'package:briefy/routes/green_route.dart';
import 'package:briefy/routes/red_route.dart';
import 'package:briefy/routes/yellow_route.dart';
import 'package:briefy/utilities/utils.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  late final Level routeLevel;
  late final BuildContext context;

  CustomNavigationBar(this.routeLevel, this.context);

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      animationDuration: const Duration(milliseconds: 260),
      color: Utils.getColorByLevel(routeLevel),
      index: Utils.getIndexByLevel(routeLevel),
      backgroundColor: Colors.white,
      height: 60,
      onTap: (index) {
        if (index == Utils.getIndexByLevel(routeLevel)) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddNoteRoute(routeLevel)));
        } else {
          switch (routeLevel) {
            case Level.red:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RedRoute()));
              break;
            case Level.yellow:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => YellowRoute()));
              break;
            case Level.green:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => YellowRoute()));
              break;
          }
        }
      },
      items: [
        for (var level in Level.values)
          if (routeLevel == level)
            getAddNoteItem(Utils.getColorByLevel(level))
          else
            getDefaultItem(Utils.getColorByLevel(level))
      ],
    );
  }

  Widget getDefaultItem(Color color) {
    return Container(
      height: 36,
      width: 36,
      child: DecoratedBox(
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      ),
    );
  }

  Widget getAddNoteItem(Color color) {
    return Container(
      height: 36,
      width: 36,
      child: DecoratedBox(
        child: Icon(Icons.add, size: 28, color: Colors.white),
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      ),
    );
  }
}
