import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../helpers/Auth.dart';
import '../models/ex.dart';
import '../helpers/nav.dart';

class ResetEmail extends StatefulWidget {
 

  @override
  _ResetEmailState createState() => _ResetEmailState();
}

class _ResetEmailState extends State<ResetEmail>  with SingleTickerProviderStateMixin{
  
  AnimationController? anmicotr;
  Animation<double>? anmi;
  String password = Auth_helper.auth_helper.user!.password!;

  bool isuser = false;
  bool hide = true;
  @override
  void initState() {
    anmicotr = AnimationController(vsync: this, duration: Duration(seconds: 2));
    anmi = Tween<double>(begin: 0.0, end: 1.0).animate(anmicotr!);

    print(password);

    // TODO: implement initState
    super.initState();
  }

  TextEditingController tec = TextEditingController();
  TextEditingController emailtext = TextEditingController();
  onsubmit(String txt) async {
    if (txt.isEmpty) {
      return showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text("Reset Faild"),
              content: Text("Enter your Password"),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                )
              ],
            );
          });
    }
    if (txt != password) {
      return showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text("Reset Faild"),
              content: Text("Worng Password"),
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
    } else {
      //await Auth_helper.auth_helper.changeEmail(txt.trim());
      setState(() {
        isuser = true;
      });

      /*showDialog(context: context, builder: (ctx){
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
});*/
    }
  }

  change(String text) async {
    if (text.isEmpty) {
      return showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text("Reset Faild"),
              content: Text("Enter Email"),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                )
              ],
            );
          });
    } else if (!text.contains('@') ||
        !text.contains(
            '.com') /*||!val.contains('hotmail')||!val.contains('gmail')*/) {
      return showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text("Reset Faild"),
              content: Text("Enter Valid Email"),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                )
              ],
            );
          });
    } else {
      try {
        await Auth_helper.auth_helper.changeEmail(text.trim());
      } on MyEx catch (e) {
        String masg = '';
        if (e.msg.contains("EMAIL_EXISTS")) {
          masg = "The email address is already in use, Try Another email";
        } else if (e.msg.contains("INVALID_ID_TOKEN")) {
          masg =
              "Your credential is no longer valid. You must Log in again and Rsest email again";
        } else if (e.msg.contains("CREDENTIAL_TOO_OLD")) {
          masg =
              "Your credential is Too old. You must Log in again and Rsest email again";
        }
        return showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text("Reset Faild"),
                content: Text(masg),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                  )
                ],
              );
            });
      } catch (e) {
        return showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text("Reset Faild"),
                content:
                    Text("Something went wrong,check InterNet and Try later"),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                  )
                ],
              );
            });
      }
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text("Reset done"),
              content: Text(
                  'Rsest done successfully,please press ok to back to log screen to log with the new email'),
              actions: <Widget>[
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
  void dispose() {
    anmicotr!.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
      anmicotr!.forward();
    return  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Column(
              children: [
                Text(
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
                    'Enter Password'),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Container(
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.r),
                    boxShadow: [
                      BoxShadow(
                           spreadRadius: 0.1.r,
        blurRadius: 10.r,
                        color: Color.fromARGB(255, 92, 92, 92),
                        offset: Offset(0, 10)
                      )
                    ]
                   ),
                    child: TextField(
                      obscureText: hide,
                      keyboardType: TextInputType.emailAddress,
                      controller: tec,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  hide = !hide;
                                });
                              },
                              icon: Icon(
                                Icons.remove_red_eye,
                                color: Theme.of(context).primaryColor,
                              )),
                          fillColor: Color.fromARGB(255, 235, 232, 232),
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.r),
                              borderSide: BorderSide(
                                  width: 1.w,
                                  color: Theme.of(context).accentColor)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.r),
                              borderSide: BorderSide(
                                  width: 1.w,
                                  color: Theme.of(context).accentColor))),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  width: 200.w,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                        primary: Theme.of(context).primaryColor,
                        onPrimary: Colors.white,
                        padding: EdgeInsets.all(20.sp),
                        minimumSize: Size(0, 0),
                        elevation: 15,
                      ),
                      onPressed: () {
                        onsubmit(tec.text);
                      },
                      child: Text(
                        "Check",
                        style: TextStyle(fontSize: 20.sp),
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          if (!isuser)
            SizedBox(
              height: 152.h,
            ),
          if (isuser)
            FadeTransition(
              opacity: anmi!,
              child: Container(
                height: 152.h,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Container(
                          decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.r),
                    boxShadow: [
                      BoxShadow(
                           spreadRadius: 0.1.r,
        blurRadius: 10.r,
                        color: Color.fromARGB(255, 92, 92, 92),
                        offset: Offset(0, 10)
                      )
                    ]
                   ),
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailtext,
                          decoration: InputDecoration(
                              hintText: 'Enter New Email',
                              fillColor: Color.fromARGB(255, 235, 232, 232),
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.r),
                                  borderSide: BorderSide(
                                      width: 1.w,
                                      color: Theme.of(context).accentColor)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.r),
                                  borderSide: BorderSide(
                                      width: 1.w,
                                      color: Theme.of(context).accentColor))),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    SizedBox(
                      width: 200.w,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.r),
                            ),
                            primary: Theme.of(context).primaryColor,
                            onPrimary: Colors.white,
                            padding: EdgeInsets.all(20.sp),
                            minimumSize: Size(0, 0),
                            elevation: 15,
                          ),
                          onPressed: () {
                            change(emailtext.text);
                          },
                          child: Text(
                            "Reset",
                            style: TextStyle(fontSize: 20.sp),
                          )),
                    ),
                  ],
                ),
              ),
            )
        ],
      );
  }
}