import 'package:briefy/constants.dart';
import 'package:flutter/material.dart';
import 'package:briefy/Pages/red_page.dart';

void main() async {
  // await dotenv.load(fileName: '.env');
  runApp(BriefyApp());
}

class BriefyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Roboto'),
      home: RedPage(),
    );
  }
}
