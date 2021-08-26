import 'package:briefy/constants.dart';
import 'package:briefy/model/note.dart';
import 'package:flutter/material.dart';
import 'package:briefy/routes/main_route.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(BriefyApp());

class BriefyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BriefyApp();
}

class _BriefyApp extends State<BriefyApp> {

  initHive() async {
    final appDocsDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocsDir.path);
    Hive.registerAdapter(LevelAdapter());
    Hive.registerAdapter(NoteAdapter());
    await Hive.openBox<Note>('notes');
  }

  @override
  void initState() {
    initHive();
    super.initState();
  }

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
