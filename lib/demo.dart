import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class demo extends StatefulWidget {
  const demo({Key? key}) : super(key: key);

  @override
  State<demo> createState() => _demoState();
}

class _demoState extends State<demo> {
  List<DecodeClass> TempList = [];
  List<Widget> col = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    forGetData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("GETDATA"))),
      body: SingleChildScrollView(child: Column(children: columnView())),
    );
  }

  List<Widget> columnView() {
    for (int i = 0; i < TempList.length; i++) {
      col.add(Text(
        "${TempList[i].title}",
        style: TextStyle(fontSize: 20),
      ));
      col.add(Text("---------------"));
      print("1111111111111111111111");
    }
    return col;
  }

  Future<void> forGetData() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/photos');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    List list = jsonDecode(response.body);

    for (int i = 0; i < list.length; i++) {
      DecodeClass dd = DecodeClass.fromJson(list[i]);
      setState(() {
        TempList.add(dd);
      });
    }
  }
}

class DecodeClass {
  int? albumId;
  int? id;
  String? title;
  String? url;
  String? thumbnailUrl;

  DecodeClass({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

  DecodeClass.fromJson(Map<String, dynamic> json) {
    albumId = json['albumId'];
    id = json['id'];
    title = json['title'];
    url = json['url'];
    thumbnailUrl = json['thumbnailUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['albumId'] = this.albumId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['url'] = this.url;
    data['thumbnailUrl'] = this.thumbnailUrl;
    return data;
  }
}
