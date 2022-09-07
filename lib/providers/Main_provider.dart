import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:howru/widgets/main_theme.dart';

class Main_Provider extends ChangeNotifier {
ThemeData themeData = Main_Theme.main_theme ;
bool isdark = false;
changeTheme(){
  if(isdark){
themeData = ThemeData.dark();
  }else{
   themeData = Main_Theme.main_theme ; 
  }

notifyListeners();
}

  
}