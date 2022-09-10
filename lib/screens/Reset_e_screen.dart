import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:howru/models/ex.dart';
import 'package:howru/providers/apiprovider.dart';
import 'package:howru/screens/NoInternet.dart';
import 'package:howru/widgets/Reset.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

import '../helpers/Auth.dart';
import '../helpers/InterNetChecker.dart';
import '../helpers/nav.dart';
import '../providers/Main_provider.dart';

class Rsest_Email extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      
      appBar: AppBar(
        title: Text("Rest Email"),
      ),
      body: StreamBuilder(
        stream: InternetChecker.EmailResetInternetchecker.onStatusChange,
       
        builder: (BuildContext context, AsyncSnapshot snapshot) {
         return snapshot.connectionState==ConnectionState.waiting?Center(child: CircularProgressIndicator()): snapshot.data==InternetConnectionStatus.connected? ResetEmail():internet();
        },
      ),
    );
  }
}
