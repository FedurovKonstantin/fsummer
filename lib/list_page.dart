import 'dart:math';

import 'package:flutter/material.dart';

class ListPage extends StatelessWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Простой список"),
      ),
      body: ListView.separated(
        itemCount: 100,
        padding: const EdgeInsets.symmetric(
          horizontal: 2,
          vertical: 10,
        ),
        itemBuilder: (context, index) {
          return const SimpleListItem();
        },
        separatorBuilder: (context, index) => const SizedBox(
          height: 10,
        ),
      ),
    );
  }
}

class SimpleListItem extends StatelessWidget {
  const SimpleListItem({Key? key}) : super(key: key);

  Color get color {
    final random = Random();
    return Color.fromARGB(
      random.nextInt(255),
      random.nextInt(255),
      random.nextInt(255),
      random.nextInt(255),
    );
  }

  String get title {
    final titles = [
      "տպագրության և տպագրական արդյունաբերության համար նախատեսված մոդելային տեքստ է",
      "është një tekst shabllon i industrisë së printimit dhe shtypshkronjave",
      "è un testo segnaposto utilizzato nel settore della tipografia e della stampa",
      "je demonstrativní výplňový text používaný v tiskařském a knihařském průmyslu",
      "это текст-'рыба', часто используемый в печати и вэб-дизайне",
    ];
    return titles[Random().nextInt(5)];
  }

  @override
  Widget build(BuildContext context) {
    final title = this.title;
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
            child: Center(
              child: Text(
                title[0],
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(title),
          ),
        ],
      ),
    );
  }
}
