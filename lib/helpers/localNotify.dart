

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
class Local_Notify {

static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

static  init()async{
  InitializationSettings initializationSettings =  InitializationSettings(android:AndroidInitializationSettings('mipmap/ic_launcher') );
 await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}
static void display(RemoteMessage remoteMessage){
  final id =DateTime.now().millisecondsSinceEpoch~/1000;
  NotificationDetails notificationDetails = 
  NotificationDetails(android:AndroidNotificationDetails
  ('howru','howru channel',importance: Importance.max,priority: Priority.max) );
flutterLocalNotificationsPlugin.show(id, remoteMessage.notification!.title, remoteMessage.notification!.body, notificationDetails);
}
  static void show({String? id, String? title,String? body,String? payload}){
  final id =DateTime.now().millisecondsSinceEpoch~/1000;
  NotificationDetails notificationDetails = NotificationDetails(android:AndroidNotificationDetails('howru','howru channel',importance: Importance.max,priority: Priority.high) );
flutterLocalNotificationsPlugin.show(
  
  id, title, body, notificationDetails,payload: payload);
}
}