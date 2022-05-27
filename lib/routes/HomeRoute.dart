import 'package:flutter/cupertino.dart';
import 'package:lista_compras/screens/home_screen.dart';
import 'package:nuvigator/next.dart';

class HomeRoute extends NuRoute {

  @override
  String get path {
    return 'home';
  }

  @override
  ScreenType get screenType {
    return materialScreenType;
  }

  @override
  Widget build(BuildContext context, NuRouteSettings settings) {
    return HomeScreen();
  }
}