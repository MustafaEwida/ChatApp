import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:howru/models/user.dart';
import 'package:howru/providers/apiprovider.dart';
import 'package:howru/screens/contectProfile.dart';
import 'package:howru/widgets/Sec_searched_widget.dart';
import 'package:provider/provider.dart';

class search extends SearchDelegate {
 Widget custemtext(UserMdoel userMdoel ,BuildContext context,/*Function() handler*/){


return InkWell(
 //onTap: handler, 
child: Container(
margin: EdgeInsets.all( 5.w),
padding: EdgeInsets.all( 5.w),


child:  Container(
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
   trailing: 
    
    ElevatedButton(
     style:ElevatedButton.styleFrom(
  
  shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                        primary: Theme.of(context).primaryColor,
          onPrimary: Colors.white ,
               padding: EdgeInsets.all(10.sp),
               minimumSize: Size(0, 0),
               elevation: 8,),
      child: Text("Add Contect"),
      onPressed: (() async{
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
  
    }), )
  
      
  
        
      ),
    )


/* Row(
children: [Text(userMdoel.name!), IconButton(onPressed: (() async{
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
  
    }), icon:Icon( Icons.add))],

),*/
),

  
);

 }
  @override
  List<Widget>? buildActions(BuildContext context) {
return  [
IconButton(onPressed: (() {
  query = "";
}), icon: Icon(Icons.cancel))


  ];
  
  }

  @override
  Widget? buildLeading(BuildContext context) {
  IconButton(onPressed: (() {
   close(context, null);
  }), icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    final contect = Provider.of<Api_provider>(context).users.firstWhere((element) => element.name==query);
   /*Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
     return Contect_profile(contect);
   })));*/
  return Text("");
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    
     final provider = Provider.of<Api_provider>(context);
       List<UserMdoel> filltred = Provider.of<Api_provider>(context).users.where((element) => element.name!.startsWith(query)).toList();
       List<String> filltrednames = filltred.map((e) {
         return e.name!;
       },).toList();
List<String> results = filltrednames.where((e) {
  return e.startsWith(query);
},).toList();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
children: [
if(query=="")
Padding(
  padding:  EdgeInsets.all(14.sp),
  child:   Text("Recent Users"),
),
Container(
height: 300.h,
child: ListView.builder(
  
  itemCount: query==""? provider.resentusers.length:results.length,
  itemBuilder: (context,index){
return  query==""? 

Sec_sesrched_widget(provider.resentusers[index])

:
Sec_sesrched_widget(filltred[index]);



  }),


)


],


  );
  }

  
}