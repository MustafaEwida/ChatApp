import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:howru/helpers/Auth.dart';
import 'package:howru/helpers/localNotify.dart';
import 'package:howru/models/contect.dart';
import 'package:howru/helpers/nav.dart';
import 'package:howru/providers/apiprovider.dart';
import 'package:howru/widgets/ContectsList.dart';
import 'package:howru/widgets/contect_widget.dart';
import 'package:howru/widgets/maindrewer.dart';
import 'package:provider/provider.dart';

Future<void> handler(RemoteMessage RemoteMessage) async {
  print("xxxxxxxxx");
  print(RemoteMessage.notification!.title);
  print(RemoteMessage.notification!.body);
}

class Contects_screen extends StatefulWidget {
  @override
  State<Contects_screen> createState() => _Contects_screenState();
}

class _Contects_screenState extends State<Contects_screen> {
  /* getmsg() async {
    await FirebaseMessaging.instance.getToken();

    FirebaseMessaging.instance.getInitialMessage().then((value) {
      print(value!.notification!.body);
      final string = value.data["route"];
      Nav.NavigatorKey.currentState!.pushReplacementNamed(string);
    });

    FirebaseMessaging.onMessage.listen((event) {
      if (event.notification != null) {
        print("helloxxxxxxxx");
      } else {
        print("rrrrrrrrrrrrrr");
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print(event.data);
      print(event.notification!.title);
      print(event.notification!.body);
    });
  }*/

  @override
  void initState() {
    /*   FirebaseMessaging.instance.getToken();
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data);
      print(event.notification!.title);
 print(event.notification!.body);
  Local_Notify.display(event);

  });*/

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: main_drwer(),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                // final b = await FirebaseMessaging.instance.getToken();

                // Provider.of<Api_provider>(context, listen: false)
                //      .sendnotify("hello", "mustafa", "123");
              },
              icon: Icon(Icons.send)),
        ],
      ),
      body:ContectsList(),
    );
  }
}
