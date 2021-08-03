import 'package:flutter/material.dart';
import 'package:hello_world1/reusable.dart';
import 'package:scoped_model/scoped_model.dart';
import 'ChatPage.dart';
import 'User.dart';
import 'ChatModel.dart';

class TeachersList extends StatefulWidget {
  @override
  _TeachersListState createState() => _TeachersListState();
}

class _TeachersListState extends State<TeachersList> {

  @override
  void initState() {
    super.initState();
    ScopedModel.of<ChatModel>(context, rebuildOnChange: false).init();
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
        return FutureBuilder<List<User>>(
          future: model.getChatUserList(),
          builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              if (snapshot.hasError)
                return Center(child: Text('Error: No teacher to chat. More: ${snapshot.error}'));
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
                );  // snapshot.data  :- get your object which is pass from your downloadData() function
            }
          },
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableWidgets.getAppBar('المشرفين'),
      body: buildAllChatList(),
    );
  }
}