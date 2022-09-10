import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:howru/helpers/Auth.dart';
import 'package:howru/models/contect.dart';
import 'package:howru/models/user.dart';
import 'package:howru/helpers/nav.dart';
import 'package:howru/providers/apiprovider.dart';
import 'package:howru/screens/chatscreen.dart';
import 'package:howru/screens/contectProfile.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class contect_widget extends StatefulWidget {
 Contect_Model contect_model;
 contect_widget(this.contect_model);

  @override
  State<contect_widget> createState() => _contect_widgetState();
}

class _contect_widgetState extends State<contect_widget> {
  bool isuser  = false;
   bool isinit  = true;
  String msg = "message";
  List<dynamic>? data;
DateTime? dateTime = DateTime.now();
  getlast()async{
final value = await Provider.of<Api_provider>(context,listen: false).lastmsg(widget.contect_model);
 data = value;
      
      isuser = value[2] == Auth_helper.auth_helper.user!.id;
     msg =value==null?"" :isuser?'You: ${value[0]}'  :value[0];
  dateTime = value[1];
  setState(() {
    
  });

  }
  @override
  void didChangeDependencies() {
   if(isinit){
 getlast();
   }
   isinit = false;
    super.didChangeDependencies();
  }
  @override
  void initState() {
  
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   
  print(data);
    return  Container(
     
      padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 10.h),
      child: Row(children: [
   InkWell(
    onTap: () {
     
    },
     child: Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      height: 60.h,
      width: 60.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(100))
      ),
       child: ClipRRect(
        borderRadius: BorderRadius.circular(200),
        child: FadeInImage.assetNetwork(placeholder: 'assets/holder.png',image: widget.contect_model.img!,fit: BoxFit.cover,)),
     ),
   ),
   InkWell(
    onTap: (() {
      Nav.NavigatorKey.currentState!.push(MaterialPageRoute(builder: ((context) {
        return chat_screen(widget.contect_model);
      })));
    }),
     child: Container(
  
      decoration: BoxDecoration(
        
          border:Border(bottom: BorderSide( color: Colors.grey,width: 0.5.w)),
      ),
        height: 60.h,
       width:1.sw-90.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.contect_model.name!,style: TextStyle(fontSize: 20),),
        Row(
      
          children: [
            
         Expanded(child:    Text(msg)),
        if(data!=null)  Text(dateTime!=null?  DateFormat.Hm().format( dateTime!):""),
        if(data!=null) SizedBox(width: 5.w,),
          if(data!=null)  Text(dateTime!=null?  DateFormat.yMMMd().format(dateTime!):"")
        
        ]),
        
      ],
     ),),
   )

      ],)
      
      
      /*ListTile(
    leading: CircleAvatar(backgroundImage: NetworkImage(contect_model.img!),radius: 30.r,),
    title: Text(contect_model.name!,style: TextStyle(),),
    subtitle: Text("heelo mustafa"),


      ) ,*/
      
    );
      
    
  }
}