

enum Gender{
male,
female

}

class UserMdoel {
/*

  String get gen{
if(gender==Gender.female){
return "female";
}else{
return 'male';
}


  }*/
 
  String? id;
  //int? phone;
  String? name;//
  String? email;//
 String? password;//
 String? imgurl;
 // DateTime? birth;
 // String? gender;


UserMdoel({/*required this.phone*/ this.password,/*required this.birth*/
required this.email,required this.imgurl ,/*required this.gender*/ this.id,
required this.name});
  
}