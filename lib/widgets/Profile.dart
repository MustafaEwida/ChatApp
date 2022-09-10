import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:howru/providers/ProfileProvider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../helpers/Auth.dart';
import '../helpers/InterNetChecker.dart';
import '../models/contect.dart';
import '../models/user.dart';
import '../helpers/nav.dart';
import '../providers/apiprovider.dart';
import '../screens/chatscreen.dart';
import 'confirmation.dart';

class Profile extends StatefulWidget {
  UserMdoel userMdoel;
  Profile(this.userMdoel);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? b;
  TextEditingController tec = TextEditingController();
  Contect_Model? contect;
  bool isexist = false;
  bool isconected = true;
  bool sure = false;
  bool get userProfile {
    return widget.userMdoel.id == Auth_helper.auth_helper.user!.id;
  }

  addimg(ImageSource imgs) async {
    final imgpicker = ImagePicker();
    final img = await imgpicker.pickImage(source: imgs, maxWidth: 480);
    if (img == null) {
      return;
    }
    b = Provider.of<Profile_Provider>(context, listen: false)
        .ChangeToNormelFile(img, b);

    await Provider.of<Api_provider>(context, listen: false).updateimg(b!);
    Provider.of<Profile_Provider>(context, listen: false).changeIsLoad();
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
    List data = Provider.of<Api_provider>(context, listen: false)
        .iscontect(widget.userMdoel, contect);
    isexist = data[0];
    contect = data[1];
   
  
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
        onPressed: handler,
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

  changeName(String txt, bool exist) async {
    if (txt.isEmpty) {
      return showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text("Reset Faild"),
              content: Text("Enter Name"),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                )
              ],
            );
          });
    } else if (exist) {
      return showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text("Reset Faild"),
              content: Text("Name already exist"),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                )
              ],
            );
          });
    } else {
      await Provider.of<Api_provider>(context, listen: false).updatename(txt);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: InternetChecker.Internetchecker.onStatusChange,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == InternetConnectionStatus.connected) {
          isconected = true;
//Provider.of<Main_Provider>(context,listen: false).changeProfileInternet();

        } else if (snapshot.data == InternetConnectionStatus.disconnected) {
          isconected = false;
          //  Provider.of<Main_Provider>(context,listen: false).changeProfileInternet();
        }
        print(isconected);
        return ListView(children: [
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
                      backgroundImage: b != null
                          ? FileImage(b!)
                          : NetworkImage(widget.userMdoel.imgurl!)
                              as ImageProvider,
                      radius: 55.r,
                    ),
                  ),
                  if (userProfile)
                    isconected
                        ? Positioned(
                            top: constraints.maxHeight / 1.20,
                            right: constraints.maxWidth / 2 - 55.w,
                            child: Consumer<Profile_Provider>(
                                builder: ((context, provider, child) {
                              return provider.isload
                                  ? CircularProgressIndicator(
                                      color: Theme.of(context).accentColor,
                                    )
                                  : IconButton(
                                      onPressed: () {
                                        pickimg();
                                      },
                                      icon: Icon(
                                        Icons.camera_alt,
                                        size: 40.sp,
                                        color: Theme.of(context).primaryColor,
                                      ));
                            })))
                        : SizedBox()
                ]);
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              custemInfo(Icons.person, "Name", widget.userMdoel.name!),
              if (userProfile)
                !isconected
                    ? SizedBox()
                    : Consumer<Profile_Provider>(
                        builder: ((context, provider, child) {
                        return provider.isEdit
                            ? IconButton(
                                onPressed: (() async {
                                  List<String> names =
                                      Provider.of<Api_provider>(context,
                                              listen: false)
                                          .usersnames;
                                  bool exist = names.contains(tec.text);

                                  await changeName(tec.text, exist);
                                  tec.clear();
                                  Provider.of<Profile_Provider>(context,
                                          listen: false)
                                      .changeisEdit();
                                }),
                                icon: Icon(Icons.save))
                            : IconButton(
                                onPressed: (() async {
                                  Provider.of<Profile_Provider>(context,
                                          listen: false)
                                      .changeisEdit();
                                }),
                                icon: Icon(
                                  Icons.edit,
                                  color: Theme.of(context).primaryColor,
                                ));
                      }))
            ],
          ),
          Consumer<Profile_Provider>(builder: ((context, Provider, child) {
            return !Provider.isEdit
                ? SizedBox()
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      controller: tec,
                      decoration: InputDecoration(
                          hintText: "Enter new name",
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.r),
                              borderSide: BorderSide(
                                  width: 1.w,
                                  color: Theme.of(context).accentColor)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.r),
                              borderSide: BorderSide(
                                  width: 1.w,
                                  color: Theme.of(context).accentColor))),
                    ),
                  );
          })),
          if (userProfile) Divider(),
          if (userProfile)
            custemInfo(
                Icons.mail_outline_outlined, "Email", widget.userMdoel.email!),
          if (userProfile) Divider(),
          if (!userProfile)
            if (!isexist)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  custembutton("Add Contect", () async {
                    await Provider.of<Api_provider>(context, listen: false)
                        .addcontect(widget.userMdoel);
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
                        builder: ((context) => chat_screen(contect!))));
                  }, Theme.of(context).primaryColor),
                  SizedBox(
                    width: 10.w,
                  ),
                  custembutton("Delete contect", () {
                    showDialog(
                        context: context,
                        builder: (ctx) {
                          return AlertDialog(
                            title: confirmation(widget.userMdoel, isconected),
                          );
                        });
                  }, Theme.of(context).errorColor),
                  SizedBox(
                    width: 10.w,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(20.r)),
                    width: 30.w,
                    height: 30.h,
                    child: PopupMenuButton(
                      child: Icon(
                        Icons.more_horiz_rounded,
                        color: Colors.white,
                      ),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 'report',
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.report,
                                color: Theme.of(context).primaryColor,
                              ),
                              SizedBox(width: 15.w),
                              Text('report'),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'Block',
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.block,
                                color: Theme.of(context).primaryColor,
                              ),
                              SizedBox(width: 15.w),
                              Text('Block'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
        ]);
      },
    );
  }
}
