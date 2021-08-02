import 'package:flutter/material.dart';
import 'package:hello_world1/reusable.dart';
import 'package:scoped_model/scoped_model.dart';
import 'User.dart';
import 'Message.dart';
import 'ChatModel.dart';
import 'main.dart';

class ChatPage extends StatefulWidget {
  final User friend;
  ChatPage(this.friend);
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController textEditingController = TextEditingController();

  Widget buildSingleMessage(Message message) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: double.infinity,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF5F8E99),
        borderRadius: BorderRadius.circular(10.0),
      ),
      alignment: message.authorId == widget.friend.id
          ? Alignment.centerLeft
          : Alignment.centerRight,
      // padding: EdgeInsets.only(top: 10.0, left: 5.0, right: 5),
      margin: EdgeInsets.only(top: 10.0, left: 5.0, right: 5),
      child: Padding(
          padding: EdgeInsets.only(left: 5, right: 5),
          child: Text(message.text,
              softWrap: true,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
    );
  }

  Widget buildChatList() {
    return ScopedModelDescendant<ChatModel>(
      builder: (context, child, model) {
        List<Message> messages = model.getMessagesForReceiver(widget.friend);
        return ListView.builder(
          shrinkWrap: true,
          // physics: ClampingScrollPhysics(),
          itemCount: messages.length,
          itemBuilder: (BuildContext context, int index) {
            return buildSingleMessage(messages[index]);
          },
        );
      },
    );
  }

  Widget buildChatArea() {
    return ScopedModelDescendant<ChatModel>(
      builder: (context, child, model) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.0),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 3), blurRadius: 5, color: Colors.grey)
              ]),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10, bottom: 5),
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  autocorrect: true,
                  autofocus: true,
                  cursorColor: AppTheme.textColor,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  textAlignVertical: TextAlignVertical.bottom,
                  controller: textEditingController,
                ),
              ),
              SizedBox(width: 10.0),
              FloatingActionButton(
                backgroundColor: AppTheme.textColor,
                onPressed: () {
                  String messageText = textEditingController.text.trim();
                  if (messageText == '' || messageText == null) {
                  } else {
                    model.sendMessage(messageText, widget.friend);
                    textEditingController.text = '';
                  }
                },
                elevation: 0,
                child: Icon(Icons.send),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableWidgets.getAppBar(widget.friend.name),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        // shrinkWrap: true,
        // physics: ClampingScrollPhysics(),
        children: <Widget>[
          Expanded(child: buildChatList()),
          buildChatArea(),
        ],
      ),
    );
  }
}
