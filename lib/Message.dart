class Message{
   String authorId;
   String autherName;
   String createdAt;
   String reciverId;
   String text;
   String id;
   String receiverName;

  Message(
      this.text,  this.authorId,this.id, this.createdAt, this.autherName,
      this.reciverId, this.receiverName,
      );

  Message.fromJson(Map<String, dynamic> json):
    text= json['text'],
    authorId  = json['authorId'].toString(),
    createdAt=json['createdAt'].toString(),
    id=json['id'].toString(),
    autherName=json['autherName'],
    reciverId=json['reciverId'].toString(),
   receiverName = json['firstName']??'';

   Map<String, dynamic> toJson() => {
    'text': text,
    'authorId': authorId,
    'createdAt': createdAt,
    'id': id,
    'firstName': receiverName,
    'reciverId': reciverId,
     'autherName': autherName,
  };
}