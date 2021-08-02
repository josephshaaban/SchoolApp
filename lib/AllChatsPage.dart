import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hello_world1/reusable.dart';
import 'package:hello_world1/teachers.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ChatPage.dart';
import 'User.dart';
import 'ChatModel.dart';
import 'main.dart';

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

  void friendClicked(User friend) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return ChatPage(friend);
        },
      ),
    );
  }

  Widget buildAllChatList() {
    return ScopedModelDescendant<ChatModel>(
      builder: (context, child, model) {
        return FutureBuilder<List<User>>(
          future: model.getFriendList(),
          builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              if (snapshot.hasError)
                return Center(child: Text('Error: No teacher to chat. More: ${snapshot.error}'));
              else
                return ListView.builder(
                  itemCount: model.friendList.length,
                  itemBuilder: (BuildContext context, int index) {
                    User friend = model.friendList[index];
                    return ListTile(
                      title: Text(friend.name),
                      onTap: () => friendClicked(friend),
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
  Widget build (BuildContext context) {
    if (email != null) {
      return Scaffold(
          body:  Column( crossAxisAlignment: CrossAxisAlignment.start,
              children:[
          SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SafeArea(
                      child: Padding(
                        padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            _addNewConversation(),
                          ],
                        ),
                      ),
                    ),
                    buildAllChatList(),
                  ]))]));
    } else if (teacherEmail != null) {
      return WillPopScope(
          onWillPop: () => SystemNavigator.pop(),
          child: Scaffold(
              body: Column( crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
               SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SafeArea(
                          child: Padding(
                            padding:
                            EdgeInsets.only(left: 16, right: 16, top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                _addNewConversation(),
                              ],
                            ),
                          ),
                        ) ])),
                        buildAllChatList(),
          ]  )));
    }
  }

  Widget _addNewConversation() {
    if (email != null) {
      return Container(
          padding: EdgeInsets.only(left: 0, right: 5, top: 2, bottom: 2),
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.pink[50],
          ),
          child: MaterialButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TeachersList()));
              },
              child: Row(children: [
                Icon(Icons.add),
                Text("Add New",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textColor))
              ])));
    } else if (teacherEmail != null) {
      return Container(
          padding: EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppTheme.textColor,
          ),
          child: MyMaterialButton());
    }
  }
}
