class Message{
   String authorId;
   String firstName;
   String createdAt;
   String reciverId;
   String text;
   String id;
   String receiverName;

  Message(
      this.text,  this.authorId,this.id, this.createdAt, this.firstName,
      this.reciverId, this.receiverName,
      );

  Message.fromJson(Map<String, dynamic> json):
    text= json['text'],
    authorId  = json['authorId'].toString(),
    createdAt=json['createdAt'].toString(),
    id=json['id'].toString(),
    firstName=json['firstName'],
    reciverId=json['reciverId'].toString(),
   receiverName = json['receiverName']??'';

   Map<String, dynamic> toJson() => {
    'text': text,
    'authorId': authorId,
    'createdAt': createdAt,
    'id': id,
    'firstName': firstName,
    'reciverId': reciverId
  };
}