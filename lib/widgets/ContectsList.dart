import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:howru/helpers/InterNetChecker.dart';
import 'package:howru/screens/NoInternet.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

import '../models/ex.dart';
import '../providers/apiprovider.dart';
import 'contect_widget.dart';

class ContectsList extends StatefulWidget {
 

  @override
  _ContectsListState createState() => _ContectsListState();
}

class _ContectsListState extends State<ContectsList> {
   Api_provider? provider;
bool isinit = true;
Timer? timer;
  @override
  /*GetContectsAndusers()async{
    try {
      Provider.of<Api_provider>(context, listen: false).getContects();
       Provider.of<Api_provider>(context, listen: false).Allusers();
    } 
    
    
    
   on MyEx catch (e) {
        print(e.msg);
        String msg = 'somthing wrong';
        if (e.msg.contains('EMAIL_NOT_FOUND')) {
          msg = 'Email not found,check again';
        } else if (e.msg.contains('INVALID_PASSWORD')) {
          msg = 'Wrong password,Enter correct password';
        } else if (e.msg.contains('USER_DISABLED')) {
          msg =
              'The user account has been deleted by him or disabled by an administrator.';
        }
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
        print(e.toString());
/*showDialog(
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
            });*/

      }   catch (e) {
        showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text("Something Went wrong"),
                content: Text(e.toString()+  "Please Try again Later"),
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
  }*/
  void didChangeDependencies() {
   Api_provider provider = Provider.of<Api_provider>(context, listen: false);
      
         provider.getContects();
      
     
    
 provider.Allusers();
  
  
   
  }
  @override
  void dispose() {
    provider!.dispose();
 
    super.dispose();
  }
  @override
  Widget build(BuildContext context) { 
    
    return  StreamBuilder(
      stream: InternetChecker.Internetchecker.onStatusChange,
    key: ValueKey(DateTime.now()),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
     
        print(Provider.of<Api_provider>(context,listen: false).contects);
        if(snapshot.connectionState==ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        }
        return snapshot.data==InternetConnectionStatus.disconnected?internet()    :Provider.of<Api_provider>(context, listen: false).contects == []
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Consumer<Api_provider>(builder: ((context, value, child) {
              return ListView.builder(
                  itemCount: value.contects.length,
                  itemBuilder: (context, i) {
                    return contect_widget(value.contects[i]);
                  });
            }));
      },
    );
  }
}