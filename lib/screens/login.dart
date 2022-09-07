
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:howru/helpers/Auth.dart';
import 'package:howru/helpers/apihelper.dart';
import 'package:howru/models/ex.dart';
import 'package:howru/models/user.dart';
import 'package:howru/nav.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';

import '../providers/apiprovider.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  bool isload = false;
  GlobalKey<FormState> form = GlobalKey();
  TextEditingController e = TextEditingController();
   TextEditingController p = TextEditingController();
   List<String> info = ['',''];

@override
  void initState() {
 //   Provider.of<Api_provider>(context, listen: false).Allusers();
    super.initState();
  }

 void onSvaed() async{
    if (form.currentState!.validate()) {
      form.currentState!.save();
         setState(() {
           isload = true;
         });
  try {
    await Auth_helper.auth_helper.sginin(info); }
    on MyEx catch(e){
      print(e.msg);
      String msg = 'somthing wrong';
          if(e.msg.contains('EMAIL_NOT_FOUND')){
              msg = 'Email not found,check again';
          }else if(e.msg.contains('INVALID_PASSWORD')){
msg = 'Wrong password,Enter correct password';
          }else if(e.msg.contains('USER_DISABLED')){
msg = 'The user account has been deleted by him or disabled by an administrator.';
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
    
    
    
    
    catch(e){

 showDialog(context: context, builder: (ctx){
return AlertDialog(
title: Text("Something Went wrong"),
content: Text(e.toString()),
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
   setState(() {
     isload = false;
   }); 

    }
  }
 
 Widget build(BuildContext context) {
 final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 118, 124, 181),
      body: 
      Stack(
       
          children: <Widget>[
            Container(  
            margin: EdgeInsets.only(left: 15.w,top: 50.h),
            padding: EdgeInsets.only(left: 35.w,right: 30.w ,top: 20.h,bottom: 20.h),
            child:  Text(
                      "Hello there, \nwelcome back",
                      style: TextStyle(
                        fontSize: 30.sp,
                        color: Color.fromARGB(255, 64, 50, 108),
                        fontWeight: FontWeight.bold,
                      ),
          )

                   , 
                    
                    
                  ),
 Positioned(
  top:0.24.sh,
  right: 0.20.sw,
  
  
  child: Center(child: Container(width: 250,height: 250 ,child:  Image.asset('assets/log.png',fit: BoxFit.cover,),),)),
          /*  Container(
              height: 200,
              child: Stack(
                children: <Widget>[
                  Positioned(
                      child: 
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/images/1.png"),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),*/
         
          SingleChildScrollView(
             child: Container(
               padding: EdgeInsets.only(
                  right: 35.w,
                  left: 35.w,
                  top: 0.51.sh ),
               child: Form(
                 key: form,
                 child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                       
                         SizedBox(
                          height: 10.h,
                        ),
                      
                      
                        
                        
            
                                    Container(
                                      padding: EdgeInsets.all(10.0.sp),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Color.fromRGBO(49, 39, 79, 1),
                                          ),
                                        ),
                                      ),
                                      child: TextFormField(
                                        onSaved: ((newValue) {
                                          info[0] = newValue!;
                                        }),
                                          validator: (val) {
                          if (val!.isEmpty) {
                            return "Enter Email";
                          }
                          if (!val.contains('@') || !val.contains('.com')/*||!val.contains('hotmail')||!val.contains('gmail')*/) {
                            return "Enter Valid Email";
                          }
                          return null;
                        },
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "email",
                                          hintStyle: TextStyle(color: Color.fromRGBO(49, 39, 79, 1)),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin:EdgeInsets.only(bottom:keyboardHeight>0? keyboardHeight-150.h:0 ) ,
                                      padding: EdgeInsets.all(10.sp),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color:Color.fromRGBO(49, 39, 79, 1)// Colors.grey,
                                          ),
                                        ),
                                      ),
                                      child: TextFormField(
                                           onSaved: ((newValue) {
                                          info[1] = newValue!;
                                        }),
                                            validator: (val) {
                                              
                                if (val!.isEmpty) {
                                  return "Enter Password";
                                }
          
                                return null;
                            },
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Password",
                                            hintStyle: TextStyle(color: Color.fromRGBO(49, 39, 79, 1))),
                                      ),
                                    )
                                  
                                
                              
                            
                          
                        
                     ,   SizedBox(
                          height: 40.0.h,
                        ),

                        Center(child: TextButton(onPressed: (() {
                          Nav.NavigatorKey.currentState!.pushNamed("reset");
                        }), child:   Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  color: Colors.pink[200],
                                ),
                              ),
                     ),)
                      /* InkWell(
                        onTap: () {
                          Api_Helper.api_helper.allusers();
                        },
                          child: Center(
                       child:
                              Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  color: Colors.pink[200],
                                ),
                              ),
                     
                          ),
                        )*/,
                        SizedBox(
                          height: 5.0.h,
                        ),
                       
                      Center(child:  
                      
                      
          isload? CircularProgressIndicator()      :ElevatedButton(
                          style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                  primary: Theme.of(context).accentColor,
                  onPrimary: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 20.sp,horizontal: 60.sp),
                  minimumSize: Size(0, 0),
                  elevation: 8,
          ),
                          
                          onPressed: onSvaed, child: Text("LogIn")),)
                        
                       , SizedBox(
                          height: 10.0.h,
                        ),
                      
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Dont have account?"  ,style: TextStyle(
                                color: Colors.pink[200],
                              ),),
                                TextButton(onPressed: (){
                    Nav.NavigatorKey.currentState!.pushReplacementNamed("sign");

                                }, child: Text("Create Now ",style: TextStyle(color: Color.fromARGB(255, 64, 50, 108)),))
                              ],
                            )
                          ),
                      
                      ],
                    ),
               ),
             
           ),
          ) 
          ],
        ),
      
    );
  }


}