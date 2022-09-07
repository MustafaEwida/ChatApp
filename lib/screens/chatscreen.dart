import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:howru/helpers/Auth.dart';
import 'package:howru/helpers/apihelper.dart';
import 'package:howru/models/contect.dart';
import 'package:howru/models/user.dart';
import 'package:howru/nav.dart';
import 'package:howru/screens/contectProfile.dart';
import 'package:provider/provider.dart';

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
    
    
      userMdoel = Provider.of<Api_provider>(context,listen: false).getuserbyId(widget.contect_model);
  
  Api_Helper.api_helper.getlasymsg(widget. contect_model);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
 
  print("object");
   return Scaffold(
      appBar: PreferredSize(
         preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          leadingWidth: 30.w,
         title: Row(
        mainAxisAlignment: MainAxisAlignment.start,  
          children: [
 Container(
       margin: EdgeInsets.only(top: 5.w,),
        height: 40.h,
        width: 40.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(100))
        ),
         child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.network(widget. contect_model.img!,fit: BoxFit.cover,)),
     ),
     SizedBox(width: 10.w,),
     Text(widget.contect_model.name!),

         ],),
       
          
     
     
          actions: [
            Container(
              child: PopupMenuButton(

                onSelected: (value) {
                  if (value == 'Delete chat') {
                  Provider.of<Api_provider>(context,listen: false).deleteChat(widget. contect_model);
                  }else if(value == 'profile'){
Nav.NavigatorKey.currentState!.push(MaterialPageRoute(builder: ((context) => Contect_profile( userMdoel! ))));
                  }
                },
                itemBuilder: (context) {

               return   [
    PopupMenuItem(
      
        value: 'profile'
      ,child:    Row(
                        children: <Widget>[
                          Icon(Icons.person,color: Theme.of(context).primaryColor,),
                          SizedBox(width: 8),
                          Text('${widget.contect_model.name!} Profile'),
                        ],
                      ), ),
                       PopupMenuItem(
                          value: 'Delete chat',
                        child:     Row(
                        children: <Widget>[
                          Icon(Icons.delete,color: Theme.of(context).primaryColor,),
                          SizedBox(width: 8),
                          Text('Delete chat'),
                        ],
                      ), ),




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
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
             child: Messages(widget.contect_model),
            ),
         NewMessage(widget.contect_model)
          ],
        ),
      ),
    );
  }
}