import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'reusable.dart';
import 'package:uuid/uuid.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<types.Message> _messages = [];
  final _user = const types.User(id: '06c33e8b-e835-4736-80f4-63f44b66666c',
      imageUrl: "assets/images/account.png",
      firstName: "UserName"
  );

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
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
    final response = await rootBundle.loadString('assets/messages.json');
    final messages = (jsonDecode(response) as List)
        .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
        .toList();

    final sharedMessages = await SharedPreferences.getInstance();
    final key = 'saved_messages';

    Map decodeOptions = jsonDecode(response);
    String savedMessages = jsonEncode(types.Message.fromJson(decodeOptions));
    sharedMessages.setString(key, savedMessages);

    // final savedMessages = jsonDecode(response);
    // sharedMessages.setStringList(key, savedMessages);
    print('saved $savedMessages');

    setState(() {
      _messages = messages;
    });
  }

  // void _loadLocallyMessages() async{
  //   SharedPreferences sharedMessages = await SharedPreferences.getInstance();
  //   Map messagesMap = jsonDecode(sharedMessages.getString('saved_messages'));
  //   var messages = types.Message.fromJson(messagesMap);
  //   // var messages = (jsonDecode(response) as List)
  //   //     .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
  //   //     .toList();
  //
  //   setState(() {
  //     _messages = messages;
  //   });
  // }

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
