import 'package:flutter/material.dart';
import 'package:formas_colores/pages/pages.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'home',
      routes: {
        HomePage.routeName: (_) => HomePage(),
        CombinacionesPage.routeName: (_) => CombinacionesPage(),
      },
    );
  }
}
