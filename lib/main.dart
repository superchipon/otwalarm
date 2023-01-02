// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ON THE WAY ALARM',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'ON-THE-WAY ALARM'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  

  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OTW Alarm',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        // scaffoldBackgroundColor: Colors.yellowAccent[400],

        appBarTheme: AppBarTheme(
          foregroundColor: Colors.black54,
        ),

        // textTheme: TextTheme(
        //   titleLarge: TextStyle(color: Colors.white),
        // ),


        bottomNavigationBarTheme: BottomNavigationBarThemeData( 
          backgroundColor: Colors.yellowAccent,
          selectedItemColor: Colors.blue,
        ),
      ),
      
      home: const HomePage(),
    );
  }
}
