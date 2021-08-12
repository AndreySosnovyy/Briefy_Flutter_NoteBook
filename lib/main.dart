import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:briefy/Pages/red_page.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(BriefyApp());
}

class BriefyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: dotenv.env['APP_NAME'].toString(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Roboto'),
      home: RedPage(),
    );
  }
}
