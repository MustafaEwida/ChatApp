import 'dart:ui';


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';

class Rest_screen extends StatefulWidget {
 

  @override
  _Rest_screenState createState() => _Rest_screenState();
}

class _Rest_screenState extends State<Rest_screen> {

  String? email;
@override
  void initState() {
    

    
    // TODO: implement initState
    super.initState();
  }



  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
 appBar: AppBar(
  title: Text("Rest Your Password"),
 ),
 body:  Column(
  mainAxisAlignment: MainAxisAlignment.center,
      children: [
          SizedBox(height: 10.h,),
    SizedBox(
      width: 200.w,
      
      
      child:    ElevatedButton(
style:  ElevatedButton.styleFrom(
  
  shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.r),
                        ),
          onPrimary: Colors.white ,
               padding: EdgeInsets.all(20.sp),
               minimumSize: Size(0, 0),
               elevation: 8,),
          onPressed: (){
          
          }, child: Text("Reset",style: TextStyle(fontSize: 20.sp),)),)
      ],
      
    ),


    );
  }
}