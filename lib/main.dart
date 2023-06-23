import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';

import 'HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme)
    {
      return MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
            colorScheme: lightColorScheme),
        darkTheme: ThemeData  (
          useMaterial3: true,
            colorScheme: darkColorScheme),
        themeMode: ThemeMode.system,
        home: const MyHomePage(),
      );
    });
  }
}

