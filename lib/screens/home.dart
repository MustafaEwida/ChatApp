import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:howru/helpers/Auth.dart';
import 'package:howru/screens/Contect.dart';
import 'package:howru/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
   
 
    return FutureBuilder(
      future:Auth_helper.auth_helper.TryLogIn(),
     
      builder: (BuildContext context,AsyncSnapshot<bool>  snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting){
           FlutterNativeSplash.preserve(widgetsBinding: WidgetsBinding.instance);
        }else{
          FlutterNativeSplash.remove();
        }
        return   snapshot.data==true?Contects_screen() :MyLogin() ;
      },
    );
  }
}