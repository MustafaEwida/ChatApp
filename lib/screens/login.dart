
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:howru/helpers/Auth.dart';
import 'package:howru/helpers/apihelper.dart';
import 'package:howru/models/ex.dart';
import 'package:howru/models/user.dart';
import 'package:howru/helpers/nav.dart';
import 'package:howru/providers/LogInProvider.dart';
import 'package:howru/screens/Rest.dart';
import 'package:howru/widgets/logForm.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';

import '../providers/apiprovider.dart';

class MyLogin extends StatelessWidget {
  

 
 Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor:Color.fromARGB(255, 118, 124, 181),
      body:  LogForm(),
     
      
    );
  }


}