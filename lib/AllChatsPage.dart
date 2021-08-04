import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hello_world1/reusable.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ChatPage.dart';
import 'User.dart';
import 'ChatModel.dart';
import 'main.dart';
import './Message.dart';

class AllChatsPage extends StatefulWidget {
  @override
  _AllChatsPageState createState() => _AllChatsPageState();
}

class _AllChatsPageState extends State<AllChatsPage> {

  String email = "";
  String teacherEmail = '';

  Future getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      email = preferences.getString('email');
      teacherEmail = preferences.getString('teacherEmail');
    });
  }

  @override
  void initState() {
    super.initState();
    ScopedModel.of<ChatModel>(context, rebuildOnChange: false).init();
    getEmail();
  }

  void chatUserClicked(User chatUser) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return ChatPage(chatUser);
        },
      ),
    );
  }

  Widget buildAllChatList() {
    return ScopedModelDescendant<ChatModel>(
      builder: (context, child, model) {
        return FutureBuilder<List<Message>>(
          future: model.getMessages(),
          builder: (BuildContext context, AsyncSnapshot<List<Message>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              if (snapshot.hasError)
                return Center(child: Text(
                    'Error: No teacher to chat. More: ${snapshot.error}'));
              else
                return ListView.builder(
                  itemCount: model.chatUserList.length,
                  itemBuilder: (BuildContext context, int index) {
                    User chatUser = model.chatList[index];
                    return ListTile(
                      title: Text(chatUser.name),
                      onTap: () => chatUserClicked(chatUser),
                    );
                  },
                ); // snapshot.data  :- get your object which is pass from your downloadData() function
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (email != null) {
      return Scaffold(
          appBar: AppBar(title: Text('المشرفين'),
            backgroundColor: AppTheme.textColor),
          body: buildAllList());
    } else {
      return WillPopScope(
          onWillPop: () => SystemNavigator.pop(),
          child: Scaffold(
              appBar: AppBar(title: Text('المحادثات'),
                  backgroundColor: AppTheme.textColor,
                  actions: [
                    _addNewConversation()
                  ]),
              body:
              buildAllChatList()));
    }
  }

  Widget _addNewConversation() {
      return Container(
          padding: EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppTheme.textColor,
          ),
          child: MyMaterialButton());
  }

  Widget buildAllList() {
    return ScopedModelDescendant<ChatModel>(
      builder: (context, child, model) {
        return FutureBuilder<List<User>>(
          future: model.getChatUserList(),
          builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              if (snapshot.hasError)
                return Center(child: Text(
                    'Error: No teacher to chat. More: ${snapshot.error}'));
              else
                return ListView.builder(
                  itemCount: model.chatUserList.length,
                  itemBuilder: (BuildContext context, int index) {
                    User chatUser = model.chatUserList[index];
                    return ListTile(
                      title: Text(chatUser.name),
                      onTap: () => chatUserClicked(chatUser),
                    );
                  },
                ); // snapshot.data  :- get your object which is pass from your downloadData() function
            }
          },
        );
      },
    );
  }
}

