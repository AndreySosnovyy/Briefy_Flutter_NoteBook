import 'package:briefy/Pages/red_page.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

enum AniProps { color1, color2 }

// продолжительность полного цикла анимации градиента в секундах
final animDuration = 3;

class AnimatedBackground extends StatelessWidget {
  late final _color1;
  late final _color2;
  late final _color3;
  late final _color4;
  late final _tween;

  AnimatedBackground(PageColor color) {
    switch (color) {
      case PageColor.red:
        _color1 = 0xFFF6BDC0;
        _color2 = 0xFFF1959B;
        _color3 = 0xFFF07470;
        _color4 = 0xFFEA4C46;
        break;
      case PageColor.yellow:
        _color1 = 0xFFFFFFB7;
        _color2 = 0xFFFFF192;
        _color3 = 0xFFFFEA61;
        _color4 = 0xFFFFDD3C;
        break;
      case PageColor.green:
        _color1 = 0xFFC5E8B7;
        _color2 = 0xFFABE098;
        _color3 = 0xFF83D475;
        _color4 = 0xFF57C84D;
        break;
    }

    _tween = TimelineTween<AniProps>()
      ..addScene(begin: 0.seconds, end: (animDuration / 2).seconds)
          .animate(AniProps.color1,
              tween: Color(_color1).tweenTo(Color(_color2)))
          .animate(AniProps.color2,
              tween: Color(_color3).tweenTo(Color(_color4)))
      ..addScene(begin: (animDuration / 2).seconds, end: animDuration.seconds)
          .animate(AniProps.color1,
              tween: Color(_color2).tweenTo(Color(_color1)))
          .animate(AniProps.color2,
              tween: Color(_color4).tweenTo(Color(_color3)));
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
