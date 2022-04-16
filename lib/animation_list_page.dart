import 'package:flutter/material.dart';
import 'dart:math';

class AnimationListPage extends StatefulWidget {
  const AnimationListPage({Key? key}) : super(key: key);

  @override
  State<AnimationListPage> createState() => _AnimationListPageState();
}

class _AnimationListPageState extends State<AnimationListPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  int get rows => 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Список с анимациями"),
      ),
      body: ListView.separated(
        itemCount: rows,
        padding: const EdgeInsets.symmetric(
          horizontal: 2,
          vertical: 10,
        ),
        itemBuilder: (context, index) {
          return AnimatedListItem(
            animationController: animationController,
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
          height: 10,
        ),
      ),
    );
  }
}

class AnimatedListItem extends StatelessWidget {
  final AnimationController animationController;

  const AnimatedListItem({
    Key? key,
    required this.animationController,
  }) : super(key: key);

  int get numInRow => 5;

  @override
  Widget build(BuildContext context) {
    print("list item");
    return Padding(
      padding: const EdgeInsets.all(5),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: List.generate(
              numInRow,
              (index) => AnimatedUnit(
                size: constraints.maxWidth / numInRow,
                controller: animationController,
              ),
            ),
          );
        },
      ),
    );
  }
}

class AnimatedUnit extends AnimatedWidget {
  final double size;
  final AnimationController controller;
  const AnimatedUnit({
    required this.size,
    required this.controller,
    Key? key,
  }) : super(
          key: key,
          listenable: controller,
        );

  double get _size => Random().nextDouble() * size;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: max(size / 2, Random().nextDouble() * pi),
      child: SizedBox(
        width: size,
        height: size,
        child: Center(
          child: Opacity(
            opacity: max(0.5, Random().nextDouble()),
            child: Container(
              width: _size,
              height: _size,
              decoration: BoxDecoration(
                color: _color,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color get _color {
    final random = Random();
    return Color.fromARGB(
      random.nextInt(255),
      random.nextInt(255),
      random.nextInt(255),
      random.nextInt(255),
    );
  }
}
