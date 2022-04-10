import 'dart:math';

import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  late final List<Widget> items;

  @override
  void initState() {
    super.initState();
    items = List.generate(
      100,
      (index) => SimpleListItem(
        title: title,
        color: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Простой список"),
      ),
      body: ListView.separated(
        itemCount: items.length,
        padding: const EdgeInsets.symmetric(
          horizontal: 2,
          vertical: 10,
        ),
        itemBuilder: (context, index) {
          return items[index];
        },
        separatorBuilder: (context, index) => const SizedBox(
          height: 10,
        ),
      ),
    );
  }

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
      "Над высокой классической аркой парадного хода громоздилось двухэтажное строение в кремовых тонах.",
      "Если хотите еще посмотреть – пожалуйста, можно не торопиться, – промолвил водитель. – Есть целых восемь минут.",
      "Хотя, положим, человеку, умеющему как следует писать письма, нет особой надобности этим заниматься",
      "Описав пешком круг по городу, я заходил в контору по сдаче жилья и подбирал себе пансион подешевле.",
      "Заурядная газетная хроника. Молоденький журналист, едва закончив университет, получил задание и опробовал перо.",
    ];
    return titles[Random().nextInt(5)];
  }
}

class SimpleListItem extends StatelessWidget {
  final String title;
  final Color color;
  const SimpleListItem({
    Key? key,
    required this.title,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          const SizedBox(
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
