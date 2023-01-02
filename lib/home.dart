// ignore_for_file: prefer_const_constructors
import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:geofence_flutter/geofence_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'setting.dart';
import 'add_map.dart';
import 'prefs.dart';

String toastMsg = '';
List<String> xName = ['Wanderer','Explorer','Adventurer', 'Rover','Pilgrim'];
List<String> testLIst = [];
double xLatitude = 0;
double xLongitude = 0;


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(    
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: (Icon(Icons.settings)),
            tooltip: 'Setting',
            onPressed: () async {
              toastMsg = await Navigator.push(context, MaterialPageRoute(builder: (_) => Setting()));
              if (toastMsg == 'saved'){
                Fluttertoast.showToast(
                      msg: 'Settings saved',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.white,
                      textColor: Colors.black54,
                      // fontSize: 16.0
                    );
              }
            },
          ),
        ]
      ),
      floatingActionButton: FloatingActionButton(
        splashColor: Colors.purple,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddMap()),
          ).then((value) {
            setState((){});
          });
          
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
          child: Container(
            margin: const EdgeInsets.only(left: 30.0, right: 30.0),
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Text('Good Morning, ' + xName[Random().nextInt(xName.length)], style: Theme.of(context).textTheme.headline3)
                ),
                alarmList(),
              ],
            ),
          ),
      )
    );
  }

  Widget alarmList(){
  return Expanded(
    flex: 8,
    child: (
      ListView.builder(
        itemCount: unitCounter,
        itemBuilder: (context, index){
          return Card(
            elevation: 0,
            child: Column(
              children: [
                Text(unitNames[index]),
                Text(unitLatitudes[index].toString()),
                Text(unitLongitudes[index].toString()),
                Text(unitDistances[index].toString()),
                Text(unitOn[index].toString()),
              ]
            ),
          );
        },
        )
    ),
  );
}
}

