import 'dart:convert';
import 'dart:core';
import 'package:flutter/services.dart';
import 'main.dart';
import 'package:flutter/cupertino.dart';
import 'myGridView.dart';
import 'reusable.dart';
import 'data.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:after_layout/after_layout.dart';
import 'package:http/http.dart' as http;

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> with AfterLayoutMixin<NewsScreen>{
  List<Ads> _ads = <Ads>[];

  Future<List<Ads>> fetchData() async{
    var response =await http.get(Uri.parse('https://school-node-api.herokuapp.com/api/ads'));
    var ads= <Ads>[];

    if (response.body != null ){
      var dataJson= json.decode(response.body);
      for (var dataJson in dataJson){
        ads.add(Ads.fromJson(dataJson));
      }
    }
    return ads;
  }

  String email= '';
  String sName = '';
  int school_Id ;
  int student_id;
  int classId;

  Future getStudentData() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      email = preferences.getString ('email');
      sName= preferences.getString('sName');
      school_Id = preferences.getInt('school_Id')??0;
      student_id=  preferences.getInt('student_id')??0;
      classId=  preferences.getInt('classId')??0;
    });
  }

  @override
  void initState(){
    fetchData().then((value) {
      setState(() {
        _ads.addAll(value);
      });
    });
    super.initState();
    getStudentData();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return new WillPopScope(
        onWillPop: () =>  SystemNavigator.pop(),
        child: Material(
            child: Container(
                width: size.width, height: size.height,
                child: SingleChildScrollView(
                  child: Column(
                      children:<Widget>[
                        Container(
                            height: size.height/2.4,
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(bottom: 10.0),
                            padding: EdgeInsets.only(left: 30.0),
                            decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10)),
                                color: AppTheme.textColor),
                            child:FittedBox(
                                child: Row(
                                    children: <Widget>[
                                      Center(),
                                      Column(
                                          children: <Widget>[
                                            Container(
                                                height: 170.0,
                                                width: 170.0,
                                                margin: EdgeInsets.only(left: 103.0, top: 28.0, right: 102.0),
                                                decoration: BoxDecoration(
                                                    color: AppTheme.backgroundColor.withOpacity(1.0),
                                                    shape: BoxShape.circle),
                                                child: Image.asset("assets/images/flutter_lo.png", width: 100, height: 115, scale: 1.7)),
                                            Container(
                                                alignment: Alignment.center,
                                                color: AppTheme.textColor,
                                                child: Column(
                                                    children: <Widget>[
                                                      Text(sName , style: TextStyle(
                                                          fontSize: 30,fontWeight: FontWeight.w900,
                                                          color: AppTheme.backgroundColor.withOpacity(1.0))),
                                                      Text(email??'', textAlign: TextAlign.center, style: TextStyle(
                                                          fontSize: 30,fontWeight: FontWeight.w900,
                                                          color: AppTheme.backgroundColor.withOpacity(1.0)))]))]),
                                      Container(
                                          margin: EdgeInsets.only(bottom:size.height/3),
                                          decoration: new BoxDecoration(color: AppTheme.textColor),
                                          padding: EdgeInsets.all(5),
                                          child: MyMaterialButton()
                                      )]))),
                        Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                color: AppTheme.textColor.withOpacity(0.3215686274509804)),
                            margin: const EdgeInsets.symmetric(horizontal:25.0),
                            padding: EdgeInsets.only(left: 16.0, top: 12.0, right: 16.0, bottom: 1.0),
                            height: size.height-size.height/2.4 ,
                            child: MyGridView()
                        )]),
                ))));
  }

  @override
  void afterFirstLayout(BuildContext context) {
    showAlertDialog();
    fetchData();
  }
  Future showAlertDialog() async{
      return showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          content: FutureBuilder(
            future: fetchData() ,
            builder: (context, snapshot1) {
              if (snapshot1.hasData) {
                return ListView.builder(itemBuilder: (context,index) {
                  Ads ad = snapshot1.data[index];
                  Ads ad1 = snapshot1.data[1];
                    return Column(
                        children: [
                          Card(
                              color: Colors.white60,
                              child: Column(
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(bottom: 15)),
                                    Text(ad.adsText),
                                    Image.network(ad1.adsImg)
                                  ])),
                        ]);
                  },
                  itemCount: snapshot1.data.length,
                );
              }
              else{
                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              }
            },
          ),
          actions: <Widget>[
            MaterialButton(
              child: new Text('إغلاق',textDirection: TextDirection.rtl,style:
              TextStyle(color: AppTheme.textColor,fontWeight: FontWeight.bold)),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
      );
    }
}