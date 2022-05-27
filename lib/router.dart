import 'package:lista_compras/routes/HomeRoute.dart';
import 'package:nuvigator/next.dart';

class MyRouter extends NuRouter {
  @override
  // TODO: implement initialRoute
  String get initialRoute => 'home';

  @override
  // TODO: implement registerRoutes
  List<NuRoute<NuRouter, Object, Object>> get registerRoutes => [HomeRoute()];
}
