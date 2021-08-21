import 'package:briefy/components/main_route/main_route_bars.dart';
import 'package:briefy/components/main_route/note_list.dart';
import 'package:briefy/model/note_model.dart';
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
        // todo: передавать полученный из базы данных список заметок
        // child: NoteList(notes),
      ),
      bottomNavigationBar: CustomNavigationBar(
          level: level, context: context, callback: changeLevel),
    );
  }
}
