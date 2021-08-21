// import 'package:briefy/model/note_model.dart';
// import 'package:briefy/routes/edit_note_route.dart';
// import 'package:briefy/utilities/utils.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class AddNoteButton extends StatelessWidget {
//   final Level level;
//
//   AddNoteButton(this.level);
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       enableFeedback: false,
//       splashFactory: NoSplash.splashFactory,
//       onTap: () {
//         Navigator.push(context,
//             MaterialPageRoute(builder: (context) =>
//                 EditNoteRoute(NoteModel(id: 0, level: level))));
//       },
//       child: Container(
//         width: 56,
//         height: 56,
//         decoration: BoxDecoration(
//           color: Utils.getMainColorByLevel(level),
//           shape: BoxShape.circle,
//         ),
//         child: Icon(Icons.add, size: 38, color: Colors.white),
//       ),
//     );
//   }
// }
