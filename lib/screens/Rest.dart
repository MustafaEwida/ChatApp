import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:howru/helpers/Auth.dart';
import 'package:howru/providers/Main_provider.dart';
import 'package:howru/screens/NoInternet.dart';
import 'package:howru/widgets/Reset.dart';
import 'package:howru/widgets/ResetPassword.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

import '../helpers/InterNetChecker.dart';
import '../helpers/nav.dart';

class Reset_screen extends StatelessWidget {
 bool? Log;
 Reset_screen({this.Log =false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
 appBar: AppBar(
  
  title: Text("Rest Your Password"),
 ),
 body: StreamBuilder(
   stream: InternetChecker.PasswordResetInternetchecker.onStatusChange,
   
   builder: (BuildContext context, AsyncSnapshot snapshot) {

     return snapshot.connectionState==ConnectionState.waiting?Center(child: CircularProgressIndicator()): snapshot.data==InternetConnectionStatus.connected? ResetPassword(Log!):internet();
   },
 ),


    );
  }
}