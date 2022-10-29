import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:howru/models/user.dart';
import 'package:howru/helpers/nav.dart';
import 'package:howru/providers/LogInProvider.dart';
import 'package:provider/provider.dart';

import '../helpers/Auth.dart';
import '../models/ex.dart';

class SignForm extends StatelessWidget {


  GlobalKey<FormState> form = GlobalKey();
  TextEditingController passcontrol = TextEditingController();
  // TextEditingController e = TextEditingController();
  // TextEditingController p = TextEditingController();
  // List info = ['', ''];
  UserMdoel userMdoel =
      UserMdoel(password: null, email: null, imgurl: null, name: null);

  void onSvaed(BuildContext context) async {
    if (form.currentState!.validate()) {
      form.currentState!.save();
      /* setState(() {
        isload = true;
      });*/
      Provider.of<LogIn_Provider>(context, listen: false).ChangeIsLog();
      try {
        await Auth_helper.auth_helper.sginup(userMdoel);
      } on MyEx catch (e) {
        String msg = '';
        if (e.msg.contains('EMAIL_EXISTS')) {
          msg = "Email already exists,Try another Email";
        } else if (e.msg.contains('TOO_MANY_ATTEMPTS_TRY_LATER')) {
          msg =
              'We have blocked all requests from this device due to unusual activity. Try again later.';
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

      }
      
      
      
       catch (e) {
        print(e.toString());
        showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text("Something Went wrong"),
                content: Text("Please Try Again Later"),
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

      Provider.of<LogIn_Provider>(context, listen: false).ChangeIsLog();
      /*setState(() {
        isload = false;
      });*/
    }
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    print(keyboardHeight);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 118, 124, 181),
      body: Stack(
        children: <Widget>[
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

          Container(
            margin: EdgeInsets.only(left: 15.w, top: 30.h),
            padding: EdgeInsets.only(left: 20.w, top: 20.h, bottom: 20.h),
            child: Text(
              "Create New Account",
              style: TextStyle(
                fontSize: 30.sp,
                color: Color.fromARGB(255, 64, 50, 108),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
              top: 0.20.sh,
              right: 0.20.sw,
              child: Center(
                child: Container(
                  width: 250.w,
                  height: 220.h,
                  child: Image.asset('assets/sign.png'),
                ),
              )),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(right: 35.w, left: 35.w, top: 0.5.sh),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0.r),
                color: Colors.transparent,
              ),
              child: Form(
                key: form,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          bottom: 10.0.sp, right: 10.sp, left: 10.sp),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color.fromRGBO(49, 39, 79, 1),
                          ),
                        ),
                      ),
                      child: TextFormField(
                        onSaved: (newValue) {
                          userMdoel.name = newValue;
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Username",
                          hintStyle:
                              TextStyle(color: Color.fromRGBO(49, 39, 79, 1)),
                        ),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Enter Name";
                          }
                          return null;
                        },
                      ),
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
                        onSaved: (newValue) {
                          userMdoel.email = newValue;
                        },
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Enter Email";
                          }
                          if (!val.contains('@') || !val.contains('@')) {
                            return "Enter Valid Email";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "email",
                          hintStyle:
                              TextStyle(color: Color.fromRGBO(49, 39, 79, 1)),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0.sp),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color:
                                  Color.fromRGBO(49, 39, 79, 1) // Colors.grey,
                              ),
                        ),
                      ),
                      child: Consumer<LogIn_Provider>(builder: ((context, value, child) {
                     return   TextFormField(
                      obscureText: value.Isvisible,
                        controller: passcontrol,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Enter Password";
                          }
                          if (val.length < 8) {
                            return "Weak Password";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                           suffixIcon: IconButton(onPressed: (){
                                  value.showPassword(); 

                          }, icon: Icon(Icons.remove_red_eye,color: Theme.of(context).accentColor,)),
                            border: InputBorder.none,
                            hintText: "Password",
                            hintStyle: TextStyle(
                                color: Color.fromRGBO(49, 39, 79, 1))),
                      );
                      })),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          bottom:
                              keyboardHeight > 0 ? keyboardHeight - 110.h : 0),
                      padding: EdgeInsets.all(10.0.sp),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color.fromRGBO(49, 39, 79, 1),
                          ),
                        ),
                      ),
                      child: Consumer<LogIn_Provider>(builder: ((context, value, child) {
                        return TextFormField(
                          obscureText: value.Isvisible2,
                        onSaved: (newValue) {
                          userMdoel.password = newValue;
                        },
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Conform password";
                          }
                          if (val != passcontrol.text) {
                            return "password didnt match";
                          }

                          return null;
                        },
                        decoration: InputDecoration(
                           suffixIcon: IconButton(onPressed: (){
                                  value.showConformedPassword(); 

                          }, icon: Icon(Icons.remove_red_eye,color: Theme.of(context).accentColor,)),
                          border: InputBorder.none,
                          hintText: "Conform password",
                          hintStyle:
                              TextStyle(color: Color.fromRGBO(49, 39, 79, 1)),
                        ),
                      );
                      })),
                    ),
                    SizedBox(
                      height: 10.0.h,
                    ),
                    Consumer<LogIn_Provider>(
                      builder: ((context, value, child) {
                        return value.isLog
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: Theme.of(context).accentColor,
                                ),
                              )
                            : Center(
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50.r),
                                      ),
                                      primary: Theme.of(context).accentColor,
                                      onPrimary: Colors.white,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 20.sp, horizontal: 70.sp),
                                      minimumSize: Size(0, 0),
                                      elevation: 8,
                                    ),
                                    onPressed: (){
                                      onSvaed(context);
                                    },
                                    child: Text("Sign Up")),
                              );
                      }),
                    ),
                    SizedBox(
                      height: 10.0.h,
                    ),
                    Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have account",
                          style: TextStyle(
                            color: Colors.pink[200],
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Nav.NavigatorKey.currentState!
                                .pushReplacementNamed("log");
                          },
                          child: Text("LogIn!",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 64, 50, 108))),
                        )
                      ],
                    )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
