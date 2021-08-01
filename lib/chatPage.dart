import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'reusable.dart';
import 'package:uuid/uuid.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  int receiver_id;
  String imageUrl;
  String firstName;
  int userId;
  List<types.Message> _messages = [];
  types.User _user;

  Future getStudentData() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getInt('user_id')??0;
    receiver_id = preferences.getInt('id') ?? 0;
    imageUrl= preferences.getString('image_Url')??'';
    firstName= preferences.getString('firstName')??'';
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    _loadMessages();
    getStudentData();
  }

  void _addMessage(types.Message message) async{

    final url = Uri.parse(
        'https://school-node-api.herokuapp.com/api/teacher/$receiver_id');
    final headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };

    var messageData = jsonDecode(message.toJson().toString());
    var requestBody = {
      "authorId": message.author.id,
      "firstName": message.author.firstName,
      "createdAt": message.createdAt,
      "receiverId": receiver_id,
      "text": messageData['text'],
      "id": message.id,
    };

    final response = await post(url, headers: headers,
        body: requestBody
    );
    if (response.statusCode == 200) {
      setState(() {
        _messages.insert(0, message);
      });
      final sharedMessages = await SharedPreferences.getInstance();
      final key = 'saved_messages';
      var savedMessages = sharedMessages.getStringList(key);
      final messages = _messages.map((e) =>
          types.Message.fromJson(
              e as Map<String, dynamic>).toString()).toList();

      // take care if there is any savedMessages and add the new messages to them.
      sharedMessages.setStringList(key, savedMessages + messages);
      print(messages);
    }
    else {
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
      author: types.User(
        id: userId.toString(),
        imageUrl: imageUrl,
        firstName: firstName,
      ),
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    _addMessage(textMessage);
  }

  types.TextMessage mapResponseToMessageType(final serverMessage) {
    var text = serverMessage['text'];
    var createdAt = DateTime.parse(serverMessage['createdAt'])
        .microsecondsSinceEpoch;
    final author = types.User(id: serverMessage['authorId']);

    final chatUIMessage = types.TextMessage(
      author: author,
      createdAt: createdAt,
      id: const Uuid().v4(),
      text: text,
    );

    return chatUIMessage;
  }

  void _loadMessages() async {
    var response =await http.get(Uri.parse('https://jsonkeeper.com/b/W1VU'));

    var responseData = (jsonDecode(response.body) as List<Message>)
        .map((e) => mapResponseToMessageType as types.Message)
        .toList();

  //  final messages = responseData
    //    .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
      //  .toList();

    final sharedMessages = await SharedPreferences.getInstance();
    final key = 'saved_messages';

    List<types.Message> savedMessages = sharedMessages
        .getStringList(key)
        .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
        .toList();

    setState(() {
      _messages = savedMessages + responseData;
      //  _messages = messages as List<types.Message>;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ReusableWidgets.getAppBar("تواصل مع المشرف"),
        //body:RefreshIndicator(
          //  onRefresh: _loadMessages,
           body: Chat(
          theme: const DefaultChatTheme(
              inputBackgroundColor: const Color(0xFF003746),
              primaryColor: const Color(0xFF003746),
              secondaryColor: Colors.blueGrey
          ),
          messages:_messages,
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

