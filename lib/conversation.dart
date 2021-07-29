import 'package:flutter/services.dart';
import 'package:hello_world1/chatPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'reusable.dart';
import 'chatPage.dart';
import 'main.dart';
import 'data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'teachers.dart';

class Conversation extends StatefulWidget{
  @override
  _ConversationState createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {

  List<ChatUsers> chatUsers = [
    ChatUsers(name: "Jane Russel",
        messageText: "Awesome Setup",
        image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTBc-AEj_9MJQIUQqlgB0a9Nao0kuhi4ydeyQ&usqp=CAU"
    ),
    ChatUsers(name: "Glady's Murphy",
        messageText: "That's Great",
        image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTBc-AEj_9MJQIUQqlgB0a9Nao0kuhi4ydeyQ&usqp=CAU"
    ),
    ChatUsers(name: "Jorge Henry",
        messageText: "Hey where are you?",
        image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTBc-AEj_9MJQIUQqlgB0a9Nao0kuhi4ydeyQ&usqp=CAU"
    ),
    ChatUsers(name: "Philip Fox",
        messageText: "Busy! Call me in 20 mins",
        image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTBc-AEj_9MJQIUQqlgB0a9Nao0kuhi4ydeyQ&usqp=CAU"
    ),
    ChatUsers(name: "Debra Hawkins",
        messageText: "Thankyou, It's awesome",
        image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTBc-AEj_9MJQIUQqlgB0a9Nao0kuhi4ydeyQ&usqp=CAU"
    ),
    ChatUsers(name: "Jacob Pena",
        messageText: "will update you in evening",
        image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTBc-AEj_9MJQIUQqlgB0a9Nao0kuhi4ydeyQ&usqp=CAU"
    ),
    ChatUsers(name: "Andrey Jones",
        messageText: "Can you please share the file?",
        image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTBc-AEj_9MJQIUQqlgB0a9Nao0kuhi4ydeyQ&usqp=CAU"
    ),
    ChatUsers(name: "John Wick",
        messageText: "How are you?"
    ),
  ];

  String email= "";

  Future getEmail() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      email = preferences.getString ('email');
    });
  }

  @override
  void initState(){
    super.initState();
    getEmail();
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () =>  SystemNavigator.pop(),
        child: Scaffold(
          body: SingleChildScrollView(
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
                        Text("Conversations", style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold,color: AppTheme.textColor)),
                        _addNewConversation(),
                      ],
                    ),
                  ),
                ),
                ListView.builder(
                    itemCount: chatUsers.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 16),
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (chatUsers[index].image==null) {
                        return ConversationList(
                          name: chatUsers[index].name,
                          messageText: chatUsers[index].messageText,
                          imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTBc-AEj_9MJQIUQqlgB0a9Nao0kuhi4ydeyQ&usqp=CAU"
                          ,
                        );
                      }
                      else{
                        return ConversationList(
                            name: chatUsers[index].name,
                            messageText: chatUsers[index].messageText,
                            imageUrl: chatUsers[index].image
                        );
                      }
                    }
                ),
              ],
            ),
          ),
        ));
  }
  Widget _addNewConversation()   {
    if (email !=null) {
      return Container(
          padding: EdgeInsets.only(left: 0, right: 5, top: 2, bottom: 2),
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.pink[50],),
          child: MaterialButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TeachersList()));
              },
              child:Row(children:[
                Icon(Icons.add),
                Text("Add New", style: TextStyle(fontSize: 14,
                    fontWeight: FontWeight.bold, color: AppTheme.textColor))
              ])));
    } else {
      return Container(
          padding: EdgeInsets.only(
              left: 8, right: 8, top: 2, bottom: 2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppTheme.textColor,
          ),
          child: MyMaterialButton()
      );
    }
  }
}

class ConversationList extends StatefulWidget{
  final String name;
  final String messageText;
  final String imageUrl;
  ConversationList({@required this.name,@required this.messageText,@required this.imageUrl});

  @override
  _ConversationListState createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return ChatPage();
        }));
      },
      child: Container(
        padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.imageUrl),
                    backgroundColor: AppTheme.textColor,
                    maxRadius: 30,
                  ),
                  SizedBox(width: 16,),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.name, style: TextStyle(fontSize: 16,color: AppTheme.textColor)),
                          SizedBox(height: 6,),
                          Text(widget.messageText,style: TextStyle(fontSize: 13,color: Colors.grey.shade600, fontWeight:FontWeight.normal)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}