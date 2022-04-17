import 'package:flutter/material.dart';
import 'package:fsummer/routes.dart';

class ChoisePage extends StatelessWidget {
  const ChoisePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            PageButton(
              page: AppRoutes.list,
              title: "Простой список",
            ),
            PageButton(
              page: AppRoutes.animationList,
              title: "Список с анимациями",
            ),
            PageButton(
              page: AppRoutes.paint,
              title: "Рисование",
            ),
          ],
        ),
      ),
    );
  }
}

class PageButton extends StatelessWidget {
  final String page;
  final String title;

  const PageButton({
    Key? key,
    required this.page,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: TextButton(
        onPressed: () => Navigator.of(context).pushNamed(page),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
