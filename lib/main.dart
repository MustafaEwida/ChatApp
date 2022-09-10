import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:howru/helpers/localNotify.dart';
import 'package:howru/models/contect.dart';
import 'package:howru/helpers/nav.dart';
import 'package:howru/providers/LogInProvider.dart';
import 'package:howru/providers/Main_provider.dart';
import 'package:howru/providers/apiprovider.dart';
import 'package:howru/screens/Contect.dart';
import 'package:howru/screens/Rest.dart';
import 'package:howru/screens/Support.dart';
import 'package:howru/screens/accept_friend_screen.dart';
import 'package:howru/screens/add_img.dart';
import 'package:howru/screens/contectProfile.dart';
import 'package:howru/screens/home.dart';
import 'package:howru/screens/login.dart';
import 'package:howru/screens/search.dart';
import 'package:howru/screens/settings.dart';
import 'package:howru/screens/sign.dart';
import 'package:howru/widgets/main_theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/Reset_e_screen.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
 FlutterNativeSplash.preserve(widgetsBinding: WidgetsBinding.instance);
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getToken();
 await Local_Notify.init();
  FirebaseMessaging.onBackgroundMessage(handler);
   final SP = await  SharedPreferences.getInstance();
  SP.setString("token","");
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: ((context) => Api_provider())),
    ChangeNotifierProvider(create: ((context) => Main_Provider())),
    ChangeNotifierProvider(create: ((context) => LogIn_Provider()))
    ],
    child: MyApp(),
  ));
FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {    
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: ((context, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Provider.of<Main_Provider>(context).themeData,
        navigatorKey: Nav.NavigatorKey,
        routes: {
          "contect": ((context) => Contects_screen()),
          "log": (context) => MyLogin(),
          "sign": (context) => MySign(),
          'img': (context) => img_screen(),
          'search': (context) => Search_screen(),
          'settings':(context) => Settings_screen(),
          "reset":(context) => Reset_screen(),
          "email_r":(context) => Rsest_Email(),
         "support":(context) => Contact_screen(),
        },
        home: Home(),
      );
    }));
    
    
  }
  
}
