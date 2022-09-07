import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:howru/helpers/Auth.dart';
import 'package:howru/models/contect.dart';
import 'package:howru/models/user.dart';
import 'package:howru/nav.dart';
import 'package:howru/screens/chatscreen.dart';
import 'package:howru/widgets/confirmation.dart';
import 'package:howru/widgets/maindrewer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

import '../providers/apiprovider.dart';

class Contect_profile extends StatefulWidget {
  UserMdoel contect_model;
  Contect_profile(this.contect_model);

  @override
  _Edit_InfoState createState() => _Edit_InfoState();
}

class _Edit_InfoState extends State<Contect_profile> {
 File? b;
 TextEditingController tec = TextEditingController();
 bool isEdit = false;
  Contect_Model? contect;
bool  isload = false;
  bool isexist = false;
  bool sure = false;
  bool get userProfile {
    return widget.contect_model.id == Auth_helper.auth_helper.user!.id;
  }
  addimg(ImageSource imgs) async {
    final imgpicker = ImagePicker();
    final img = await imgpicker.pickImage(source: imgs, maxWidth: 480);
    if (img == null) {
      return;
    }
    setState(() {
      isload = true;
      b = File(img.path);
    });

    await Provider.of<Api_provider>(context, listen: false).updateimg(b!);

    setState(() {
      isload = false;
    });
    
  }

pickimg() {
    final imgpicker = ImagePicker();
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text("Pick Image From:"),
            actions: [
              ElevatedButton.icon(
                  onPressed: (() async {
                    addimg(ImageSource.camera);
                    Nav.NavigatorKey.currentState!.pop();
                  }),
                  icon: Icon(Icons.camera),
                  label: Text("Camera")),
              ElevatedButton.icon(
                  onPressed: () async {
                    addimg(ImageSource.gallery);
                    Nav.NavigatorKey.currentState!.pop();
                  },
                  icon: Icon(Icons.image),
                  label: Text("gallry")),
            ],
          );
        });
  }

  @override
  void initState() {
    /*final conts = Provider.of<Api_provider>(context,listen: false).contects;
    
   conts.forEach((element) {
    if(element.id==widget.contect_model.id) {
      isexist=true;
      contect = element;
    
    };
   },);*/
    print("isinit");
    super.initState();
  }

  Widget custembutton(String txt, VoidCallback handler, Color? color) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.r),
          ),
          primary: color,
          onPrimary: Colors.white,
          padding: EdgeInsets.all(10.sp),
          minimumSize: Size(0, 0),
          elevation: 8,
        ),
        onPressed:handler,
        child: Text(txt));
  }

  Widget custemInfo(IconData icons, String title, String txt) {
    return Padding(
      padding: EdgeInsets.all(10.0.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icons, size: 30.sp, color: Theme.of(context).primaryColor),
              SizedBox(
                width: 20.w,
              ),
              Text(
                title,
                style: TextStyle(
                    fontSize: 20.sp, color: Theme.of(context).primaryColor),
              )
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 50.w,
              ),
              Text(
                txt,
                style: TextStyle(
                  fontSize: 20.sp,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

changeName(String txt,bool exist)async{
  
if(txt.isEmpty){
 return  showDialog(context: context, builder: (ctx){
return AlertDialog(
title: Text("Reset Faild"),
content: Text("Enter Name"),
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



  }else if(exist){
    
 return  showDialog(context: context, builder: (ctx){
return AlertDialog(
title: Text("Reset Faild"),
content: Text("Name already exist"),
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
  
  
  
  
  else{
await Provider.of<Api_provider>(context,listen: false).updatename(txt);




  }



}

  @override
  Widget build(BuildContext context) {
   Provider.of<Api_provider>(context);
  isexist = Provider.of<Api_provider>(context,listen: false).iscontect(widget.contect_model, contect);
   
  
    return Scaffold(
        appBar: AppBar(title: Text("${widget.contect_model.name} Profile")),
        body: ListView(children: [
          Container(
            width: double.infinity,
            height: 1.sh / 3.1,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(children: [
                  Container(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                  ),
                  Container(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight / 1.2,
                    color: Theme.of(context).primaryColor,
                  ),
                  Positioned(
                    top: constraints.maxHeight / 1.9,
                    right: constraints.maxWidth / 2 - 55.w,
                    child: CircleAvatar(
                      backgroundImage:
                     b!=null?FileImage(b!)    : NetworkImage( widget.contect_model.imgurl!) as ImageProvider,
                      radius: 55.r,
                    ),
                  ),
               if(userProfile)   Positioned(
                      top: constraints.maxHeight / 1.20,
                    right: constraints.maxWidth / 2 - 55.w,
                    
                    child:isload? CircularProgressIndicator() :IconButton(onPressed: (){
                    pickimg();
                  }, icon: Icon(Icons.camera_alt,size: 40.sp,color: Theme.of(context).primaryColor,)))
                ]);
              },
            ),
          ),
         Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           custemInfo(Icons.person, "Name", widget.contect_model.name!),
           if(userProfile) isEdit?IconButton(onPressed: (() async{
            List<String> names = Provider.of<Api_provider>(context,listen: false).usersnames;
 bool exist = names.contains(tec.text);

await changeName(tec.text, exist);
tec.clear();
              setState(() {
               isEdit = false;
             });
           }), icon: Icon(Icons.save)) :IconButton(onPressed: (() async{
 
             setState(() {
               isEdit = true;
             });
           }), icon: Icon(Icons.edit,color: Theme.of(context).primaryColor,))
         ],),
        
          if(isEdit)  Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20.w),
          child: TextField(
            
          
            keyboardType: TextInputType.text,
   controller: tec,
   decoration: InputDecoration(
    hintText: "Enter new name",
   
   
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50.r),
      borderSide: BorderSide(width: 1.w,color: Theme.of(context).accentColor)
    ),
    focusedBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.r),
      borderSide: BorderSide(width: 1.w,color: Theme.of(context).accentColor)
    )
   ),


          ),
        ),
   if (userProfile) Divider(),  
          if (userProfile)
            custemInfo(Icons.mail_outline_outlined, "Email",
                widget.contect_model.email!),
          if (userProfile) Divider(),
          if (!userProfile)
            if (!isexist)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  custembutton("Add Contect", () async {
                    await Provider.of<Api_provider>(context, listen: false)
                        .addcontect(widget.contect_model);
                  }, Theme.of(context).primaryColor)
                ],
              ),
          if (!userProfile)
            if (isexist)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  custembutton("Open chat", () {
                    Nav.NavigatorKey.currentState!.push(MaterialPageRoute(
                        builder: ((context) => contect==null? main_drwer() :chat_screen(contect!))));
                  }, Theme.of(context).primaryColor),
                  SizedBox(
                    width: 10.w,
                  ),
                  custembutton("Delete contect", () {
                    showDialog(
                        context: context,
                        builder: (ctx) {
                          return AlertDialog(
                            title: confirmation(widget.contect_model),
                          );
                        });
                  }, Theme.of(context).errorColor)
                ],
              )
        ]));
  }
}
