import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:howru/models/user.dart';
import 'package:howru/helpers/nav.dart';
import 'package:howru/screens/contectProfile.dart';
import 'package:provider/provider.dart';

import '../providers/apiprovider.dart';

class Sec_sesrched_widget extends StatefulWidget {
  UserMdoel  userMdoel;

Sec_sesrched_widget(this.userMdoel);

  @override
  State<Sec_sesrched_widget> createState() => _Sec_sesrched_widgetState();
}

class _Sec_sesrched_widgetState extends State<Sec_sesrched_widget> {
bool?  isexist = false;

@override
  void initState() {
    final conts = Provider.of<Api_provider>(context,listen: false).contects;
    
   conts.forEach((element) {
    if(element.id==widget.userMdoel.id) {isexist=true;};
   },);
   
    super.initState();
  }


/*
bool get isexist{




}*/
  @override
  Widget build(BuildContext context) {
    Provider.of<Api_provider>(context);
   
    return InkWell(
 onTap:(() {
   Nav.NavigatorKey.currentState!.pushReplacement(MaterialPageRoute(builder: ((context) => Contect_profile(widget.userMdoel))));
 }), 
child: Container(
margin: EdgeInsets.all( 5.w),
padding: EdgeInsets.all( 5.w),


child:  Container(
      margin: EdgeInsets.symmetric(vertical: 5.h),
     
      child: ListTile(
        
        leading: Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      height: 40.h,
      width: 40.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(100.r))
      ),
       child: ClipRRect(
        borderRadius: BorderRadius.circular(200.r),
        child: Image.network(widget.userMdoel.imgurl!,fit: BoxFit.cover,)),
   ),
   title:  Text(widget.userMdoel.name!,style: TextStyle(fontSize: 14.sp),),
   trailing: 
    
    ElevatedButton(
     style:ElevatedButton.styleFrom(
  
  shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                        primary: Theme.of(context).primaryColor,
          onPrimary: Colors.white ,
               padding: EdgeInsets.all(10.sp),
               minimumSize: Size(0, 0),
               elevation: 8,),
      child:isexist!?Text('Your Contect')  :Text("Add Contect"),
      onPressed: isexist!?null: (() async{
      try {
          await  Provider.of<Api_provider>(context,listen: false).addcontect(widget.userMdoel);
      } catch (e) {
        
 showDialog(context: context, builder: (ctx){
return AlertDialog(
title: Text("Something Went wrong"),
content: Text("Something Wrong,Try agian later"),
actions:<Widget>[
              FlatButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],

);});
      }
  
    }), )
  
      
  
        
      ),
    )


),

  
);
  }
}