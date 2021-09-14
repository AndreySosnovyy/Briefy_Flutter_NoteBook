import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FullScreenImageRoute extends StatelessWidget {
  Image image;
  var tag;

  FullScreenImageRoute(this.image,  this.tag);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.black),
          child: Center(
            child: Hero(
              tag: tag,
              child: image,
            ),
          ),
        ),
      ),
    );
  }
}
