import 'package:flutter/material.dart';
import 'view/home.dart';
import 'view/crud.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FLutter API',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/crud': (context) => CRUD(datamhs: null),
      },
    );
  }
}
