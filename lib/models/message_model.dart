class MessageModel{
  String ?title,senderId,recieverId,msgId;
  DateTime ?time;


  MessageModel({this.title,this.recieverId,this.senderId,this.time,this.msgId});
  static MessageModel fromJson(Map<String,dynamic> map){
    MessageModel message = MessageModel(
      time: map["time"].toDate(),
      senderId: map["senderId"],
      recieverId: map["recieverId"],
      title: map["title"],
      msgId:map["msgId"]
    );
    return message;
  }

  Map<String,dynamic> toJson(){
    Map<String,dynamic> json = {
      "time":time,
      "title":title,
      "recieverId": recieverId,
      "senderId":senderId,
      "msgId":msgId
    };
    return json;
  }
}