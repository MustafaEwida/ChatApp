import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:howru/models/contect.dart';
import 'package:howru/models/msgmodel.dart';
import 'package:howru/providers/apiprovider.dart';
import 'package:provider/provider.dart';

import '../helpers/Auth.dart';
import 'msg.dart';

class Messages extends StatelessWidget {
  Stream<Response> getRandomNumberFact(BuildContext context) async* {
    yield* Stream.periodic(Duration(milliseconds: 1), (_) {
      final user = Auth_helper.auth_helper.user;
      final token = Auth_helper.auth_helper.Token;
      final res =Dio().get(
          'https://wellcome-ec07c-default-rtdb.firebaseio.com/chats/${user!.id}/${contect_model.id}.json?auth=$token');
          // Provider.of<Api_provider>(context ,listen: false).lastmsgInList=null;
      return res;
    }).asyncMap((event) async => await event);
  }

  Contect_Model contect_model;
  Messages(this.contect_model);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Response>(
        stream: getRandomNumberFact(context),
        builder: (context, AsyncSnapshot<Response<dynamic>> snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
          //  Provider.of<Api_provider>(context ,listen: false).lastmsgInList=null;
          }
          

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text("Enjoy with freinds"),
            );
          }
          List<Msg_model> maga = [];
          List<Msg_model> b = [];
          Map<String, dynamic> msgs = {};
          if (snapshot.data!.data != null) {
            msgs = snapshot.data!.data as Map<String, dynamic>;
          }

          msgs.forEach((key, value) {
            maga.add(Msg_model(
                value["user_id"], value["msg"], DateTime.parse(value["date"])));
          });
          b = maga.reversed.toList();

          return Consumer<Api_provider>(builder: ((context, value, child) {
            return !snapshot.hasData
                ? Center(
                    child: Text("Say hi"),
                  )
                : Center(
                    child: ListView(
                       reverse: true,
                      children: [
                        if (Provider.of<Api_provider>(context, listen: false)
                                  .lastmsgInList !=
                              null)
                            MessageBubble(message: Provider.of<Api_provider>(
                                      context,
                                      listen: false)
                                  .lastmsgInList!,islast: true),
                         
   ...b.map((element) {
     return b.length == 0
                                      ? Text("hh")
                                      : MessageBubble(message: element,);
   }).toList(),
 




                      ],
                      /* Column(
                        children: [
                          Container(
                            height:
                                Provider.of<Api_provider>(context, listen: false)
                                            .lastmsgInList !=
                                        null
                                    ? 512.h
                                    : 554.h,
                            child: ListView.builder(
                                reverse: true,
                                itemCount: b.length,
                                itemBuilder: (ctx, index) {
                                  return b.length == 0
                                      ? Text("hh")
                                      : MessageBubble(b[index]);
                                }),
                          ),
                          if (Provider.of<Api_provider>(context, listen: false)
                                  .lastmsgInList !=
                              null)
                            Container(
                              height: 40.h,
                              child: MessageBubble(Provider.of<Api_provider>(
                                      context,
                                      listen: false)
                                  .lastmsgInList!),
                            )
                        ],
                      ),*/
                  
                    ));
          }));
        }); /*FutureBuilder(
      future: Provider.of<Api_provider>(context , listen: false).getmsgs(contect_model) ,
      builder: (ctx, AsyncSnapshot<List<Msg_model>> futureSnapshot) {
        List<Msg_model> x = [];
          List<Msg_model> b = [];
        
        if( futureSnapshot.data!= null){
          x =   futureSnapshot.data! ;
    b=   x.reversed.toList();
        }
  
    
             return ListView.builder(
                reverse: true,
                itemCount: b.length,
                itemBuilder: (ctx, index) => MessageBubble(
                 b[index]
                ),
              );
           
            
      },
    );*/
  }
}
