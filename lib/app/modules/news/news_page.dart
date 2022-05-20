import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

import '../generic_page.dart';

class NewsPage extends StatefulWidget {
  final String title;
  const NewsPage({Key? key, this.title = 'NewsPage'}) : super(key: key);
  @override
  NewsPageState createState() => NewsPageState();
}

class NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
     return GenericPage(
      iconData: Icons.newspaper,
      nameModule: "News",
    );
  }
}
