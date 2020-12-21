import 'package:base_widget_example/home_page.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomePage.router,
      routes: {
        HomePage.router: (ctx) => HomePage(),
      },
    );
  }
}
