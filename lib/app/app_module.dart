import 'package:demo_modular/app/not_found_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modules/home/home_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(
      Modular.initialRoute,
      module: HomeModule(),
      transition: TransitionType.downToUp,
    ),
    WildcardRoute(child: (_, args) => NotFoundPage())
  ];
}
