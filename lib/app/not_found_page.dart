import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.withOpacity(.5),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "404",
              style: TextStyle(fontSize: 120, color: Colors.white),
            ),
            Text(
              "Not Found",
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
