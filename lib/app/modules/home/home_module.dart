import 'dart:async';

import 'package:demo_modular/app/modules/auth/auth_module.dart';
import 'package:demo_modular/app/modules/config/config_module.dart';
import 'package:demo_modular/app/modules/home/unauthorized_page.dart';
import 'package:demo_modular/app/modules/news/news_module.dart';
import 'package:demo_modular/app/modules/search/search_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'home_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => HomePage(),
      children: [
        ModuleRoute(
          "/news",
          module: NewsModule(),
        ),
        
        ModuleRoute(
          "/search",
          module: SearchModule(),
        ),
        ModuleRoute(
          "/config",
          module: ConfigModule(),
        ),
        ModuleRoute("/auth", module: AuthModule(), guards: [
          AuthGuard(),
        ]),
        ChildRoute('/unauthorized', child: (_, args) => UnauthorizedPage())
      ],
    ),
  ];
}

class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: '/unauthorized');

  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) {
    print("teste==> ${Modular.args.queryParams['token']}");
    return Modular.args.queryParams['token'] != null;
  }
}
