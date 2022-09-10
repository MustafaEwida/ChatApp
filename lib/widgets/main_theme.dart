import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Main_Theme {
  static ThemeData main_theme= ThemeData(
primaryColor: Color.fromARGB(255, 118, 124, 181),
//Color.fromARGB(255, 93, 92, 92)
//backgroundColor:Color.fromARGB(255, 78, 77, 77),
accentColor:Color.fromARGB(255, 64, 50, 108),
appBarTheme:const AppBarTheme(
  backgroundColor:  Color.fromARGB(255, 118, 124, 181),
  textTheme: TextTheme(headline6: TextStyle(color:Color.fromARGB(255, 118, 124, 181),fontSize: 20 )) 
),

elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(
  
  shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                        primary:Color.fromARGB(255, 118, 124, 181) ,
          onPrimary: Colors.white ,
               padding: EdgeInsets.all(20.sp),
               minimumSize: Size(0, 0),
               elevation: 8,),

),

textButtonTheme: TextButtonThemeData(style:TextButton.styleFrom(
primary: Color.fromARGB(255, 118, 124, 181)


) ),


bottomNavigationBarTheme: const BottomNavigationBarThemeData(
  elevation: 20,
  type: BottomNavigationBarType.fixed,
  unselectedItemColor: Colors.amber,
 selectedLabelStyle:TextStyle(color:Colors.amber,fontSize: 15 ) ,
  unselectedLabelStyle: TextStyle(color:Colors.amber,fontSize: 15 )

)

,textTheme: const TextTheme(
  titleSmall: TextStyle(color: Colors.amber,fontSize: 20),
 

 
   
/*
MaterialColor( 
    0xff767CB5, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch. 
    const <int, Color>{ 
      50: const Color(0xffebe978 ),//10% 
      100: const Color(0xffedec87),//20% 
      200: const Color(0xfff0ee96),//30% 
      300: const Color(0xff89392b),//40% 
      400: const Color(0xff733024),//50% 
      500: const Color(0xff5c261d),//60% 
      600: const Color(0xff451c16),//70% 
      700: const Color(0xff2e130e),//80% 
      800: const Color(0xff170907),//90% 
      900: const Color(0xff000000),//100% 
    }, 
  )*/







  ));
  
}