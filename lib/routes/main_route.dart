import 'package:briefy/components/lists/background.dart';
import 'package:briefy/components/lists/main_route_bars.dart';
import 'package:briefy/components/lists/note_list.dart';
import 'package:briefy/constants.dart';
import 'package:briefy/model/note_model.dart';
import 'package:briefy/utilities/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainRoute extends StatefulWidget {
  @override
  _MainRouteState createState() => _MainRouteState();
}

class _MainRouteState extends State<MainRoute> {
  var level = Level.red;

  void changeLevel(Level level) => setState(() => this.level = level);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(level),
      body: DecoratedBox(
        decoration: BoxDecoration(color: Colors.grey.shade300),
        child: Stack(
          children: [
            // AnimatedBackground(level),
            NoteList(level),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        routeLevel: level, context: context, callback: changeLevel),
    );
  }
}
