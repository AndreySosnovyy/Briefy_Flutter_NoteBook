import 'package:briefy/components/add_note_route/adding_bottom_sheet.dart';
import 'package:briefy/components/add_note_route/appbar_action_oval.dart';
import 'package:briefy/model/note_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddNoteRoute extends StatelessWidget {
  Level level;
  var images = [];

  AddNoteRoute(this.level) {
    //todo: создавать заметку с id, полученным из базы данных и уровнем
  }

  @override
  Widget build(BuildContext context) {
    var appbarActionOval = AppbarActionOval(level);
    var noteTitleFieldController = TextEditingController();
    var noteTextFieldController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        brightness: Brightness.light,
        title: Text(
          'Новая заметка',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          appbarActionOval,
          SizedBox(width: 14),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          // ~~~~~~~~~~~~~~~~~ блок картинок ~~~~~~~~~~~~~~~~~
          if (images.isNotEmpty)
            Container(
              height: 140,
              margin: EdgeInsets.fromLTRB(16, 0, 16, 10),
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: images.length,
                itemBuilder: (BuildContext context, int index) => ClipRRect(
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    images[index],
                    fit: BoxFit.cover,
                  ),
                ),
                separatorBuilder: (BuildContext context, int index) =>
                    SizedBox(width: 10),
              ),
            ),
          // ~~~~~~~~~~~~~~~~~ поле заголовка ~~~~~~~~~~~~~~~~~
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: noteTitleFieldController,
              maxLength: 128,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 4.0),
                counterText: '',
                border: InputBorder.none,
                hintText: 'Название',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          // ~~~~~~~~~~~~~~~~~ поле текста ~~~~~~~~~~~~~~~~~
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ScrollConfiguration(
                behavior: NoGlowBehavior(),
                child: TextField(
                  controller: noteTextFieldController,
                  maxLength: 2000,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  maxLines: null,
                  decoration: InputDecoration(
                    counterText: '',
                    border: InputBorder.none,
                    hintText: 'Текст',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ),
          ),
          // ~~~~~~~~~~~~~~~~~ панель тегов ~~~~~~~~~~~~~~~~~
          // todo: добавить теги (на pub.dev найти пакет для тегов)
          // ~~~~~~~~~~~~~~~~~ нижняя панель ~~~~~~~~~~~~~~~~~
          Row(
            children: [
              InkWell(
                enableFeedback: false,
                splashFactory: NoSplash.splashFactory,
                child: Container(
                  width: 50,
                  height: 50,
                  child: Center(
                    child: Icon(
                      Icons.add_circle_outline,
                      color: Colors.grey[700],
                      size: 28,
                    ),
                  ),
                ),
                onTap: () {
                  FocusScope.of(context).unfocus();
                  AddingBottomSheet.show(context);
                },
              ),
              Expanded(
                child: Center(
                  child: Text(
                    'Последнее изменение\nсегодня в 18:31',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              InkWell(
                enableFeedback: false,
                splashFactory: NoSplash.splashFactory,
                child: Container(
                  width: 50,
                  height: 50,
                  child: Center(
                    child: Icon(
                      Icons.more_vert,
                      color: Colors.grey[700],
                      size: 28,
                    ),
                  ),
                ),
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class NoGlowBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
