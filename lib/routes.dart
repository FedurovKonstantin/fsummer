import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    default:
  }

  return MaterialPageRoute(
    builder: (context) => page,
  );
}

class AppRoutes {
  static const initial = '/';
  static const list = '/list';
}
