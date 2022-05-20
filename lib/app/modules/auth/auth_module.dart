import 'dart:async';
import 'package:demo_modular/app/modules/auth/auth_Page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../home/unauthorized_page.dart';

class AuthModule extends Module {
  @override
  final List<Bind> binds = [  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/:param', child: (_, args) => AuthPage()),
  ];
}


