import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'prefs.dart';


const kGoogleApiKey = "AIzaSyDSOh8p7QSDJKNgi5Znz7WqWdroKkYM9aY";
Completer<GoogleMapController> _controller = Completer();
String googleApikey = "AIzaSyDSOh8p7QSDJKNgi5Znz7WqWdroKkYM9aY";
GoogleMapController? mapController; //contrller for Google map
CameraPosition? cameraPosition;
LatLng startLocation = LatLng(37.42796133580664, -122.085749655962); 
String location = "Search Location"; 
double zoomLevel = 15;
String alarmMode = 'onEntry';
List<Marker> _markers = <Marker>[];
TextEditingController nameController = TextEditingController();
String distanceUnit = 'METERS';
double distance = 0;
bool pinned = false;
double latitude = 37.42796133580664;
double longitude = -122.085749655962;

class AddMap extends StatefulWidget {
  const AddMap({Key? key}) : super(key: key);

  @override
  State<AddMap> createState() => _AddMapState();
}

class _AddMapState extends State<AddMap> {
  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(latitude, longitude),
    zoom: zoomLevel,
  );

  Future _addMarkerLongPressed(LatLng latlang) async {
      final MarkerId markerId = MarkerId("RANDOM_ID");
      Marker marker = Marker(
          markerId: markerId,
          draggable: true,
          position: latlang, //With this parameter you automatically obtain latitude and longitude
          infoWindow: InfoWindow(
              title: "Alarm here",
          ),
          icon: BitmapDescriptor.defaultMarker,
      );
      setState(() {
        
        _markers.add(marker);
        pinned = true;
        distance = 500;
        latitude = latlang.latitude;
        longitude = latlang.longitude;
      });
      
    //This is optional, it will zoom when the marker has been created
    // GoogleMapController controller = await _controller.future;
    // controller.animateCamera(CameraUpdate.newLatLngZoom(latlang, 17.0));
    mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: latlang, zoom: zoomLevel)));
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission().then((value){
    }).onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR"+error.toString());
    });
    // Position position = await Geolocator.getCurrentPosition();
    // final GoogleMapController controller = await _controller.future;
    // controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(position.latitude,position.longitude), zoom: zoomLevel)));
    return await Geolocator.getCurrentPosition();
  }     
  
  @override
  void initState() {
    // TODO: implement initState
    getUserCurrentLocation().then((value) async {
      mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(value.latitude,value.longitude), zoom: zoomLevel)));
    });
    pinned = false;
    distance = 0;
    _markers.clear();                   
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: Container(
                margin: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Stack(
                  children: [
                    
                    GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: _kGooglePlex,
                      markers: Set<Marker>.of(_markers),
                      myLocationButtonEnabled: true ,
                      zoomControlsEnabled: true,
                      zoomGesturesEnabled: true,
                      // myLocationEnabled: true,
                      compassEnabled: true,
                      onMapCreated: (GoogleMapController controller) {
                        mapController = controller;
                      },
                      onLongPress: (latlang) {
                        _addMarkerLongPressed(latlang); //we will call this function when pressed on the map
                      },
                      onCameraMoveStarted: () async {
                        zoomLevel =await mapController!.getZoomLevel();
                        setState((){});
                      },
                      circles: Set.from([Circle(
                        circleId: CircleId('circleMarker'),
                        center: LatLng(latitude, longitude),
                        radius: distance,
                        fillColor: Color.fromARGB(120, 255, 64, 129),
                        strokeWidth: 0,
                      )]),
                    ),
                    InkWell(
                      onTap: () async {
                        var place = await PlacesAutocomplete.show(
                                context: context,
                                apiKey: googleApikey,
                                mode: Mode.overlay,
                                types: [],
                                strictbounds: false,
                                onError: (err){
                                  print(err);
                                }
                            );
                        if(place != null){
                              setState(() {
                                location = place.description.toString();
                              });
            
                            //form google_maps_webservice package
                            final plist = GoogleMapsPlaces(apiKey:googleApikey,
                                    apiHeaders: await GoogleApiHeaders().getHeaders(),
                                              //from google_api_headers package
                              );
                              String placeid = place.placeId ?? "0";
                              final detail = await plist.getDetailsByPlaceId(placeid);
                              final geometry = detail.result.geometry!;
                              final lat = geometry.location.lat;
                              final lang = geometry.location.lng;
                              var newlatlang = LatLng(lat, lang);
                              
            
                              //move map camera to selected place with animation
                              mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: newlatlang, zoom: zoomLevel)));
                        }
                      },
                      child:Padding(
                        padding: EdgeInsets.all(15),
                          child: Card(
                            child: Container(
                              padding: EdgeInsets.all(0),
                              width: MediaQuery.of(context).size.width - 80,
                              child: ListTile(
                                  title:Text(location, style: TextStyle(fontSize: 16),),
                                  trailing: Icon(Icons.search),
                                  dense: true,
                              )
                            ),
                          ),
                      )
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: const EdgeInsets.only(top: 80.0),
                        child: Text(
                          'Long press to add location', 
                          style: TextStyle(fontSize: 16),
                        )
                      )
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        alignment: Alignment.topLeft,
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                          color: Colors.white60,
                        ),
                        margin: const EdgeInsets.only(bottom: 150.0, right: 12),
                        child: IconButton(
                          onPressed: () async{
                            getUserCurrentLocation().then((value) async {
                              // print(value.latitude.toString() +" "+value.longitude.toString());
                              mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(value.latitude,value.longitude), zoom: zoomLevel)));
                            });
                          },
                          icon: Icon(Icons.my_location, color: Colors.black54),
                        )
                      )
                    ),
                  ],
                )
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                margin: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10.0, ),
                      child: Text('Alarm Mode', style: Theme.of(context).textTheme.bodyText1)
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ToggleSwitch(
                      minWidth: 125.0,
                      initialLabelIndex: 0,
                      totalSwitches: 2,
                      labels: ['On Entry', 'On Leave'],
                      icons: [Icons.login_outlined,Icons.logout_outlined],
                      activeBgColor: [Colors.teal],
                      inactiveFgColor: Colors.white,
                      inactiveBgColor: Colors.black26,
                      onToggle: (index) {
                        
                        print('switched to: $index');
                        
                      },
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 10.0, ),
                      child: Text('Distance', style: Theme.of(context).textTheme.bodyText1)
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.0, ),
                      child: Text(
                        distance
                      .round().toString() + ' meters')
                    ),
                    Slider(
                      
                      value: distance
                    , 
                      max: 5000,
                      divisions: 100,
                      label: distance
                    .round().toString(),
                      
                      onChanged: (pinned?
                      ((val){
                        setState(() {
                          distance = val;
                        });
                        
                      }) : null)
                    ),
                    ElevatedButton(
                      
                      child: Text('  Save  '),
                      
                      onPressed: pinned ? () {
                        unitNames.add('alarm' + (unitCounter+1).toString());
                        unitLongitudes.add(longitude);
                        unitLatitudes.add(latitude);
                        unitDistances.add(distance);
                        unitModes.add(alarmMode);
                        unitOn.add(true);
                        unitCounter++;
                        
                        Navigator.pop(context);
                        
                      } : null,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


}

