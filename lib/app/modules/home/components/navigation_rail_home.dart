import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_modular/flutter_modular.dart';

class NavigationRailHome extends StatefulWidget {
  const NavigationRailHome({Key? key}) : super(key: key);

  @override
  State<NavigationRailHome> createState() => _NavigationRailHomeState();
}

class _NavigationRailHomeState extends State<NavigationRailHome> {
  final routes = ["/news/", "/search/", "/config/", "/auth/"];

  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    updateIndex();
    SchedulerBinding.instance?.addPersistentFrameCallback((timeStamp) {
      Modular.to.addListener(() {
        if (mounted) setState(() => updateIndex());
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: _selectedIndex,
      onDestinationSelected: (int index) {
        Modular.to.navigate(routes[index]);
      },
      backgroundColor: Colors.green.withOpacity(.1),
      labelType: NavigationRailLabelType.selected,
      unselectedIconTheme: IconThemeData(color: Colors.grey.shade900),
      minWidth: 20,
      destinations: const <NavigationRailDestination>[
        NavigationRailDestination(
          icon: Icon(Icons.newspaper_outlined),
          selectedIcon: Icon(Icons.newspaper),
          label: Text('News'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.search_outlined),
          selectedIcon: Icon(Icons.search),
          label: Text('Pesquisa'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.settings_outlined),
          selectedIcon: Icon(Icons.settings),
          label: Text('Configuração'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.security),
          selectedIcon: Icon(Icons.settings),
          label: Text('Rota Autorizada'),
        ),
      ],
    );
  }

  updateIndex() {
    final path = Modular.args.uri.path;
    if (path.contains('unauthorized')) _selectedIndex = 3;

    for (int i = 0; i < routes.length; i++) {
      if (path.contains(routes[i])) _selectedIndex = i;
    }
  }
}
