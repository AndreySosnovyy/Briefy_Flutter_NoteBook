import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:random_string/random_string.dart';

class RedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          dotenv.env['APP_NAME'].toString(),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: Icon(
          Icons.add,
          size: 38,
        ),
        onPressed: () {},
      ),
      body: Container(
        color: Color.fromARGB(255, 255, 200, 200),
        constraints: BoxConstraints.expand(),
        child: GlowingOverscrollIndicator(
          axisDirection: AxisDirection.down,
          color: Colors.red,
          child: ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.all(6),
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return noteCard(getRandomTitle(), getRandomText(), [
                for (var i = 0; i < Random().nextInt(5); i++)
                  getRandomNetworkImageURI()
              ]);
            },
          ),
        ),
      ),
    );
  }

  Widget noteCard(String title, String text, List<String> imageURIs) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      color: Colors.white,
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ~~~~~~~~~~~ заголовок ~~~~~~~~~~~
          Container(
            margin: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                IconButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.black54,
                  ),
                  onPressed: () => {},
                )
              ],
            ),
          ),
          if (imageURIs.length > 0)
            // ~~~~~~~~~~~ блок картинок ~~~~~~~~~~~
            Container(
              height: 140,
              margin: EdgeInsets.fromLTRB(16, 0, 16, 10),
              child: GlowingOverscrollIndicator(
                axisDirection: AxisDirection.right,
                color: Colors.white,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: imageURIs.length,
                  itemBuilder: (BuildContext context, int index) => ClipRRect(
                    clipBehavior: Clip.antiAlias,
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      imageURIs[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(width: 10),
                ),
              ),
            ),
          if (text.isNotEmpty)
            // ~~~~~~~~~~~ блок текста ~~~~~~~~~~~
            Container(
              margin: EdgeInsets.fromLTRB(16, 0, 16, 10),
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                ),
                maxLines: 5,
                overflow: TextOverflow.fade,
              ),
            ),
        ],
      ),
    );
  }

  String getRandomNetworkImageURI() {
    var URI = 'https://picsum.photos/seed/${Random().nextInt(999)}/';
    for (var i = 0; i < 2; i++)
      Random().nextBool() == true ? URI = URI + '300/' : URI = URI + '200/';
    return URI;
  }

  String getRandomTitle() {
    var titles = [
      'СРОЧНО!',
      'Сделать до вторника',
      'Задания',
      'ОГЭ',
      'Программирование'
    ];
    return titles[Random().nextInt(titles.length)];
  }

  String getRandomText() {
    var texts = [
      '''1) Убраться в комнате
2) Сделать уроки
3)Полить цветы''',
      '''Мы сидим и смотрим в окна.
Тучи по небу летят.
На дворе собаки мокнут,
Даже лаять не хотят.
Где же солнце?
Что случилось?
Целый день течет вода.
На дворе такая сырость,
Что не выйдешь никуда.''',
      'В строительном магазине надо будет купить трубы, гвозди, мешок цемента и не забыть новый мотор для вентилятора',
      'До дедлайна надо отправить на ревью программу и добавить новые картинки'
    ];
    return texts[Random().nextInt(texts.length)];
  }
}
