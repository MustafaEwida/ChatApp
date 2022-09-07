import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:howru/helpers/Auth.dart';
import 'package:howru/nav.dart';
import 'package:howru/providers/apiprovider.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:provider/provider.dart';

class img_screen extends StatefulWidget {
  @override
  _img_screenState createState() => _img_screenState();
}

class _img_screenState extends State<img_screen> {
  bool isload = false;
  File? b;
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

    await Provider.of<Api_provider>(context, listen: false).addimg(b);

    setState(() {
      isload = false;
    });
    Nav.NavigatorKey.currentState!.pushReplacementNamed('contect');
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 1.sw,
        height: 1.sh,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 100.r,
              backgroundImage: b != null ? FileImage(b!) : null,
              child: b != null
                  ? null
                  : Icon(
                      Icons.person,
                      size: 120.sp,
                    ),
            ),
            SizedBox(
              height: 30.h,
            ),
            isload
                ? CircularProgressIndicator()
                : ElevatedButton(onPressed: pickimg, child: Text('Add Image'))
          ],
        )),
      ),
    );
  }
}
