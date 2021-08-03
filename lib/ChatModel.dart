import "package:scoped_model/scoped_model.dart";
import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import './User.dart';
import './Message.dart';

class ChatModel extends Model {
  final key = 'saved_messageList';
  User currentUser;
  List<User> chatUserList = <User>[];
  List<Message> messages = <Message>[];
  List<User> chatList = <User>[];
  Set chatIdsSet = Set();

   void init() {
     notifyListeners();
   }

   // todo: in case everythings works correctly, REMOVE IT!
   User getUserFromListById(List<User> users, userId){
     final index = users.indexWhere((e) => e.id == userId);
     return users[index];
   }

   // todo: in case everythings works correctly, REMOVE IT!
   List<Message> convertToMessageType(List<dynamic> msgList) {
     var resMessages = msgList.map(
             (e) => e as Map<String, dynamic>).toList();
     List<Message> finalMessages = <Message>[];
     for (var resMessage in resMessages){
       if (!resMessage.containsKey("reciverId"))
         resMessage["reciverId"] = currentUser.id.toString();
       if (!resMessage.containsKey("firstName"))
         resMessage["firstName"] = currentUser.name;

       Message newMessage = Message(
           text: resMessage["text"],
           authorId: resMessage["authorId"].toString(),
           id: Uuid().v4(),
           createdAt: resMessage["createdAt"].toString(),
           authorName: resMessage["authorName"],
           reciverId: resMessage["reciverId"],
           receiverName: resMessage["firstName"]);
       finalMessages.add(newMessage);
     }
     return finalMessages;
   }

  Future<List<Message>> getMessages() async {
    initCurrentUser();
    final receiverId = currentUser.id;
    final receiveMessageURL = Uri.parse(
        'https://school-node-api.herokuapp.com/api/reciveMess/$receiverId/');

    final sharedMessages = await SharedPreferences.getInstance();
    String savedMessagesStr = sharedMessages.getString(key)??"";
    var response = await http.get(receiveMessageURL);

    if (response.statusCode == 200) {
      final List<Message> messageList = Message.decode(response.body);
      final List<Message> savedMessages = savedMessagesStr != "" ?
                            Message.decode(savedMessagesStr) : <Message>[];

      setChatList(savedMessages + messageList);
      this.messages = savedMessages + messageList;
      return savedMessages + messageList;
    } else {
      print(response.reasonPhrase);
      return <Message>[];
    }
  }

   Future<List<Message>> updateSavedMessages(List<Message> loadedMessages) async{
    final sharedMessages = await SharedPreferences.getInstance();

    // converts local messages from list of string to list of types.Messages
    String savedMessagesStr = sharedMessages.getString(key)??"";
    final List<Message> savedMessages = Message.decode(savedMessagesStr);

    final String encodedData = Message.encode(savedMessages + loadedMessages);

    // save all messages
    // take care if there is any savedMessages and add the new messages to them.
    await sharedMessages.setString(key, encodedData);

    return savedMessages + loadedMessages;
  }

   void setChatList(List<Message> loadedMessages) {
    for (var message in loadedMessages){
      if (message.authorId == currentUser.id)
        continue;
      if (chatIdsSet.add(message.authorId)) {
        this.chatList.add(
            User(message.authorName, message.authorId));
      }
    }
  }

  Future<List<User>> getChatUserList() async {
    // todo: add message getter to set chatList
    final allowedChatUsersURL = Uri.parse(
        'https://school-node-api.herokuapp.com/api/teacher/1/');

    var response = await http.get(allowedChatUsersURL);
    var userList = <User>[];

    if (response.statusCode == 200) {
      var dataJson = json.decode(response.body);
      for (var dataJson in dataJson) {
        userList.add(User.fromJson(dataJson));
      }
    } else {
      print(response.reasonPhrase);
    }
    this.chatUserList = userList;
    return userList;
  }

  void initCurrentUser() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var userId = preferences.getString('user_id')??0;
    var email = preferences.getString('email');
    this.currentUser = User(email, userId.toString());
  }

  void sendMessage(String text, User receiver) async{
    final sendMessageURL =  Uri.parse('https://school-node-api.herokuapp.com/api/sendMess/');
    final messageId = const Uuid().v4();
    final textMessage = Message(
        text: text,
        authorId: currentUser.id,
        id: messageId,
        createdAt: DateTime.now().toString(),
        authorName: currentUser.name,
        reciverId: receiver.id,
        receiverName: receiver.name
    );
    
    final headers = {
      'Content-Type': 'application/json',
      'charset': "UTF-8",
    };
    var request = http.Request('POST', sendMessageURL);
    var jsonTextMessage =  textMessage.toJson();
    request.body = jsonEncode(jsonTextMessage);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(response.statusCode);
    if (response.statusCode==200){
      messages.add(textMessage);
      await updateSavedMessages(messages);
    } else {
      print(response.reasonPhrase);
    }
    notifyListeners();
  }

  List<Message> getMessagesForReceiver(User chatUser) {
    return messages
        .where((msg) => (
        msg.authorId == currentUser.id || msg.authorId == chatUser.id
    )).toList();
  }
}
