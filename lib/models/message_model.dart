class MessageModel{
String senderId;
String receiverId;
String dateTime;
String text;

MessageModel({this.senderId, this.receiverId, this.dateTime, this.text});

MessageModel.fromJason(Map<String,dynamic>json){
  dateTime=json['dateTime'];
  receiverId=json['receiverId'];
  senderId=json['senderId'];
  text=json['text'];
}

Map<String,dynamic>toMap(){
  return{
    'senderId':senderId,
    'receiverId':receiverId,
    'dateTime':dateTime,
    'text':text,

  };
}

}