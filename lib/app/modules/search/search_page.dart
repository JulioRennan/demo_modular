import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

import '../generic_page.dart';

class SearchPage extends StatefulWidget {
  final String title;
  const SearchPage({Key? key, this.title = 'SearchPage'}) : super(key: key);
  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return GenericPage(
      iconData: Icons.search,
      nameModule: "Pesquisa",
    );
    
  }
}
