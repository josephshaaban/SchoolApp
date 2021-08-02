class Message{
   String authorId;
   String firstName;
   String createdAt;
   String reciverId;
   String text;
   String id;

  Message(this.text,this.authorId,this.id,this.createdAt,this.firstName,this.reciverId);

  Message.fromJson(Map<String, dynamic> json):
    text= json['text'],
    authorId  = json['authorId'],
    createdAt=json[''],
    id=json['id'],
    firstName=json['firstName'],
    reciverId=json['reciverId'];

   Map<String, dynamic> toJson() => {
    'text': text,
    'authorId': authorId,
    'createdAt': createdAt,
    'id': id,
    'firstName': firstName,
    'reciverId': reciverId
  };
}