import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../helpers/nav.dart';
import '../providers/apiprovider.dart';

class ImgAdd extends StatefulWidget {
 

  @override
  _ImgAddState createState() => _ImgAddState();
}

class _ImgAddState extends State<ImgAdd> {
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
    return Container(
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
      );
  }
}