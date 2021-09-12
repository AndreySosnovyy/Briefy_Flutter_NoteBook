import 'package:flutter/cupertino.dart';

class EmptyListIconWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/empty_list_icon512.png',
            width: 340,
            height: 210,
          ),
          SizedBox(height: 10),
          Text(
            'Здесь будут ваши заметки',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF24245B),
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
