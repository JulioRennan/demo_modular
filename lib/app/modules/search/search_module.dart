import 'package:demo_modular/app/modules/search/search_Page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SearchModule extends Module {
  @override
  final List<Bind> binds = [
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/:param', child: (_, args) => SearchPage()),
  ];
}
