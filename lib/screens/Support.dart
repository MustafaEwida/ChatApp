


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Contact_screen extends StatelessWidget {

final textstyle = TextStyle(

fontSize: 14.sp



);
whatsapp(BuildContext context)async{
    var whatsapp = "+972594764197";
    var whatsappAndroid =Uri.parse("whatsapp://send?phone=$whatsapp&text=hello");
    if (await canLaunchUrl(whatsappAndroid)) {
        await launchUrl(whatsappAndroid);
    } else {
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("WhatsApp is not installed on the device"),
        ),
      );
    }
    
  /*
  final url = Uri.parse('https://wa.me/00972594764197/?text=Hi,I want service');
  await launchUrl(url);*/
}
facebook(BuildContext context)async{
    
    var whatsappAndroid =Uri.parse("https://www.facebook.com/profile.php?id=100016922085955");
    if (await canLaunchUrl(whatsappAndroid)) {
        await launchUrl(whatsappAndroid);
    } else {
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("facebook not installed on the device"),
        ),
      );
    }}
    tele(BuildContext context)async{
   
    var whatsappAndroid =Uri.parse("https://www.t.me/mus_Ewida");
    if (await canLaunchUrl(whatsappAndroid)) {
        await launchUrl(whatsappAndroid,);
    } else {
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Telegram not installed on the device"),
        ),
      );
    }}
     Hotmail(BuildContext context)async{
   
    var whatsappAndroid = Uri(
      scheme: 'mailto',
      path: 'mustafa.20075@hotmail.com',
      queryParameters: {
       
      }
    );
    if (await canLaunchUrl(whatsappAndroid)) {
        await launchUrl(whatsappAndroid,);
    } else {
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Telegram not installed on the device"),
        ),
      );
    }}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Support'),),
      body:ListView(children: [
          Container(
            width: double.infinity,
            height: 1.sh / 3.1,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(children: [
                  Container(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                  ),
                  Container(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight / 1.2,
                    color: Theme.of(context).primaryColor,
                  ),
                  
                   Positioned(
                    top: 30.h,
                   left: 30.w,
                    child:Text("Flutter Dev:\n Mustafa Ewida",style: TextStyle(fontSize: 20.sp,color: Colors.white),))
                  
                  ,
                  
                  Positioned(
                    top: constraints.maxHeight / 1.9,
                    right: constraints.maxWidth / 2 - 55.w,
                    child: CircleAvatar(
                      backgroundImage:
                     AssetImage('assets/me.jpg'),
                      radius: 55.r,
                    ),
                  ),
               
                ]);
              },
            ),
          ),
        Container(
             
        margin: EdgeInsets.symmetric(horizontal: 10.h,vertical: 30.w),
        child: Column(
          
children:  [
  Container(
    padding: EdgeInsets.all(20.sp),
    margin: EdgeInsets.only(bottom: 10.h),
    decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(40.r)
    ),
   

    
    child: FittedBox(child: Text("For More Services Contect Us",style: TextStyle(color: Colors.white,fontSize: 20.sp),)),),
SizedBox(height: 20.h,),ListTile(
  onTap: () {
    Hotmail(context);
  },
  trailing: Icon(Icons.arrow_forward),
  leading: Icon(Icons.email_outlined,color: Colors.amber ,size: 40),title: FittedBox(child: Text('mustafa.20075@hotmail.com',style: textstyle,)),),
ListTile(
  onTap: () {
    facebook(context);
  },
  trailing: Icon(Icons.arrow_forward),
  leading: Icon(Icons.facebook,color: Colors.blue ,size: 40),title: Text('مصطفى عويضه_MustafaEwida',style: textstyle),),
ListTile(
  onTap: (() {
    whatsapp(context);
  }),
  trailing: Icon(Icons.arrow_forward),
  leading: Icon(Icons.whatsapp,color: Colors.green ,size: 40,),title: Text('+972594764197',style: textstyle),),
ListTile(
  onTap: () {
    tele(context);
  },
  trailing: Icon(Icons.arrow_forward),
  leading: Icon(Icons.telegram_outlined ,color: Color.fromARGB(255, 60, 134, 173),size: 40,),title: Text('+972594764197',style: textstyle),),






],



          
        ),
      ),
        
        
        
             
        ])
      
      
      
      
      
      
    );
  }
}