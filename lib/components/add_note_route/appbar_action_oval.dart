import 'package:briefy/model/note_model.dart';
import 'package:briefy/utilities/utils.dart';
import 'package:flutter/material.dart';

class AppbarActionOval extends StatefulWidget {
  Level level;

  AppbarActionOval(this.level);

  Level getLevel() {
    return level;
  }

  @override
  _AppbarActionOvalState createState() => _AppbarActionOvalState();
}

class _AppbarActionOvalState extends State<AppbarActionOval> {

  void setNextColor() {
    setState(() {
      widget.level = Utils.getNextLevel(widget.level);
    });
  }

  @override
  Widget build(BuildContext context) {
    Color color = Utils.getMainColorByLevel(widget.level);

    return InkWell(
      enableFeedback: false,
      splashFactory: NoSplash.splashFactory,
      onTap: () => setNextColor(),
      child: Center(
        child: Container(
          height: 28,
          width: 48,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            border: Border.all(width: 2.5, color: Colors.black87),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Center(
            child: Container(
              height: 16,
              width: 36,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}