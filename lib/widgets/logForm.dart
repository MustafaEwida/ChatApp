import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:howru/providers/LogInProvider.dart';
import 'package:provider/provider.dart';

import '../helpers/Auth.dart';
import '../models/ex.dart';
import '../helpers/nav.dart';
import '../screens/Rest.dart';

class LogForm extends StatelessWidget {
  
  GlobalKey<FormState> form = GlobalKey();
  TextEditingController e = TextEditingController();
  TextEditingController p = TextEditingController();
  List<String> info = ['', ''];



  void onSvaed(BuildContext context) async {
    if (form.currentState!.validate()) {
      form.currentState!.save();
      Provider.of<LogIn_Provider>(context, listen: false).ChangeIsLog();
      try {
        await Auth_helper.auth_helper.sginin(info);
      } on MyEx catch (e) {
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
      /*setState(() {
     isload = false;
   }); 
*/
      Provider.of<LogIn_Provider>(context, listen: false).ChangeIsLog();
    }
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 15.w, top: 50.h),
          padding:
              EdgeInsets.only(left: 35.w, right: 30.w, top: 20.h, bottom: 20.h),
          child: Text(
            "Hello there, \nwelcome back",
            style: TextStyle(
              fontSize: 30.sp,
              color: Color.fromARGB(255, 64, 50, 108),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Positioned(
            top: 0.24.sh,
            right: 0.20.sw,
            child: Center(
              child: Container(
                width: 250,
                height: 250,
                child: Image.asset(
                  'assets/log.png',
                  fit: BoxFit.cover,
                ),
              ),
            )),
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
            padding: EdgeInsets.only(right: 35.w, left: 35.w, top: 0.51.sh),
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
                    decoration: const BoxDecoration(
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
                        if (!val.contains('@') ||
                            !val.contains(
                                '.com') /*||!val.contains('hotmail')||!val.contains('gmail')*/) {
                          return "Enter Valid Email";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "email",
                        hintStyle:
                            TextStyle(color: Color.fromRGBO(49, 39, 79, 1)),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        bottom:
                            keyboardHeight > 0 ? keyboardHeight - (keyboardHeight*.80) : 0),
                    padding: EdgeInsets.all(10.sp),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            color: Color.fromRGBO(49, 39, 79, 1) // Colors.grey,
                            ),
                      ),
                    ),
                    child: Consumer<LogIn_Provider>(builder: ((context, provider, child) {
                      return TextFormField(
                      onSaved: ((newValue) {
                        info[1] = newValue!;
                      }),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter Password";
                        }

                        return null;
                      },
                      obscureText: provider.Isvisible ,
                      decoration:  InputDecoration(
                         suffixIcon: IconButton(onPressed: (){
                                  provider.showPassword(); 

                          }, icon: Icon(Icons.remove_red_eye,color: Theme.of(context).accentColor,)),
                          border: InputBorder.none,
                          hintText: "Password",
                          hintStyle:
                            const  TextStyle(color: Color.fromRGBO(49, 39, 79, 1))),
                    );
                    })),
                  ),
                  SizedBox(
                    height: 40.0.h,
                  ),
                  Center(
                    child: TextButton(
                      onPressed: (() {
                        Nav.NavigatorKey.currentState!.push(MaterialPageRoute(
                            builder: ((context) => Reset_screen(
                                  Log: true,
                                ))));
                      }),
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: Colors.pink[200],
                        ),
                      ),
                    ),
                  )
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
                        )*/
                  ,
                  SizedBox(
                    height: 5.0.h,
                  ),
                  Consumer<LogIn_Provider>(builder: ((context, value, child) {
                    return Center(
                      child: value.isLog
                          ? CircularProgressIndicator(
                              color: Theme.of(context).accentColor,
                            )
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.r),
                                ),
                                primary: Theme.of(context).accentColor,
                                onPrimary: Colors.white,
                                padding: EdgeInsets.symmetric(
                                    vertical: 20.sp, horizontal: 60.sp),
                                minimumSize: const Size(0, 0),
                                elevation: 8,
                              ),
                              onPressed:(){
                                onSvaed(context);
                              },
                              child: const Text("LogIn")),
                    );
                  })),
                  SizedBox(
                    height: 10.0.h,
                  ),
                  Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Dont have account?",
                        style: TextStyle(
                          color: Colors.pink[200],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Nav.NavigatorKey.currentState!
                                .pushReplacementNamed("sign");
                          },
                          child: const Text(
                            "Create Now ",
                            style: TextStyle(
                                color: Color.fromARGB(255, 64, 50, 108)),
                          ))
                    ],
                  )),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
