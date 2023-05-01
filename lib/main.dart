import 'dart:convert';

import 'package:apicalling/b3home.dart';
import 'package:apicalling/task.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: b3home(),
  ));
}

class apicalling extends StatefulWidget {
  const apicalling({Key? key}) : super(key: key);

  @override
  State<apicalling> createState() => _apicallingState();
}

class _apicallingState extends State<apicalling> {
  List<Data> TempList = [];
  List<Widget> col = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    forGetApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("GETDATA"))),
      // body: ListView.builder(
      //   itemCount: TempList.length,
      //   itemBuilder: (context, index) {
      //     return ListTile(
      //       title: Text("${TempList[index].title}"),
      //       subtitle: Text("${TempList[index].id}"),
      //     );
      //   },
      // ),
      body: SingleChildScrollView(child: Column(children: columnView())),
    );
  }

  Future<void> forGetApi() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    List list = jsonDecode(response.body);

    for (int i = 0; i < list.length; i++) {
      Data d = Data.fromJson(list[i]);
      setState(() {
        TempList.add(d);
      });
    }
  }

  List<Widget> columnView() {
    for (int i = 0; i < TempList.length; i++) {
      col.add(Text(
        "${TempList[i].id}",
        style: TextStyle(fontSize: 50),
      ));
      print("1111111111111111111111");
    }
    return col;
  }
}

class Data {
  int? userId;
  int? id;
  String? title;
  String? body;

  Data({this.userId, this.id, this.title, this.body});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }
}
