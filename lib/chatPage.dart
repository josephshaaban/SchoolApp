import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:web_socket_channel/io.dart';
import 'reusable.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  IOWebSocketChannel channel; //channel varaible for websocket
  bool connected; // boolean value to track connection status

  String myid = "0"; //my id
  // swap myid and recieverid value on another mobile to test send and recieve

  List<types.Message> _messages = [];
  final _user = const types.User(
      id: '1',
      imageUrl: "assets/images/account.png",
      firstName: "UserName"
  );

  @override
  void initState() {
    connected= false;
    super.initState();
    _loadMessages();
    channelconnect();
  }

  channelconnect(){ //function to connect
    try{
      channel = IOWebSocketChannel.connect("https://school-node-chat.herokuapp.com/$myid"); //channel IP : Port
      channel.stream.listen((message) {
        print(message);
        setState(() {
          if(message == "connected"){
            connected = true;
            setState(() { });
            print("Connection establised.");
          }else if(message == "send:success"){
            print("Message send success");
            setState(() {

            });
          }else if(message == "send:error"){
            print("Message send error");
          }else if (message.substring(0, 6) == "{'cmd'") {
            print("Message data");
            message = message.replaceAll(RegExp("'"), '"');
            _addMessage(message);
            setState(() { //update UI after adding data to message model

            });
          }
        });
      },
        onDone: () {
          //if WebSocket is disconnected
          print("Web socket is closed");
          setState(() {
            connected = false;
          });
        },
        onError: (error) {
          print(error.toString());
        },);
    }catch (_){
      print("error on connecting to websocket.");
    }
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSendPressed(types.PartialText message) {
    if (connected= true) {
      final textMessage = types.TextMessage(
        author: _user,
        createdAt: DateTime
            .now()
            .millisecondsSinceEpoch,
        id: myid,
        text: message.text,
      );
      _addMessage(textMessage);
      channel.sink.add(textMessage); //send message to reciever channel
    }
    else{
      channelconnect();
      print("Websocket is not connected.");
    }
    }


  void _loadMessages() async {
    final response = await rootBundle.loadString('assets/messages.json');
    final messages = (jsonDecode(response) as List)
        .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
        .toList();

    setState(() {
      _messages = messages;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ReusableWidgets.getAppBar("تواصل مع المشرف"),
        body: Chat(
          theme: const DefaultChatTheme(
              inputBackgroundColor: const Color(0xFF003746),
              primaryColor: const Color(0xFF003746),
              secondaryColor: Colors.blueGrey
          ),
          messages: _messages,
          usePreviewData: true,
          onSendPressed: _handleSendPressed,
          user: _user,
          showUserAvatars: true,
          showUserNames: true,
        ));
  }
}

void choiceAction(String value, BuildContext context) async {
  if (value == "1") {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => ChatPage()));
  }
}

//Future<Widget> _showButton() async{
//SharedPreferences preferences = await SharedPreferences.getInstance();
//var email = preferences.getString('email');
//if (email=="admin@gmail.com"){

//}
//else {
//return FloatingActionButton(
//  backgroundColor: Colors.deepOrange[800],
// child: Icon(Icons.add_shopping_cart),
//onPressed: null);
//}
//}
