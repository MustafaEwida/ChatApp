import 'package:flutter/cupertino.dart';

class LogIn_Provider extends ChangeNotifier {
  bool isLog = false;
  bool Isvisible = true;
 bool Isvisible2 = true;
showPassword(){
Isvisible = !Isvisible;
notifyListeners();

}
showConformedPassword(){
Isvisible2 = !Isvisible2;
notifyListeners();

}


ChangeIsLog(){
isLog = !isLog;
print(isLog);
notifyListeners();
}
onSaved(FormState? formState){
 if (formState!.validate()){
ChangeIsLog();


 }


  
}
/*

 void onSvaed() async{
    if (form.currentState!.validate()) {
      form.currentState!.save();
       Provider.of<LogIn_Provider>(context,listen: false).ChangeIsLog();
  try {
    await Auth_helper.auth_helper.sginin(info); }
    on MyEx catch(e){
      print(e.msg);
      String msg = 'somthing wrong';
          if(e.msg.contains('EMAIL_NOT_FOUND')){
              msg = 'Email not found,check again';
          }else if(e.msg.contains('INVALID_PASSWORD')){
msg = 'Wrong password,Enter correct password';
          }else if(e.msg.contains('USER_DISABLED')){
msg = 'The user account has been deleted by him or disabled by an administrator.';
          }
            showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text("Something Went wrong"),
                content: Text(msg),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Ok"),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                  )
                ],
              );
            });     

         } 
    
    
    
    
    catch(e){

 showDialog(context: context, builder: (ctx){
return AlertDialog(
title: Text("Something Went wrong"),
content: Text(e.toString()),
actions:<Widget>[
              FlatButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],

);});

   }
   /*setState(() {
     isload = false;
   }); 
*/
Provider.of<LogIn_Provider>(context,listen: false).ChangeIsLog();
    }*/
  }
