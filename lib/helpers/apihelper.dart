import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:howru/helpers/Auth.dart';
import 'package:howru/models/contect.dart';
import 'package:howru/models/msgmodel.dart';
import 'package:howru/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api_Helper {
   List<UserMdoel> users = [];
  Api_Helper._();
  static Api_Helper api_helper = Api_Helper._();
  final dio = Dio();
  final token = Auth_helper.auth_helper.Token;
  final user = Auth_helper.auth_helper.user;

Future<Map<String, dynamic>>GitUserDataFromApi()async{
final  path =
          'https://wellcome-ec07c-default-rtdb.firebaseio.com/users/${ Auth_helper.auth_helper.user!.id}.json?auth=${Auth_helper.auth_helper.Token}';

      final response = await dio.get(path);
      print(response.data);
      final Map<String, dynamic> information = response.data;
      return information;

  }
  Future<List<UserMdoel>> Recentusers() async {
    List<UserMdoel> users = [];
    final path =
        'https://wellcome-ec07c-default-rtdb.firebaseio.com/users.json?auth=${token}';
    final response = await dio.get(path);
    final Map<String, dynamic> info = response.data;
    info.forEach(
      (key, value) {
       
          if (DateTime.parse(value['sgindate'])
              .isAfter(DateTime.now().subtract(Duration(days: 1))))
            users.add(UserMdoel(
                id: key,
                email: value['email'],
                imgurl: value['imgurl'],
                name: value['name']));
        
      },
    );

    return users;
  }

  Future<List<List<UserMdoel>>> allusers() async {
  
    List<UserMdoel> resent = [];

    final path =
        'https://wellcome-ec07c-default-rtdb.firebaseio.com/users.json?auth=${token}';
    final response = await dio.get(path);
    final Map<String, dynamic> info = response.data;
    info.forEach(
      (key, value) {
       
          users.add(UserMdoel(
              id: key,
              email: value['email'],
              imgurl: value['imgurl'],
              name: value['name']));
        
      },
    );
 /*   final usersdata = json.encode({
      "users":users
    });
 final shp =await  SharedPreferences.getInstance();
 shp.setString("users", usersdata);
//final respons = await dio.get(path);
//final Map<String,dynamic> infor = response.data;*/
    info.forEach(
      (key, value) {
       
          if (DateTime.parse(value['signdate'])
              .isAfter(DateTime.now().subtract(Duration(hours: 1)))) {
            if (resent.length <= 4) {
              resent.add(UserMdoel(
                  id: key,
                  email: value['email'],
                  imgurl: value['imgurl'],
                  name: value['name']));
            }
          }
        
      },
    );

    return [users, resent];
  }
 Future< List<UserMdoel>>  getstoredusers()async{
final shp =await  SharedPreferences.getInstance();
if(shp.containsKey("users")){
 final data = await shp.getString("users");
 Map<String,dynamic> storeddata = json.decode(data!) ;
 users =storeddata["users"];
 return users;
}
return [];
 
  }

  test() async {
    Response<ResponseBody> rs;
    final contectspath =
        'https://wellcome-ec07c-default-rtdb.firebaseio.com/contects/${user!.id}.json?auth=${token}';
    rs = await Dio().get<ResponseBody>(
      contectspath,
      options: Options(
          responseType: ResponseType.stream), // set responseType to `stream`
    );
    //response stream
  }

//............................................................................................................
  addcontect(UserMdoel userMdoel) async {
    var contectspath =
        'https://wellcome-ec07c-default-rtdb.firebaseio.com/contects/${user!.id}.json?auth=${token}';
    final responses = await dio.get(contectspath);
    if (responses.data != null) {
      Map<String, dynamic> contects = responses.data;
      contects.forEach((key, value) {
        if (key == user!.id) {
          return;
        }
      });
    }

    final path =
        'https://wellcome-ec07c-default-rtdb.firebaseio.com/contects/${user!.id}/${userMdoel.id}.json?auth=${token}';
    final response = await dio.put(path, options: Options(), data: {
      "id": userMdoel.id,
      "img": userMdoel.imgurl,
      "name": userMdoel.name,
    });
    final co_path =
        'https://wellcome-ec07c-default-rtdb.firebaseio.com/contects/${userMdoel.id}/${user!.id}.json?auth=${token}';
    final respon = await dio.put(co_path, options: Options(), data: {
      "id": user!.id,
      "img": user!.imgurl,
      "name": user!.name,
    });
  } //List<Contect_Model>

  Future<List<Contect_Model>> GetContects() async {
    List<Contect_Model> contects = [];
    final contectspath =
        'https://wellcome-ec07c-default-rtdb.firebaseio.com/contects/${Auth_helper.auth_helper.user!.id}.json?auth=${token}';
    final responses = await dio.get(contectspath);
if(responses.data==null){
  return [];
}
    Map<String, dynamic> contectsdata = responses.data;
    contectsdata.forEach((key, value) {
      final Contect_Model contect_model =
          Contect_Model(value['id'], value['name'], value['img']);
      contects.add(contect_model);
    });
    return contects;
  }

  addimg(File? b) async {
    final ref = await FirebaseStorage.instance
        .ref()
        .child('imgs')
        .child('${user!.id!}' + '.jpg');
    await ref.putFile(b!);
    final url = await ref.getDownloadURL();

    final path =
        'https://wellcome-ec07c-default-rtdb.firebaseio.com/users/${user!.id}.json?auth=$token';
    final response = await dio.put(path, data: {
      "signdate": DateTime.now().toString(),
      "email": Auth_helper.auth_helper.user!.email,
      "name": Auth_helper.auth_helper.user!.name,
      "imgurl": url,
    });
    Auth_helper.auth_helper.user!.imgurl = url;
  }

  updateimg(File? b) async {
    final ref = await FirebaseStorage.instance
        .ref()
        .child('imgs')
        .child('${user!.id!}' + '.jpg');
    if (b == null) {
      return;
    }
    ref.delete();
    await ref.putFile(b);
    final url = await ref.getDownloadURL();
    final path =
        'https://wellcome-ec07c-default-rtdb.firebaseio.com/users/${user!.id}.json?auth=$token';
    final response = await dio.patch(path, data: {
      "imgurl": url,
    });
    Auth_helper.auth_helper.user!.imgurl = url;
  }

  addmsg(String msg, Contect_Model contect_model) async {
//final co_path ='https://wellcome-ec07c-default-rtdb.firebaseio.com/chats/${contect_model.id}/${user!.id}.json?auth=$token';
//final respo = dio.get(co_path);

    final path =
        'https://wellcome-ec07c-default-rtdb.firebaseio.com/chats/${user!.id}/${contect_model.id}.json?auth=$token';
/*final res = await dio.post(path,data: {
  'msg': msg,
  "id": user!.id
});*/
    final co_path =
        'https://wellcome-ec07c-default-rtdb.firebaseio.com/chats/${contect_model.id}/${user!.id}.json?auth=$token';
/*final co_res = await dio.post(co_path,data: {
  'msg': msg,
  "id": user!.id
});*/

    final response = await Future.wait([
      dio.post(path, data: {
        'msg': msg,
        "user_id": user!.id,
        "date": DateTime.now().toIso8601String()
      }),
      dio.post(co_path, data: {
        'msg': msg,
        "user_id": user!.id,
        "date": DateTime.now().toIso8601String()
      })
    ]);
  }

//............................................................................................................
  Future<List<Msg_model>> getmsgs(Contect_Model contect_model) async {
    List<Msg_model> maga = [];
    final path =
        'https://wellcome-ec07c-default-rtdb.firebaseio.com/chats/${user!.id}/${contect_model.id}.json?auth=$token';
      
    final res = await dio.get(path);

    Map<String, dynamic> msgs = res.data;
    msgs.forEach((key, value) {
      maga.add(Msg_model(
          value["user_id"], value["msg"], DateTime.parse(value["date"])));
    });
    return maga;
  }

  Future<List<dynamic>> getlasymsg(Contect_Model contect_model) async {
    List<Msg_model> maga = [];
    final path =
        'https://wellcome-ec07c-default-rtdb.firebaseio.com/chats/${Auth_helper.auth_helper.user!.id}/${contect_model.id}.json?auth=$token'; 
         
      
    final res = await dio.get(path);
  
    if (res.data == null) {
      return ['No chat,say hi', null, null];
    }
    Map<String, dynamic> msgs = res.data;

    msgs.forEach((key, value) {
      Msg_model(value["user_id"], value["msg"], DateTime.parse(value["date"]));
      maga.add(Msg_model(
          value["user_id"], value["msg"], DateTime.parse(value["date"])));
    });
    final lastmsg = maga[maga.length - 1];
    var last = lastmsg.text;
    if (last == null) {
      last = 'No chat,say hi';
    }
    final date = lastmsg.dateTime;
    final id = lastmsg.useriD;

    return [last, date, id];
  }

  deletcontect(UserMdoel userMdoel, bool sure) async {
    final path =
        'https://wellcome-ec07c-default-rtdb.firebaseio.com/contects/${user!.id}/${userMdoel.id}.json?auth=${token}';
    await dio.delete(path);
    final co_path =
        'https://wellcome-ec07c-default-rtdb.firebaseio.com/contects/${userMdoel.id}/${user!.id}.json?auth=${token}';
    await dio.delete(co_path);
    if (sure) {
      final chatpath =
          'https://wellcome-ec07c-default-rtdb.firebaseio.com/chats/${user!.id}/${userMdoel.id}.json?auth=${token}';
      await dio.delete(chatpath);
      final coc_path =
          'https://wellcome-ec07c-default-rtdb.firebaseio.com/chats/${userMdoel.id}/${user!.id}.json?auth=$token';
      await dio.delete(coc_path);
    }
  }

  deleteChat(Contect_Model contect_model) async {
    final path =
        'https://wellcome-ec07c-default-rtdb.firebaseio.com/chats/${user!.id}/${contect_model.id}.json?auth=$token';
    await dio.delete(path);
  }

  updateUsersName(String txt) async {
    final path =
        'https://wellcome-ec07c-default-rtdb.firebaseio.com/users/${user!.id}.json?auth=$token';
    await dio.patch(path, data: {'name': txt});
  }
}
