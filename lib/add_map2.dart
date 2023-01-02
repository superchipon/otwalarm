import 'package:flutter/material.dart';

class AddMap2 extends StatefulWidget {
  const AddMap2({Key? key}) : super(key: key);

  @override
  State<AddMap2> createState() => _AddMap2State();
}

class _AddMap2State extends State<AddMap2> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
          child: Column(
            children: [
              Text('Add Map'),
              
            ],
          )
        ),
      ),
    );
  }
}