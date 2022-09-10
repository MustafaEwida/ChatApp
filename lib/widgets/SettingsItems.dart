import 'dart:io';

import 'package:flutter/material.dart';
import 'package:howru/widgets/settings_item.dart';
import 'package:provider/provider.dart';

import '../helpers/Auth.dart';
import '../models/ex.dart';
import '../helpers/nav.dart';
import '../providers/Main_provider.dart';
import 'Settings_group.dart';

class SettingsItems  extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    return  Column(
  children: [
    Settings_Group(
      title: "Common",
      settingsItems: [

Settings_Item(icon: Icon(Icons.dark_mode), 
title: "Dark Mode",subtitle:Provider.of<Main_Provider>(context).isdark?"on": "off",Trailing: Switch(value:Provider.of<Main_Provider>(context).isdark, onChanged: (change){

   Provider.of<Main_Provider>(context,listen: false).isdark = change;

 Provider.of<Main_Provider>(context ,listen:  false).changeTheme();
}),),


      ],
    ),
    Settings_Group(
      title: "Account",
      settingsItems: [
Settings_Item(icon: Icon(Icons.email), title: "Reset Email",onTap: (){
  Nav.NavigatorKey.currentState!.pushNamed("email_r");
},),
Settings_Item(icon: Icon(Icons.password), title: "Reset Password",onTap:(){
Nav.NavigatorKey.currentState!.pushNamed("reset");
} ,),
Settings_Item(icon: Icon(Icons.password), title: "Delete Account", onTap: ()async{
return showDialog(context: context, builder: (ctx){
return AlertDialog(
title: Text("Are you Sure"),
content: Text("You will not be able to Log in again , and you have to sgin up"),
actions: [
TextButton(onPressed: (){
Nav.NavigatorKey.currentState!.pop();
}, child: Text("Cancel")),
ElevatedButton(onPressed: ()async{
  try {
   await Auth_helper.auth_helper.deleteAccount(); 
  
  }on MyEx catch (e) {
  String masg = '' ;
  if(e.msg.contains("INVALID_ID_TOKEN")){
  masg = "Your credential is no longer valid. You must Log in again and Rsest email again";
  }else if(e.msg.contains("CREDENTIAL_TOO_OLD")){
     masg = "Your credential is Too old. You must Log in again and Rsest email again";
  }
   return  showDialog(context: context, builder: (ctx){
return AlertDialog(
title: Text("Reset Faild"),
content: Text(masg),
actions:<Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                     Navigator.of(ctx).pop();
                },
              )
            ],

);
});
}on SocketException catch(e){
 return  showDialog(context: context, builder: (ctx){
return AlertDialog(
title: Text("Reset Faild"),
content: Text("No internet connection"),
actions:<Widget>[
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


catch(e){
   return  showDialog(context: context, builder: (ctx){
return AlertDialog(
title: Text("Reset Faild"),
content: Text("Something went wrong,check InterNet and Try later"),
actions:<Widget>[
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

Nav.NavigatorKey.currentState!.pop(); 
Nav.NavigatorKey.currentState!.pushReplacementNamed("log");
}, child: Text("Ok")),

],

);

});
},),
      ],
    ),
    Settings_Group(
      title: "Support",
      settingsItems: [

Settings_Item(icon: Icon(Icons.dark_mode), title: "Contect Us",onTap: (){
  Nav.NavigatorKey.currentState!.pushNamed("support");
},),


      ],
    ),
  ],
);
  }
}