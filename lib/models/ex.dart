class MyEx implements Exception {
String msg;
MyEx(this.msg);

@override
  String toString() {
   
    return msg;
  }

  
}