import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'components/navigation_rail_home.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRailHome(),
          Expanded(child: RouterOutlet()),
        ],
      ),
    );
  }
}
