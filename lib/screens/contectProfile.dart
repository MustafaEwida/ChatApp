import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:howru/helpers/Auth.dart';
import 'package:howru/models/contect.dart';
import 'package:howru/models/user.dart';
import 'package:howru/helpers/nav.dart';
import 'package:howru/providers/ProfileProvider.dart';
import 'package:howru/screens/chatscreen.dart';
import 'package:howru/widgets/Profile.dart';
import 'package:howru/widgets/confirmation.dart';
import 'package:howru/widgets/maindrewer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

import '../providers/apiprovider.dart';

class Contect_profile extends StatelessWidget {
  UserMdoel userMdoel;
  Contect_profile(this. userMdoel);

  @override
  Widget build(BuildContext context) {
   Provider.of<Api_provider>(context);
 
   
  
    return Scaffold(
        appBar: AppBar(title: Text("${ userMdoel.name} Profile")),
        body:ChangeNotifierProvider(create: ((context) => Profile_Provider()),child: Profile(userMdoel),) );
  }
}
