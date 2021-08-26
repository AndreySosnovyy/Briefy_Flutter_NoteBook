import 'package:briefy/model/note.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

enum AniProps { color1, color2 }

// продолжительность полного цикла анимации градиента в секундах
const animDuration = 3;

class AnimatedBackground extends StatelessWidget {
  late final _colorCode1;
  late final _colorCode2;
  late final _colorCode3;
  late final _colorCode4;
  late final _tween;

  AnimatedBackground(Level level) {
    switch (level) {
      case Level.red:
        _colorCode1 = 0xFFF6BDC0;
        _colorCode2 = 0xFFF1959B;
        _colorCode3 = 0xFFF07470;
        _colorCode4 = 0xFFEA4C46;
        break;
      case Level.yellow:
        _colorCode1 = 0xFFFFFFB7;
        _colorCode2 = 0xFFFFF192;
        _colorCode3 = 0xFFFFEA61;
        _colorCode4 = 0xFFFFDD3C;
        break;
      case Level.green:
        _colorCode1 = 0xFFC5E8B7;
        _colorCode2 = 0xFFABE098;
        _colorCode3 = 0xFF83D475;
        _colorCode4 = 0xFF57C84D;
        break;
    }

    _tween = TimelineTween<AniProps>()
      ..addScene(begin: 0.seconds, end: (animDuration / 2).seconds)
          .animate(AniProps.color1,
              tween: Color(_colorCode1).tweenTo(Color(_colorCode2)))
          .animate(AniProps.color2,
              tween: Color(_colorCode3).tweenTo(Color(_colorCode4)))
      ..addScene(begin: (animDuration / 2).seconds, end: animDuration.seconds)
          .animate(AniProps.color1,
              tween: Color(_colorCode2).tweenTo(Color(_colorCode1)))
          .animate(AniProps.color2,
              tween: Color(_colorCode4).tweenTo(Color(_colorCode3)));
  }

  @override
  Widget build(BuildContext context) {
    return LoopAnimation<TimelineValue<AniProps>>(
      tween: _tween,
      duration: _tween.duration,
      builder: (context, child, value) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                value.get(AniProps.color1),
                value.get(AniProps.color2),
                value.get(AniProps.color1),
              ],
            ),
          ),
        );
      },
    );
  }
}
