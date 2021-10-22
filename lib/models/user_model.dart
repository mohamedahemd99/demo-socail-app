class UserModel{
String name;
String phone;
String email;
String uid;
String image;
String cover;
String bio;
bool isEmailVerified;

UserModel({this.name, this.phone, this.email, this.uid,this.isEmailVerified,this.bio,this.cover,this.image});

UserModel.fromJason(Map<String,dynamic>json){
  email=json['email'];
  phone=json['phone'];
  name=json['name'];
  uid=json['uid'];
  image=json['image'];
  cover=json['cover'];
  bio=json['bio'];
  isEmailVerified=json['isEmailVerified'];
}

Map<String,dynamic>toMap(){
  return{
    'name':name,
    'phone':phone,
    'email':email,
    'uid':uid,
    'image':image,
    'cover':cover,
    'bio':bio,
    'isEmailVerified':isEmailVerified,
  };
}

}