import 'dart:async';

import 'dart:io';


import 'package:dio/dio.dart';
import 'package:howru/helpers/apihelper.dart';
import 'package:howru/helpers/sharedpref.dart';
import 'package:howru/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/ex.dart';
import 'nav.dart';

class Auth_helper {
  Auth_helper._();
  static Auth_helper auth_helper = Auth_helper._();
  UserMdoel? user;
  Timer? timer;
  String? _Token;
  DateTime? expireDate;

  String get Token {
    if (expireDate != null &&
        expireDate!.isAfter(DateTime.now()) &&
        _Token != null) ;
    return _Token!;
  }

  sginup(UserMdoel UserMdoel) async {
    try {
      final dio = Dio();
      var path =
          'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyC9DDF6YMhlf-UwemVpsCU_tg-0NNM9W_A';
      //   'https://identitytoolkit.googleapis.com/v1/accounts:signInWithCustomToken?key=AIzaSyDczgvKsm59cdxSnBXqnzyrHsw1iunHiVA'
      final res = await dio.post(path, data: {
        "email": UserMdoel.email,
        "password": UserMdoel.password,
        "returnSecureToken": true
      });
      final Map<String, dynamic> x = res.data;

      _Token = x["idToken"];

      expireDate =
          DateTime.now().add(Duration(seconds: int.parse(x['expiresIn'])));

      user = UserMdoel;

      user!.id = x['localId'];
      SharedPreHelper.sharedPreHelper.storeUserData({
        "token": _Token,
        "exDate": expireDate!.toIso8601String(),
        "userId": user!.id,
        "pass": user!.password,
        "email":user!.email,
        "name":user!.name,
        "img":user!.imgurl
      });
      if (Token != null) {
        Nav.NavigatorKey.currentState!.pushReplacementNamed("img");
      }
      autologout();
    } on DioError catch (e) {
      if (e.response != null) {
        throw MyEx(e.response!.data['error']['message']);
      } else {
        throw SocketException("No Connection,Please try agaian later");
       
      }
    } catch (e) {
      throw e;
    }
  }

  sginin(List<String> info) async {
      user = UserMdoel(password: null, email: null, imgurl: null, name: null);
    try {
      final dio = Dio();
      var path =
          'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyC9DDF6YMhlf-UwemVpsCU_tg-0NNM9W_A';
      //   'https://identitytoolkit.googleapis.com/v1/accounts:signInWithCustomToken?key=AIzaSyDczgvKsm59cdxSnBXqnzyrHsw1iunHiVA'
      final res = await dio.post(path, data: {
        "email": info[0],
        "password": info[1],
        "returnSecureToken": true
      });
     
      final Map<String, dynamic> x = res.data;
      _Token = x["idToken"];
      expireDate =
          DateTime.now().add(Duration(seconds: int.parse(x['expiresIn'])));
      user!.id = x["localId"];
      user!.password = info[1];
      final Map<String, dynamic> information =await Api_Helper.api_helper.GitUserDataFromApi();

      user!.email = information['email'];
      user!.imgurl = information['imgurl'];
      user!.name = information['name'];
      SharedPreHelper.sharedPreHelper.storeUserData({
        "token": _Token,
        "exDate": expireDate!.toIso8601String(),
        "userId": user!.id,
        "pass": user!.password,
         "email":user!.email,
        "name":user!.name,
        "img":user!.imgurl
      });

    
      

      if (Token != null) {
        Nav.NavigatorKey.currentState!.pushReplacementNamed("contect");
      }
      autologout();
    } on DioError catch (e) {
     
      if(e.response != null)  {throw MyEx(e.response!.data['error']['message']);}else{ 
        print(e.requestOptions);
        print(e.message);
         throw SocketException("No Connection,Please try agaian later");
      }
      
      
    } catch (e) {
      throw e;
    }
  }

  logout() async {
    _Token = null;
    expireDate = null;
    user!.id = null;
    user = null;
    if (timer != null) {
      timer!.cancel();
      timer = null;
    }
    Nav.NavigatorKey.currentState!.pushReplacementNamed('log');

    final SP = await SharedPreferences.getInstance();
    SP.clear();
  }

  autologout() {
    if (timer != null) {
      timer!.cancel();
    }
    final secs = expireDate!.difference(DateTime.now()).inSeconds;
    timer = Timer(Duration(seconds: secs), logout);
  }

  Future<bool> TryLogIn() async {
    user = UserMdoel(password: null, email: null, imgurl: null, name: null);
    final data = await SharedPreHelper.sharedPreHelper.getStoredData();
    if (data.isEmpty) {
      return false;
    }
    final exdate = DateTime.parse(data['exDate']);
    _Token = data["token"];
    
    user!.id = data['userId'];
    user!.password = data['pass'];
    user!.email = data['email'];
    user!.imgurl = data['img'];
    user!.name = data['name'];
   

   /* final path =
        'https://wellcome-ec07c-default-rtdb.firebaseio.com/users/${user!.id}.json?auth=$Token';
    final dio = Dio();
    final response = await dio.get(path);*/
    //final Map<String, dynamic> information = await Api_Helper.api_helper.GitUserDataFromApi();

    /* final values = information.values.toList();
    final Map<String,dynamic> data = values[0];*/
    

    expireDate = exdate;
    return true;
  }
//reset password
  Reset(String email) async {
    final dio = Dio();
    final path =
        'https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode?key=AIzaSyC9DDF6YMhlf-UwemVpsCU_tg-0NNM9W_A';
    await dio
        .post(path, data: {"requestType": "PASSWORD_RESET", "email": email});
  }

  changeEmail(String email) async {
    final dio = Dio();
    var path =
        'https://identitytoolkit.googleapis.com/v1/accounts:update?key=AIzaSyC9DDF6YMhlf-UwemVpsCU_tg-0NNM9W_A';

    try {
      final response = await dio.post(path,
          data: {"idToken": _Token, "email": email, "returnSecureToken": true});
      print(email);
      Map<String, dynamic> data = response.data;

      _Token = data['idToken'];
      print(_Token);
      int secs = int.parse(data['expiresIn']);
      expireDate = DateTime.now().add(Duration(seconds: secs));
      path =
          'https://wellcome-ec07c-default-rtdb.firebaseio.com/users/${user!.id}.json?auth=$Token';
      await dio.patch(path, data: {'email': email});
    } on DioError catch (e) {
      print(e.response!.data);
      throw MyEx(e.response!.data['error']['message']);
    } catch (e) {
      throw e;
    }
  }

  deleteAccount() async {
    final dio = Dio();
    try {
      var path =
          "https://identitytoolkit.googleapis.com/v1/accounts:delete?key=AIzaSyC9DDF6YMhlf-UwemVpsCU_tg-0NNM9W_A";
      await dio.post(path, data: {"idToken": Token});
      path =
          'https://wellcome-ec07c-default-rtdb.firebaseio.com/users/${user!.id}.json?auth=$Token';
      await dio.delete(path);
      logout();
    } on DioError catch (e) {
      print(e.response!.data);

      
      if(e.response != null)  {throw MyEx(e.response!.data['error']['message']);}
      
      else if(e.message.contains("SocketException")) { 
        print(e.requestOptions);
        print(e.message);
         throw SocketException("No Connection,Please try agaian later");
      }

    } catch (e) {
      throw e;
    }
  }
}
