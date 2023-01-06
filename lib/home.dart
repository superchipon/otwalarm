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
  StreamSubscription<GeofenceEvent>? geofenceEventStream;
  String geofenceEvent = '';

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
                Expanded(
                  flex: 1,
                  child: Text(geofenceEvent)
                ),
                Expanded(
                  flex: 1,
                  child: ElevatedButton(child: Text('stop unit'), onPressed: stopUnit,)
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
            child: Row(
              children: [
                Column(
                  children: [
                    Text(unitNames[index]),
                    Text(unitDistances[index].toString()),
                    Text(unitOn[index].toString()),
                    ElevatedButton(onPressed: (){activateUnit (index, unitDistances[index]);}, child: Text('Activate'))
                  ]
                ),
                
              ],
            ),
          );
        },
        )
    ),
  );
  } // Alarmlist

  activateUnit(int index, double radius) async {
    await Geofence.startGeofenceService(
      pointedLatitude: unitLatitudes[index].toString(),
      pointedLongitude: unitLongitudes[index].toString(),
      radiusMeter: radius.toString(),
      eventPeriodInSeconds: 10);
    print(unitLatitudes[index]);
    geofenceEventStream ??= Geofence.getGeofenceStream()?.listen((GeofenceEvent event) {     
        print(event.toString()); 
        setState(() {
          geofenceEvent = event.toString();
          
        });
      });
    // else{
    //   Geofence.getGeofenceStream()?.listen((GeofenceEvent event) {        
    //     setState(() {
    //       geofenceEvent = 'test';
    //     });
    //   });
    // }
  } //activateUnit

  stopUnit(){
    print("stop");
    Geofence.stopGeofenceService();
    geofenceEventStream?.cancel();

  } //stopUnit

  

}

