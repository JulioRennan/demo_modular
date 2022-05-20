import 'package:flutter/material.dart';

import '../generic_page.dart';

class AuthPage extends StatefulWidget {
  final String title;
  const AuthPage({Key? key, this.title = 'AuthPage'}) : super(key: key);
  @override
  AuthPageState createState() => AuthPageState();
}
class AuthPageState extends State<AuthPage> {

  @override
  Widget build(BuildContext context) {
     return GenericPage(
      iconData: Icons.security,
      nameModule: "Rota Autorizada",
    );
  }
}