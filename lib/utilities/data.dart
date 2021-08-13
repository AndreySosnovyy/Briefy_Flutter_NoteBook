import 'dart:math';

class Data {
  static String getRandomNetworkImageURI() {
    var URI = 'https://picsum.photos/seed/${Random().nextInt(999)}/';
    for (var i = 0; i < 2; i++)
      Random().nextBool() == true ? URI = URI + '300/' : URI = URI + '200/';
    return URI;
  }

  static String getRandomTitle() {
    var titles = [
      'СРОЧНО!',
      'Сделать до вторника',
      'Раз два три четыре пять шесть семь восемь девять десять',
      'Задания',
      'Дни рождения',
      'ОГЭ',
      'Программирование'
    ];
    return titles[Random().nextInt(titles.length)];
  }

  static String getRandomText() {
    var texts = [
      '''1) Убраться в комнате
2) Сделать уроки
3) Полить цветы''',
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
