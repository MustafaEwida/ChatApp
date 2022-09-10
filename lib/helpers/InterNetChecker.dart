import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetChecker {
  static final  Internetchecker = InternetConnectionChecker.createInstance(
 //   checkTimeout: const Duration(seconds: 1), // Custom check timeout

    checkInterval: const Duration( milliseconds: 300), // Custom check interval
   
  );
  static final  SearchInternetchecker = InternetConnectionChecker.createInstance(
 //   checkTimeout: const Duration(seconds: 1), // Custom check timeout

    checkInterval: const Duration( milliseconds: 300), // Custom check interval
   
  );
   static final  EmailResetInternetchecker = InternetConnectionChecker.createInstance(
 //   checkTimeout: const Duration(seconds: 1), // Custom check timeout

    checkInterval: const Duration( milliseconds: 300), // Custom check interval
   
  );
  static final  PasswordResetInternetchecker = InternetConnectionChecker.createInstance(
 //   checkTimeout: const Duration(seconds: 1), // Custom check timeout

    checkInterval: const Duration( milliseconds: 300), // Custom check interval
   
  );
  //ChatInternetchecker
   static final  ChatInternetchecker = InternetConnectionChecker.createInstance(
 //   checkTimeout: const Duration(seconds: 1), // Custom check timeout

    checkInterval: const Duration( milliseconds: 300), // Custom check interval
   
  );
   static final  DrwerInternetchecker = InternetConnectionChecker.createInstance(
 //   checkTimeout: const Duration(seconds: 1), // Custom check timeout

    checkInterval: const Duration( milliseconds: 300), // Custom check interval
   
  );
}