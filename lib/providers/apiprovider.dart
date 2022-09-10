import 'dart:convert';
import 'dart:io';


import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:howru/helpers/Auth.dart';
import 'package:howru/helpers/apihelper.dart';
import 'package:howru/models/contect.dart';
import 'package:howru/models/user.dart';
import 'package:http/http.dart';

import '../models/ex.dart';
import '../models/msgmodel.dart';

class Api_provider extends ChangeNotifier {
List<UserMdoel> users = [];
List<UserMdoel> resentusers = [];
List<Contect_Model> contects = [];
List<String> usersnames = [];
 List<Msg_model> msgs = [];
 Msg_model? lastmsgInList ;
Allusers()async{
users = [];
try {
   List <List<UserMdoel>> api_users =  await Api_Helper.api_helper.allusers();
   users =api_users[0];
users.forEach((element) {
  usersnames.add(element.name!);

});
users.removeWhere((element) => element.id==Auth_helper.auth_helper.user!.id);
 resentusers =api_users[1];
resentusers.removeWhere((element) => element.id==Auth_helper.auth_helper.user!.id);
 notifyListeners();
} on DioError catch (e) {
     
      if(e.response != null)  {
        throw MyEx(e.response!.data['error']['message']);}
        else if(e.message.contains("SocketException")){ 
          users = [];
      // throw SocketException("No connection,please try again");
      }
      
      
    } catch (e) {
      throw e;
}
    
 print(users);
}/*
resentUsers()async{
 List<UserMdoel> api_users =  await Api_Helper.api_helper.Recentusers();
 resentusers =api_users;
 notifyListeners();
}*/
addimg(b)async{
await Api_Helper.api_helper.addimg(b);

}
addcontect(UserMdoel userMdoel)async{
  try {
  await Api_Helper.api_helper.addcontect(userMdoel);  
  } catch (e) {
    throw e;
  }
contects.add(Contect_Model(userMdoel.id, userMdoel.name,userMdoel.imgurl));
notifyListeners();

}
  getContects()async{
  
try {
  List<Contect_Model> cts =  await Api_Helper.api_helper.GetContects();
contects = cts;

notifyListeners();
}on DioError catch (e) {
     
      if(e.response != null)  {
        throw MyEx(e.response!.data['error']['message']);}
        else{ 
        print(e.requestOptions);
        print(e.message);
        contects =[];
        // throw SocketException("No connection,please try again");
      }
      
      
    } catch (e) {
      throw e;
}

}
addmsg(String msg , Contect_Model contect_model)async{
 try {
   await Api_Helper.api_helper.addmsg(msg,contect_model);
   lastmsgInList = null;
 notifyListeners();
 } on DioError catch (e) {
     
      if(e.response != null)  {throw MyEx(e.response!.data['error']['message']);}else{ 
        print(e.requestOptions);
        print(e.message);
         throw SocketException("No Connection,Please try agaian later");
      }
      
      
    }
 
 
 catch (e) {
 }

}
Future< List<Msg_model>>  getmsgs(Contect_Model contect_mode)async{
     List<Msg_model> msgs = [];
 msgs = await Api_Helper.api_helper.getmsgs(contect_mode);
 
  return msgs;
 
  }
   sendnotify(String title,String body,String id)async{
   
   /* final username = Auth_helper.auth_helper.user!.name;
    final msgtitle = 'Freind Request';
    final msg = "${username}send you freind request\n click to see details";
    final uri = Uri.parse('https://fcm.googleapis.com/fcm/send');
  await post(
   uri,
     headers: <String, String>{
       'Content-Type': 'application/json',
       'Authorization': 'key=AAAAz0jv-uM:APA91bH9E6hSdmzKf34eBDkdnwncQsCKNpL0LRwOY8ZKk0GNrKQXo2x4siJFDLl_dysPZxH0BworiHiZKhBbwmWgO5fdw5t283oecAWfFNVM8WnubuEX-mBO24WNvISm7O3eRWgYgkey',
     },
     body:json.encode(
     <String, dynamic>{
       'notification': <String, dynamic> {
         'body': msgtitle,
         'title': msg
       },
       'priority': 'high',
       'data': <String, dynamic>{
         'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      
         'id': id,
         'status': 'done'
       },
        'to': await FirebaseMessaging.instance.getToken()
     },
    ),
  );*/
    final uri = Uri.parse('https://fcm.googleapis.com/fcm/send');
  await post(
   uri,
     headers: <String, String>{
       'Content-Type': 'application/json',
       'Authorization': 'key=AAAAz0jv-uM:APA91bH9E6hSdmzKf34eBDkdnwncQsCKNpL0LRwOY8ZKk0GNrKQXo2x4siJFDLl_dysPZxH0BworiHiZKhBbwmWgO5fdw5t283oecAWfFNVM8WnubuEX-mBO24WNvISm7O3eRWgYgkey',
     },
     body:json.encode(
     <String, dynamic>{
       'notification': <String, dynamic> {
         'body': body,
         'title': title
       },
       'priority': 'high',
       'data': <String, dynamic>{
         'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        
         'id': id,
         'status': 'done'
       },
        'to': await FirebaseMessaging.instance.getToken()
     },
    ),
  );
print("xxxx");
  }
Future<List<dynamic>>  lastmsg(Contect_Model contect_model)async{
List b =  await Api_Helper.api_helper.getlasymsg(contect_model);
return b;

  }
  deleteContect( UserMdoel userMdoel , bool sure)async{
try {
  await Api_Helper.api_helper.deletcontect(userMdoel, sure);
await getContects();

}on DioError catch(e){
      if (e.response != null) {
        print(e.response!.data);
        throw MyEx(e.response!.data['error']['message']);
      } else if(e.message.contains('SocketException')){
        throw SocketException("No Connection,Please try agaian later");
       
      }else{
        throw e;
      }}
       catch (e) {
        throw e;
}
;
notifyListeners();


  }
  deleteChat(Contect_Model contect_model)async{
  try {
      await Api_Helper.api_helper.deleteChat(contect_model);
  }on DioError catch(e){
      if (e.response != null) {
        
        throw MyEx(e.response!.data['error']['message']);
      } else if(e.message.contains('SocketException')){
        return;
        throw SocketException("No Connection,Please try agaian later");
       
      }else{
        throw e;
      }} catch (e) {
        throw e;
  }
    notifyListeners();

  }
UserMdoel  getuserbyId(Contect_Model contect_model){
    UserMdoel userMdoel = users.firstWhere((element) => element.id==contect_model.id);
    return userMdoel;
  }

List<dynamic> iscontect(UserMdoel userMdoel , Contect_Model? contect){
  bool isexist = false;
 List elemint = contects.where((element) {
     return element.id == userMdoel.id;
    },).toList();
    if(elemint.isNotEmpty){
      isexist = true;
            contect = elemint[0];
    }else{
        isexist = false;
    }
    return [isexist,contect];

 }
 updateimg(File b)async{
 await Api_Helper.api_helper.updateimg(b);
 notifyListeners();


 }
updatename(String x)async{
 await Api_Helper.api_helper.updateUsersName(x);
 Auth_helper.auth_helper.user!.name = x;
 notifyListeners();


}
GetLastMsg(String msg,DateTime dateTime){
  lastmsgInList = Msg_model(Auth_helper.auth_helper.user!.id, msg, dateTime);




}
getstoredusers()async{
users=  await Api_Helper.api_helper.getstoredusers();
notifyListeners();
}
}