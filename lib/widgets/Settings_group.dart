import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:howru/widgets/settings_item.dart';

class Settings_Group extends StatelessWidget {
  Settings_Group({required this.title, required this.settingsItems});
  String title;
List<Settings_Item> settingsItems;
  @override
  Widget build(BuildContext context) {
    return Container(
      
     
      
      padding: EdgeInsets.all(10.sp),
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      Padding(
        padding: EdgeInsets.only(bottom: 10.h,left: 10.h),
        child: Text(title,style: TextStyle(fontSize: 20.sp,color: Theme.of(context).primaryColor,fontWeight: FontWeight.w500),),
      ),
    Container(
      color: Color.fromARGB(26, 164, 162, 162),
      child:  ListView.separated(
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: settingsItems.length,
              itemBuilder: (BuildContext context, int index) {
                return settingsItems[index];
              },
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: ScrollPhysics(),
            ),)



        ],
      ),
      
    );
  }
}