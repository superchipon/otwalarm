
import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

int unitCounter = 0;
List<String> unitNames = [];
List<double> unitLongitudes = [];
List<double> unitLatitudes = [];
List<double> unitDistances = [];
List<String> unitModes = [];
List<bool> unitOn =[];

Future<String> loadPrefString(String keyword) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return (prefs.getString(keyword) ?? ''); 
}

savePrefString(String keyword, String xvalue) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(keyword, xvalue);    
}

Future<int?> loadPrefInt(String keyword) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return int
  return (prefs.getInt(keyword)??0);
}

savePrefInt(String keyword, int xvalue) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt(keyword, xvalue);    
}

loadPrefStringList(String keyword) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return (prefs.getStringList(keyword) ?? <String>['']); 
}

savePrefStringList(String keyword, List<String> xvalue) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setStringList(keyword, xvalue);    
}