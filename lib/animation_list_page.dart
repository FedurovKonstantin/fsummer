import 'package:flutter/material.dart';
import 'dart:math';

class AnimationListPage extends StatefulWidget {
  const AnimationListPage({Key? key}) : super(key: key);

  @override
  State<AnimationListPage> createState() => _AnimationListPageState();
}

class _AnimationListPageState extends State<AnimationListPage>
    with TickerProviderStateMixin {
  late final AnimationController animationController;
  late final AnimationController sizeAnimationController;
  late final ScrollController scrollController;

  @override
  void dispose() {
    animationController.dispose();
    sizeAnimationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();

    scrollController = ScrollController();

    sizeAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  int get rows => 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: Duration(seconds: 10),
            curve: Curves.linear,
          );
        },
        child: const Icon(
          Icons.star,
        ),
      ),
      appBar: AppBar(
        title: const Text("Список с анимациями"),
      ),
      body: ListView.separated(
        controller: scrollController,
        itemCount: rows,
        padding: const EdgeInsets.symmetric(
          horizontal: 2,
          vertical: 10,
        ),
        itemBuilder: (context, index) {
          return AnimatedListItem(
            animationController: animationController,
            sizeAnimationController: sizeAnimationController,
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
  final AnimationController sizeAnimationController;

  const AnimatedListItem({
    Key? key,
    required this.animationController,
    required this.sizeAnimationController,
  }) : super(key: key);

  int get numInRow => 5;

  List<HSVColor> get animatedColors {
    final random = Random();
    final aplpha = random.nextDouble();
    final hue = random.nextDouble() * 360;
    final saturation = random.nextDouble();
    final value = random.nextDouble();

    final aplpha1 = random.nextDouble();
    final hue1 = random.nextDouble() * 360;
    final saturation1 = random.nextDouble();
    final value1 = random.nextDouble();
    return [
      HSVColor.fromAHSV(
        aplpha,
        hue,
        saturation,
        value,
      ),
      HSVColor.fromAHSV(
        aplpha1,
        hue1,
        saturation1,
        value1,
      ),
    ];
  }

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
                sizeController: sizeAnimationController,
                colors: animatedColors,
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
  final AnimationController sizeController;
  final List<HSVColor> colors;

  const AnimatedUnit({
    required this.size,
    required this.controller,
    required this.sizeController,
    required this.colors,
    Key? key,
  }) : super(
          key: key,
          listenable: controller,
        );

  double get animatedSize {
    return (sizeController.value + 0.5) * size / 2;
  }

  double get animatedOpdacity {
    return 0.95 + (0.05 * controller.value);
  }

  double get animatedAngle {
    return controller.value * 2 * pi;
  }

  Color get fromColors {
    return HSVColor.lerp(colors[0], colors[1], sizeController.value)!.toColor();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: animatedAngle,
      child: SizedBox(
        width: size,
        height: size,
        child: Center(
          child: Opacity(
            opacity: animatedOpdacity,
            child: Container(
              width: animatedSize,
              height: animatedSize,
              decoration: BoxDecoration(
                color: fromColors,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
