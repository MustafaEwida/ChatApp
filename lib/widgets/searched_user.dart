import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:howru/models/contect.dart';
import 'package:howru/models/user.dart';
import 'package:howru/providers/apiprovider.dart';
import 'package:provider/provider.dart';

class S_user_widget extends StatelessWidget {
 UserMdoel userMdoel;
S_user_widget (this.userMdoel);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h),
     
      child: ListTile(
        
        leading: Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      height: 40.h,
      width: 40.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(100.r))
      ),
       child: ClipRRect(
        borderRadius: BorderRadius.circular(200.r),
        child: Image.network(userMdoel.imgurl!,fit: BoxFit.cover,)),
   ),
   title:  Text(userMdoel.name!,style: TextStyle(fontSize: 14.sp),),
   trailing: SizedBox(width: 1.sw-220.w,child: Row(children: [
    TextButton(onPressed: (() {
      
    }), child: Text("See profile")),
    IconButton(onPressed: (() async{
      try {
          await  Provider.of<Api_provider>(context,listen: false).addcontect(userMdoel);
      } catch (e) {
        
 showDialog(context: context, builder: (ctx){
return AlertDialog(
title: Text("Something Went wrong"),
content: Text("Something Wrong,Try agian later"),
actions:<Widget>[
              FlatButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],

);});
      }
  
    }), icon:Icon( Icons.add))
   ],),),
      
      /*  padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 5.h),
        child: Row(children: [
   Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      height: 50.h,
      width: 50.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(100))
      ),
       child: ClipRRect(
        borderRadius: BorderRadius.circular(200),
        child: Image.network(userMdoel.imgurl!,fit: BoxFit.cover,)),
   ),
   Container(
  
      decoration: BoxDecoration(
        
          
      ),
        height: 60.h,
       width:1.sw-90.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(userMdoel.name!,style: TextStyle(fontSize: 20),),
       
      ],
   ),)

        ],)*/
        
        
        /*ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(contect_model.img!),radius: 30.r,),
      title: Text(contect_model.name!,style: TextStyle(),),
      subtitle: Text("heelo mustafa"),


        ) ,*/
        
      ),
    );
  }
}