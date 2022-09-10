import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:howru/helpers/Auth.dart';
import 'package:howru/helpers/InterNetChecker.dart';
import 'package:howru/helpers/apihelper.dart';
import 'package:howru/models/contect.dart';
import 'package:howru/models/user.dart';
import 'package:howru/helpers/nav.dart';
import 'package:howru/screens/NoInternet.dart';
import 'package:howru/screens/contectProfile.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

import '../models/ex.dart';
import '../providers/Main_provider.dart';
import '../providers/apiprovider.dart';
import '../widgets/msgs.dart';
import '../widgets/newmsg.dart';

class chat_screen extends StatefulWidget {
  Contect_Model contect_model;
  chat_screen(this.contect_model);

  @override
  _chat_screenState createState() => _chat_screenState();
}

class _chat_screenState extends State<chat_screen> {
  UserMdoel? userMdoel;
  final _controller = new TextEditingController();
  var _enteredMessage = '';

  @override
  void initState() {
    userMdoel = Provider.of<Api_provider>(context, listen: false)
        .getuserbyId(widget.contect_model);

   // Api_Helper.api_helper.getlasymsg(widget.contect_model);
    super.initState();
  }
  PopupMenuItem PopItem(String txt , IconData icon){
    return  PopupMenuItem(
                      value: txt,
                      child: Row(
                        children: <Widget>[
                          Icon(
                            icon,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(width: 8),
                          Text('${widget.contect_model.name!} $txt'),
                        ],
                      ),
                    );
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          leadingWidth: 30.w,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 5.w,
                ),
                height: 40.h,
                width: 40.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100))),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(
                      widget.contect_model.img!,
                      fit: BoxFit.cover,
                    )),
              ),
              SizedBox(
                width: 10.w,
              ),
              Text(widget.contect_model.name!),
            ],
          ),
          actions: [
            Container(
              child: PopupMenuButton(
                onSelected: (value)async{ 
                  
                  if (value == 'Delete chat') {
                  try {
                      Provider.of<Api_provider>(context, listen: false)
                        .deleteChat(widget.contect_model);
                  } on MyEx catch (e) {
        print(e.msg);
        String msg = 'Please try again later';
        showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text("Something Went wrong"),
                content: Text(msg),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Ok"),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                  )
                ],
              );
            });
      }on SocketException catch(e){
      
        showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text("Something Went wrong"),
                content: Text(e.message),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Ok"),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                  )
                ],
              );
            });


      } 
 
 
 
 
 catch (e) {
  showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text("Something Went wrong"),
                content: Text("Please try again later"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Ok"),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                  )
                ],
              );
            });
 }
                        
                  } else if (value == 'profile') {
                    Nav.NavigatorKey.currentState!.push(MaterialPageRoute(
                        builder: ((context) => Contect_profile(userMdoel!))));
                  }
                
                },
                itemBuilder: (context) {
                  return [
                  PopItem("profile", Icons.person),
                   PopItem("Delete chat", Icons.delete)
                  ];
                },
                icon: Icon(
                  Icons.more_vert,
                  color: Theme.of(context).primaryIconTheme.color,
                ),
              ),
            ),
          ],
        ),
      ),
      body:StreamBuilder(
        stream: InternetChecker.ChatInternetchecker.onStatusChange,
    
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return   Container(
        child: Column(
          children: <Widget>[
         Expanded(
              child:snapshot.connectionState==ConnectionState.waiting?Center(child: CircularProgressIndicator(),)  : snapshot.data==InternetConnectionStatus.connected?  Messages(widget.contect_model):internet(),
            ),
            NewMessage(widget.contect_model)
          ],
        ),
      );
        },
      ),
    );
  }
}
