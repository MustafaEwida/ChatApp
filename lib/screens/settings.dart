import 'package:flutter/material.dart';
import 'package:howru/helpers/Auth.dart';
import 'package:howru/models/ex.dart';
import 'package:howru/nav.dart';
import 'package:howru/providers/Main_provider.dart';
import 'package:howru/widgets/Settings_group.dart';
import 'package:howru/widgets/maindrewer.dart';
import 'package:howru/widgets/settings_item.dart';
import 'package:provider/provider.dart';

class Settings_screen extends StatefulWidget {
  

  @override
  State<Settings_screen> createState() => _Settings_screenState();
}

class _Settings_screenState extends State<Settings_screen> {
  bool isDark = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
body:  Column(
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
}catch(e){
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

Settings_Item(icon: Icon(Icons.dark_mode), title: "Contect Us",),


      ],
    ),
  ],
)

    );
  }
}