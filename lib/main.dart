import 'dart:io';

import 'package:briefy/constants.dart';
import 'package:briefy/model/note.dart';
import 'package:flutter/material.dart';
import 'package:briefy/routes/main_route.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var docPath = (await getApplicationDocumentsDirectory()).path;
  if (!(await Directory(docPath + '/images').exists())) {
    await Directory(docPath + '/images').create();
  }
  Hive.init(docPath);
  Hive.registerAdapter<Level>(LevelAdapter());
  Hive.registerAdapter<Note>(NoteAdapter());
  await Hive.openBox<Note>(Constants.notesBoxName);
  runApp(BriefyApp());
}

class BriefyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Roboto'),
      home: MainRoute(),
    );
  }
}
