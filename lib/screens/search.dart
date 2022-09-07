import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:howru/providers/apiprovider.dart';
import 'package:howru/widgets/Sec_searched_widget.dart';
import 'package:howru/widgets/maindrewer.dart';
import 'package:howru/widgets/search.dart';
import 'package:howru/widgets/searched_user.dart';
import 'package:provider/provider.dart';

class Search_screen extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
  
    final appbar =AppBar(

actions: [
  IconButton(onPressed: (() {
    showSearch(context: context, delegate: search());
  }), icon:Icon(Icons.search))
],

    );
    return Scaffold
  (
    drawer: main_drwer(),
appBar: appbar,
body:FutureBuilder(
      future: Provider.of<Api_provider>(context,listen: false).Allusers(),
     
      builder: ( context, AsyncSnapshot snapshot) {
       
        return snapshot.connectionState==ConnectionState.waiting?Center(child: CircularProgressIndicator(),) : Container(
         padding: EdgeInsets.all(10.h),
          child: ListView(
 children: [
 Container(
  height: 250.h,
   child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
children: [
    Text("Resent Users",style: TextStyle(fontSize: 20.sp),),
     
      Container(
        height: 200.h,
        child: ListView.builder(
                
                  itemCount:Provider.of<Api_provider>(context).resentusers.length ,
                  itemBuilder: ((context, index) {
                    return Sec_sesrched_widget(Provider.of<Api_provider>(context).resentusers[index]);
                  })),
      ),
     
],
   ),
 ),
 Container(
  height: 1.sh-33.h- appbar.preferredSize.height,
   child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
children: [
    Text("All Users",style: TextStyle(fontSize: 20.sp)),
     
      Container(
        height: 300.h,
        child: ListView.builder(
                
                  itemCount:Provider.of<Api_provider>(context).users.length ,
                  itemBuilder: ((context, index) {
                    return Sec_sesrched_widget(Provider.of<Api_provider>(context).users[index]);
                  })),
      ),
     
],
   ),
 )




 ],


          ),
        );
        
        
        /* ListView.builder(
        
          itemCount:Provider.of<Api_provider>(context).users.length ,
          itemBuilder: ((context, index) {
            return S_user_widget(Provider.of<Api_provider>(context).users[index]);
          })) ;*/
      },
    )
   ,

    );
}}