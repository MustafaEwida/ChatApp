import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:howru/widgets/main_theme.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class Main_Provider extends ChangeNotifier {
ThemeData themeData = Main_Theme.main_theme ;
bool isdark = false;
bool ProfileInternet = true ;
bool SrarchPageInternet = true;
changeTheme(){
  if(isdark){
themeData = ThemeData.dark();
  }else{
   themeData = Main_Theme.main_theme ; 
  }

notifyListeners();
}
 checkinternet() {
   
     InternetConnectionChecker().onStatusChange.listen((event) {
      final has = event == InternetConnectionStatus.connected;
    
    //  hasinternet = has;
     

      notifyListeners();
    });
  }
changeProfileInternet(){
  ProfileInternet = !ProfileInternet;
  notifyListeners();
}
  
}