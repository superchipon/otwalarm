
import 'package:flutter/material.dart';
import '../lib/home.dart';


class MasterPage extends StatefulWidget {
  const MasterPage({Key? key}) : super(key: key);
  @override
  State<MasterPage> createState() => _MasterPageState();
}

class _MasterPageState extends State<MasterPage> {
  int _currentIndex = 0;

  List screens = [
    HomePage(),
    // LogPage(),
    // TestPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 34,
        currentIndex: _currentIndex,
        onTap: (index) {
          _currentIndex = index;
          setState(() {});
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Measure',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wysiwyg),
            label: 'Log',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.tips_and_updates),
          //   label: 'Test',
          // ),
        ],
      ),
    );
  }
}
