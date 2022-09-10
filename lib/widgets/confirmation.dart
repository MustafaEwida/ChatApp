
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:howru/models/ex.dart';
import 'package:howru/models/user.dart';
import 'package:howru/providers/Main_provider.dart';
import 'package:howru/providers/apiprovider.dart';
import 'package:provider/provider.dart';

import '../helpers/nav.dart';

class confirmation extends StatefulWidget {
  UserMdoel userMdoel;
  bool connect;
  confirmation(this.userMdoel,this.connect);

  @override
  _confirmationState createState() => _confirmationState();
}

class _confirmationState extends State<confirmation> {
  bool sure = false;
  bool delete = false;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Main_Provider>(context);
    print("object;");
    return  Container(
  height: 155.h,
  child:   Column(
  
  children: [
  
  Text("Do you want to delete contect"),
  CheckboxListTile(
    title: Text("delete chat"),
    value: sure, onChanged: (b){
    setState(() {
     sure = b!;
    });
    print(sure);
  }),
Row(
 mainAxisAlignment: MainAxisAlignment.end, 
  children: [
    TextButton(onPressed: (() {
 Nav.NavigatorKey.currentState!.pop();
}), child: Text("Cancel")),
SizedBox(width: 10.w,)

,
 delete?CircularProgressIndicator()   :ElevatedButton(onPressed:!widget.connect?null:  (() async{
    setState(() {
      delete = true;
    });
    try {
      await Provider.of<Api_provider>(context ,listen: false).deleteContect( widget.userMdoel, sure);
    }on MyEx catch(e) {
    String msg = 'Try Again Later';
        if (e.msg.contains('USER_DISABLED')) {
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
    }  
    catch (e) {
      showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text("Something Went wrong"),
                content: Text("Please Try again Later"),
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
 
 setState(() {
   delete = false;
 });

   Nav.NavigatorKey.currentState!.pop();
}), child: widget.connect==false?Text("No Intenet") :Text("Ok")),SizedBox(width: 10.w,),



],)
  
  
  
  
  
  
  
  ],
  
  
  
  
  
  ),
);
  }
}