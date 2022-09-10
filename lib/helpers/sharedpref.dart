import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreHelper {
SharedPreHelper._();
static SharedPreHelper sharedPreHelper = SharedPreHelper._();
SharedPreferences? sharedPreferences ;


storeUserData(Map<String,dynamic>userdata)async{
sharedPreferences = await SharedPreferences.getInstance();
final data = json.encode(userdata);
  sharedPreferences!.setString("data", data);

}

Future<Map<String, dynamic>>  getStoredData()async{
  sharedPreferences = await SharedPreferences.getInstance();
   
    if (! sharedPreferences!.containsKey("data")) {
      return {};
    }
    final data = json.decode( sharedPreferences!.getString("data")!) as Map<String, dynamic>;
    print(data.values);
    final exdate = DateTime.parse(data['exDate']);
    if (exdate.isBefore(DateTime.now())) {
      return {};
    }
 print(data['name']);
    print(data["pass"]);
    return data;

}



  
}