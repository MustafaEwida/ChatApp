

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:howru/helpers/InterNetChecker.dart';
import 'package:howru/providers/apiprovider.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:provider/provider.dart';


import '../helpers/Auth.dart';
import '../helpers/nav.dart';
import '../screens/contectProfile.dart';

class main_drwer extends StatelessWidget {
final user = Auth_helper.auth_helper.user;
  @override
  Widget build(BuildContext context) {

    return 
    
     /*
     leading: Consumer<Api_provider>(builder: ((context, value, child) {
                return CircleAvatar(


                backgroundImage: NetworkImage(user!.imgurl!),
                radius: 34.r,
               
              );
              })),
            title: Text(user!.name!,style: TextStyle(color: Colors.white),),
              subtitle:FittedBox(child: Text(user!.email!,style: TextStyle(color: Colors.white)),) ,
     */
     
       Drawer(
      child: Column(
        children: [
         Container(
            
            alignment: Alignment.center,
           color:Theme.of(context).primaryColor,
            width: double.infinity,
            height: 200.h,
            child:Padding(
              padding:  EdgeInsets.all(20.0.sp),
              child: Row(
          
children: [
  Consumer<Api_provider>(builder: ((context, value, child) {
                return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      height: 60.h,
      width: 60.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(100))
      ),
       child: ClipRRect(
        borderRadius: BorderRadius.circular(200),
        child:StreamBuilder(
          stream: InternetChecker.DrwerInternetchecker.onStatusChange,
     
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return snapshot.data==InternetConnectionStatus.disconnected? Image.asset('assets/holder.png',fit: BoxFit.cover,) :  FadeInImage.assetNetwork(placeholder: 'assets/holder.png',image: user!.imgurl!,fit: BoxFit.cover,);
          },
        ),),
     );
                })),SizedBox(width: 10.w,),
                Container(
                  height: 40.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     Text(user!.name!,style: TextStyle(color: Colors.white),),
                  FittedBox(child: Text(user!.email!,style: TextStyle(color: Colors.white)),) , 
                    ],
                  ),
                )
],

              ),
            ),
          ),
          SizedBox(height: 20.h,)
          ,
         
          ListTile(leading: Icon(Icons.person_outlined),title: Text("Profile"),onTap: (){
          Nav.NavigatorKey.currentState!.push(MaterialPageRoute(builder: ((context) => Contect_profile(Auth_helper.auth_helper.user!))));
          },),
          
             ListTile(leading: Icon(Icons.add_box_sharp),title: Text("Add Friends"),onTap: (){
          
         Nav.NavigatorKey.currentState!.pushNamed('search');
          },),
          
          
            ListTile(leading: Icon(Icons.settings),title: Text("Settings"),onTap: (){
        Nav.NavigatorKey.currentState!.pushNamed('settings');
          },),
        /*  ListTile(leading:
          ThemeProvider.controllerOf(context).currentThemeId== ('custom_theme')? Icon(Icons.dark_mode):Icon(Icons.sunny),
            title: ThemeProvider.controllerOf(context).currentThemeId== ('custom_theme')?Text("Dark Mode"):Text("Light Mode"),onTap: (){
//ThemeProvider.controllerOf(context).hasTheme("");
// Add theme
              if (ThemeProvider.controllerOf(context).currentThemeId== ('default_dark_theme')){
                ThemeProvider.controllerOf(context).setTheme('custom_theme');
              }else{
                ThemeProvider.controllerOf(context).setTheme('default_dark_theme');
              }



            },),*/
          ListTile(leading: Icon(Icons.logout),title: Text("LogOut"),onTap: (){
           Auth_helper.auth_helper.logout();
        
          },)













        ],






      ),




    );
      
    
    
  }
}
