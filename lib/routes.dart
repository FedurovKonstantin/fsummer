import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fsummer/animation_list_page.dart';
import 'package:fsummer/choise_page.dart';
import 'package:fsummer/list_page.dart';

Route<dynamic> onGenegrateRouttes(RouteSettings settings) {
  Widget page = Container();

  switch (settings.name) {
    case AppRoutes.initial:
      page = ChoisePage();
      break;
    case AppRoutes.list:
      page = ListPage();
      break;
    case AppRoutes.animationList:
      page = AnimationListPage();
      break;
    default:
  }

  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return page;
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1, 0);
      const end = Offset(0, 0);
      const curve = Curves.ease;

      final tween = Tween(begin: begin, end: end);
      final curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: curve,
      );

      return SlideTransition(
        position: tween.animate(curvedAnimation),
        child: child,
      );
    },
  );
}

class AppRoutes {
  static const initial = '/';
  static const list = '/list';
  static const animationList = '/animation_list';
}
