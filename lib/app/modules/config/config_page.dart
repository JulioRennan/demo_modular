import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

import '../generic_page.dart';

class ConfigPage extends StatefulWidget {
  final String title;
  const ConfigPage({Key? key, this.title = 'ConfigPage'}) : super(key: key);
  @override
  ConfigPageState createState() => ConfigPageState();
}

class ConfigPageState extends State<ConfigPage> {
  @override
  Widget build(BuildContext context) {
    return GenericPage(
      iconData: Icons.settings,
      nameModule: "Configuração",
    );
  }
}
