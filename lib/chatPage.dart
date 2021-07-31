import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'reusable.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class ChatPage extends StatefulWidget {
  const ChatPage({key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  int receiver_id;
  List<types.Message> _messages = [];
  final _user = const types.User(id: '5',
  );

  Future getTeacherData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
       receiver_id = preferences.getInt('id') ?? 0;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadMessages();
    getTeacherData();
  }

  void _addMessage(types.Message message) async{

    final url = Uri.parse('https://school-node-api.herokuapp.com/api/teacher/$receiver_id');
    final headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };
    final response = await post(url, headers: headers,
        body: message.toJson()
    );
    if (response.statusCode == 200) {
      setState(() {
        _messages.insert(0, message);
      });
    }
    else{
      print(response.reasonPhrase);
    }
  }

  void _handlePreviewDataFetched(
      types.TextMessage message,
      types.PreviewData previewData,
      ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = _messages[index].copyWith(previewData: previewData);

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setState(() {
        _messages[index] = updatedMessage;
      });
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );
    _addMessage(textMessage);
  }

  void _loadMessages() async {
    var response =await http.get(Uri.parse('https://school-node-api.herokuapp.com/api/user'));
    final messages = (jsonDecode(response.body) as List)
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
          onPreviewDataFetched: _handlePreviewDataFetched,
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
