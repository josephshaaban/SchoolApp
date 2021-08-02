import "package:scoped_model/scoped_model.dart";
import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import './User.dart';
import './Message.dart';

class ChatModel extends Model {
   User currentUser = User("Me", "0");
   List<User> friendList = <User>[];
   List<Message> messages = <Message>[];

  Future<List<Message>> getMessages() async {
    final receiverId = currentUser.id;
    final receiveMessageURL = Uri.parse('https://school-node-api.herokuapp.com/api/reciveMess/$receiverId/');

    var response = await http.get(receiveMessageURL);

    var messages = <Message>[];
    if (response.statusCode == 200) {
      var dataJson = json.decode(response.body);
      for (var data in dataJson) {
        messages.add(Message.fromJson(data));
      }
    } else {
      print(response.reasonPhrase);
    }

    return messages;
  }

  void initMessages() async {
    this.messages = await getMessages();
  }

  Future<List<User>> getFriendList() async {
    final allowedChatUsersURL = Uri.parse('https://school-node-api.herokuapp.com/api/teacher/1/');

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
    this.friendList = userList;
    initCurrentUser();
    initMessages();
    return userList;
  }

  void initFriendList() async {
    this.friendList = await getFriendList();
  }

  void initCurrentUser() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var userId = preferences.getInt('user_id')??0;
    this.currentUser = User('Me', userId.toString());
  }

  void init() {
    this.friendList = <User>[];
    this.messages = <Message>[];
    this.currentUser = User('Me', "0");

    notifyListeners();
  }

  void sendMessage(String text, User receiver) async{
    final sendMessageURL =  Uri.parse('https://school-node-api.herokuapp.com/api/sendMess/');
    final meesageId = const Uuid().v4();
    final textMessage = Message(text, currentUser.id, meesageId, DateTime.now().toString(), currentUser.name, receiver.id);
    
    final headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', sendMessageURL);
    request.body = jsonEncode(textMessage.toJson());
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(response.statusCode);
    if (response.statusCode==200){
      messages.add(textMessage);
    } else {
      print(response.reasonPhrase);
    }
    notifyListeners();
  }

  //_onReceiveMessage(dynamic jsonData)async{
    //var messagesData = await getMessages();
   // this.messages = this.messages + messagesData;
  //  notifyListeners();
  //}

  List<Message> getMessagesForReceiver(User receiver) {
    return messages
        .where(
          (msg) => (msg.authorId == currentUser.id && msg.reciverId == receiver.id)
          || msg.reciverId == currentUser.id && msg.authorId == receiver.id)
        .toList();
  }
}