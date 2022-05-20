import 'package:demo_modular/app/modules/config/config_Page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ConfigModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/:param', child: (_, args) => ConfigPage()),
  ];
}
