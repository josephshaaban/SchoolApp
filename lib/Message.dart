import 'dart:convert';

class Message{
   String authorId;
   String authorName;
   String createdAt;
   String reciverId;
   String text;
   String id;
   String receiverName;

  Message({this.text, this.authorId, this.id, this.createdAt, this.authorName,
      this.reciverId, this.receiverName}
      );

  // Message.fromJson(Map<String, dynamic> json):
  //   text= json['text'],
  //   authorId  = json['authorId'].toString(),
  //   createdAt=json['createdAt'].toString(),
  //   id=json['id'].toString(),
  //   authorName = json['authorName'],
  //   reciverId=json['reciverId'].toString(),
  //  receiverName = json['firstName']??'';

   Map<String, dynamic> toJson() => {
     'authorId': authorId,
     'firstName': receiverName,
     'createdAt': createdAt,
     'reciverId': reciverId,
     'text': text,
     'id': id,
     'authorName': authorName,
  };

   factory Message.fromJson(Map<String, dynamic> jsonData) {
     return Message(
         text: jsonData['text'],
         authorId: jsonData['authorId'].toString(),
         id: jsonData['id'].toString(),
         createdAt: jsonData['createdAt'].toString(),
         authorName: jsonData['authorName'],
         reciverId: jsonData['reciverId'].toString(),
         receiverName: jsonData['firstName']??''
     );
   }

   static Map<String, dynamic> toMap(Message msg) => {
     'authorId': msg.authorId,
     'firstName': msg.receiverName,
     'createdAt': msg.createdAt,
     'reciverId': msg.reciverId,
     'text': msg.text,
     'id': msg.id,
     'authorName':msg.authorName,
   };

   static String encode(List<Message> messages) => json.encode(
     messages
         .map<Map<String, dynamic>>((msg) => Message.toMap(msg))
         .toList(),
   );

   static List<Message> decode(String messages) =>
       (json.decode(messages) as List<dynamic>)
           .map<Message>((item) => Message.fromJson(item))
           .toList();
}