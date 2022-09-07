import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:howru/helpers/Auth.dart';

import '../nav.dart';

class Reset_screen extends StatefulWidget {
 

  @override
  _Reset_screenState createState() => _Reset_screenState();
}

class _Reset_screenState extends State<Reset_screen> {
    String? email;
@override
  void initState() {
    
     email =    Auth_helper.auth_helper.user!.email!;
     print(email);
    // TODO: implement initState
    super.initState();
  }


  TextEditingController tec = TextEditingController();
  onsubmit(String txt)async{
if(txt.isEmpty){
 return  showDialog(context: context, builder: (ctx){
return AlertDialog(
title: Text("Reset Faild"),
content: Text("Reset Faild"),
actions:<Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                     Navigator.of(ctx).pop();
                },
              )
            ],

);
});
}if( txt!= email ){
return showDialog(context: context, builder: (ctx){
return AlertDialog(
title: Text( "Reset Faild"),
content: Text("Reset Faild"),
actions:<Widget>[
              FlatButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],

);
});

}else {
 await Auth_helper.auth_helper.Reset(txt.trim());

  showDialog(context: context, builder: (ctx){
return AlertDialog(
title: Text("Verify Email"),
content: Text('Go to your Email And Reset Password'),
actions:<Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
               Auth_helper.auth_helper.logout();
                  Nav.NavigatorKey.currentState!.pushReplacementNamed('log');
                },
              )
            ],

);
});
}


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
 appBar: AppBar(
  
  title: Text("Rest Your Password"),
 ),
 body:  Column(
  mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w500),
          
          
          'Enter Your Email'),
          SizedBox(height: 10.h,),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20.w),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
   controller: tec,
   decoration: InputDecoration(
    fillColor: Color.fromARGB(255, 235, 232, 232),
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50.r),
      borderSide: BorderSide(width: 1.w,color: Theme.of(context).accentColor)
    ),
    focusedBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.r),
      borderSide: BorderSide(width: 1.w,color: Theme.of(context).accentColor)
    )
   ),


          ),
        )
       , 
       SizedBox(height: 15.h,),
    SizedBox(
      width: 200.w,
      
      
      child:    ElevatedButton(
style:  ElevatedButton.styleFrom(
  
  shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                        primary: Theme.of(context).accentColor,
          onPrimary: Colors.white ,
               padding: EdgeInsets.all(20.sp),
               minimumSize: Size(0, 0),
               elevation: 8,),
          onPressed: (){
            onsubmit(tec.text);
          }, child: Text("Reset",style: TextStyle(fontSize: 20.sp),)),)
      ],
      
    ),


    );
  }
}