import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:howru/models/user.dart';
import 'package:howru/providers/apiprovider.dart';
import 'package:provider/provider.dart';

import '../nav.dart';

class confirmation extends StatefulWidget {
  UserMdoel userMdoel;
  confirmation(this.userMdoel);

  @override
  _confirmationState createState() => _confirmationState();
}

class _confirmationState extends State<confirmation> {
  bool sure = false;
  bool delete = false;
  @override
  Widget build(BuildContext context) {
    return  Container(
  height: 150.h,
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
 delete?CircularProgressIndicator()   :RaisedButton(onPressed: (() async{
    setState(() {
      delete = true;
    });
 await Provider.of<Api_provider>(context ,listen: false).deleteContect( widget.userMdoel, sure);
 setState(() {
   delete = false;
 });

   Nav.NavigatorKey.currentState!.pop();
}), child: Text("Ok")),SizedBox(width: 10.w,),
RaisedButton(onPressed: (() {
 Nav.NavigatorKey.currentState!.pop();
}), child: Text("Cancel"))


],)
  
  
  
  
  
  
  
  ],
  
  
  
  
  
  ),
);
  }
}