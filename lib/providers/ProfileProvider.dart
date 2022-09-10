

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class Profile_Provider extends ChangeNotifier {
 bool isload = false; 
  bool  isEdit = false;
  changeIsLoad(){
 isload = !isload; 
notifyListeners();


  }
   changeisEdit(){
  isEdit = ! isEdit; 
notifyListeners();


  } 
File?   ChangeToNormelFile(XFile img,File? b){
  b = File(img.path);
 isload = !isload; 
 
notifyListeners();
return b;

}
}