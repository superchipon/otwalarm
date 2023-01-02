import 'package:flutter/material.dart';
import 'prefs.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);
  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  
  String distanceUnit = '';

  @override
  void initState() {
    loadPrefString('distanceUnit').then((value) {
      setState(() {
        distanceUnit = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
      title: Text('Settings'),
      backgroundColor: Colors.transparent,
      elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                alignment: Alignment.centerLeft,
                child: Text('Distance Unit', style: Theme.of(context).textTheme.headline5,)
              ),
              SizedBox(
                height: 50,
                child: RadioListTile(
                  value: 'kilometer',
                  groupValue: distanceUnit,
                  title: Text("Kilometers/Meters"),
                  onChanged: (val) {
                    setState(() {
                      distanceUnit = val.toString();
                    });
                  },
                ),
              ),
              SizedBox(
                height: 50,
                child: RadioListTile(
                  value: 'mile',
                  groupValue: distanceUnit,
                  title: Text("Miles/Yards"),
                  onChanged: (val) {
                    setState(() {
                      distanceUnit = val.toString();
                    });
                    
                  },
                ),
              ),
              ElevatedButton(
                onPressed: (){
                  savePrefString('distanceUnit',distanceUnit);
                  Navigator.pop(context,'saved');
                }, 
                child: Text('Save')
              ),

            ],
          )
        ),
      ),
    );
  }
}