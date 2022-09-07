import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Settings_Item extends StatelessWidget {
  Settings_Item({required this.icon,required this.title,this.Trailing,this. onTap,this.subtitle});
Icon icon;
String title;
String? subtitle;
Widget? Trailing;
void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(

      onTap: onTap,
      child: 
    Container(
      padding: EdgeInsets.all(10.sp),
      child: ListTile(
   leading:icon ,
   title: Text(title,style: TextStyle(fontWeight: FontWeight.w500)),
   subtitle: subtitle!=null? Text(subtitle!):null,
  trailing: Trailing,

      ),
      
    ),);
  }
}