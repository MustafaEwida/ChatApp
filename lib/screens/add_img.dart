import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:howru/helpers/Auth.dart';
import 'package:howru/helpers/nav.dart';
import 'package:howru/providers/apiprovider.dart';
import 'package:howru/widgets/ImgAdd.dart';
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
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ImgAdd(),
    );
  }
}
