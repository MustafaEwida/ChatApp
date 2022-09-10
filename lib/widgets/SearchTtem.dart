import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../providers/apiprovider.dart';
import 'Sec_searched_widget.dart';

class SearchItem extends StatelessWidget {
 AppBar appbar;
 SearchItem(this.appbar);
Widget CustemTitle(BuildContext context,String title){
  return  Container(
      
      padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
      decoration: BoxDecoration(
        
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(20.r)
      ),
      child: Text(title,style: TextStyle(color: Colors.white  ,fontSize: 20.sp),));
}
  @override
  Widget build(BuildContext context) {
    return 
        Container(
         padding: EdgeInsets.all(20.h),
          child: ListView(
 children: [
 Container(
  height: 250.h,
   child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
children: [
   CustemTitle(context, "Resent Users"),
     
      Container(
        height: 200.h,
        child: ListView.builder(
                
                  itemCount:Provider.of<Api_provider>(context,listen: false).resentusers.length ,
                  itemBuilder: ((context, index) {
                    return Sec_sesrched_widget(Provider.of<Api_provider>(context,listen: false).resentusers[index]);
                  })),
      ),
     
],
   ),
 ),
 Container(
  height: 1.sh-33.h- appbar.preferredSize.height,
   child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
children: [CustemTitle(context,"All users"),
     
      Container(
        height: 300.h,
        child: ListView.builder(
                
                  itemCount:Provider.of<Api_provider>(context,listen: false).users.length ,
                  itemBuilder: ((context, index) {
                    return Sec_sesrched_widget(Provider.of<Api_provider>(context,listen: false).users[index]);
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
      
    
  }
}