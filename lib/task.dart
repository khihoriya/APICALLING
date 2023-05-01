import 'dart:convert';

import 'package:apicalling/b1add.dart';
import 'package:apicalling/b1update.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:http/http.dart' as http;

class task extends StatefulWidget {
  const task({Key? key}) : super(key: key);

  @override
  State<task> createState() => _taskState();
}

class _taskState extends State<task> {
  List Search = [];
  bool Issearch = false;
  var ll = [];

  @override
  void initState() {
    // TODO: implement initState

    forGetData();
  }

  taskkk? ff;
  taskkk? dd;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: //Issearch
                  // ? TextField(
                  //     onChanged: (value) {
                  //       setState(() {
                  //         if (value.isNotEmpty) {
                  //           Search = [];
                  //           for (int i = 0; i < ff!.categoryList!.length; i++) {
                  //             if (ff!.categoryList![i].catName
                  //                 .toString()
                  //                 .toLowerCase()
                  //                 .contains(value.toLowerCase())) {
                  //               Search.add(ff!.categoryList);
                  //               dd!.categoryList!.add(ff!.categoryList![i]);
                  //             }
                  //           }
                  //         } else {
                  //           Search = ff!.categoryList!;
                  //         }
                  //       });
                  //     },
                  //   )
                  //:
                  Row(children: [
                IconButton(
                    onPressed: () {
                      setState(() {});
                    },
                    icon: Icon(Icons.menu)),
                SizedBox(
                  width: 120,
                ),
                Text("TASK B1")
              ]),
              centerTitle: true,
              backgroundColor: Color(0xFF00425A),
              // actions: [
              //   Issearch
              //       ? IconButton(
              //           onPressed: () {
              //             setState(() {
              //               // Search = ff!.categoryList!;
              //               Issearch = false;
              //             });
              //           },
              //           icon: Icon(Icons.close))
              //       : IconButton(
              //           onPressed: () {
              //             setState(() {
              //               // Search = ff!.categoryList!;
              //               Issearch = true;
              //             });
              //           },
              //           icon: Icon(Icons.search))
              // ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return b1add();
                  },
                ));
              },
              child: Icon(Icons.add),
            ),
            body: (ff == null)
                ? Center(
                    child: CircularProgressIndicator(
                    backgroundColor: Colors.blueGrey,
                  ))
                : ListView.builder(
                    // itemCount:
                    //     Issearch ? Search.length : ff!.categoryList!.length,
                    itemCount: ff!.categoryList!.length,
                    itemBuilder: (context, index) {
                      // ll = Issearch ? Search[index] : ff!.categoryList!;
                      return Neumorphic(
                        curve: Curves.decelerate,
                        duration: Duration(seconds: 1),
                        margin: EdgeInsets.all(20),
                        padding: EdgeInsets.all(5),
                        style: NeumorphicStyle(
                          shape: NeumorphicShape.concave,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(12)),
                          depth: 8,
                          lightSource: LightSource.topLeft,
                        ),
                        child: Container(
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(10),
                            color: Colors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text("Name :"),
                                        Text(
                                            "${ff!.categoryList![index].catDescription}"),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Description :"),
                                        Text(
                                            "${ff!.categoryList![index].catDescription}"),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Qty :"),
                                        Text(
                                            "${ff!.categoryList![index].catQty}"),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Id :"),
                                        Text(
                                            "${ff!.categoryList![index].catId}"),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Date :"),
                                        Text(
                                            "${ff!.categoryList![index].catCreated}"),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                            builder: (context) {
                                              return b1update(
                                                ff!.categoryList![index].catId,
                                              );
                                            },
                                          ));
                                        },
                                        icon:
                                            Icon(Icons.edit_calendar_outlined)),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.delete_forever_sharp)),
                                  ],
                                ),
                              ],
                            )),
                      );
                    })));
  }

  Future<void> forGetData() async {
    print('Umanggggggggggggg');
    // var url = Uri.parse('http://workfordemo.in/bunch1/get_category.php');
    // var response = await http.get(url);
    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');

    var url = Uri.parse('http://workfordemo.in/bunch1/get_category.php');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    Map<String, dynamic> m = jsonDecode(response.body);
    setState(() {
      print("UUUUUUUUUUUUUUUUU");
      ff = taskkk.fromJson(m);
    });
  }
}

class taskkk {
  int? success;
  List<CategoryList>? categoryList;

  taskkk({this.success, this.categoryList});

  taskkk.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['category_list'] != null) {
      categoryList = <CategoryList>[];
      json['category_list'].forEach((v) {
        categoryList!.add(new CategoryList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.categoryList != null) {
      data['category_list'] =
          this.categoryList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryList {
  String? catId;
  String? catName;
  String? catQty;
  String? catDescription;
  String? catCreated;

  CategoryList(
      {this.catId,
      this.catName,
      this.catQty,
      this.catDescription,
      this.catCreated});

  CategoryList.fromJson(Map<String, dynamic> json) {
    catId = json['cat_id'];
    catName = json['cat_name'];
    catQty = json['cat_qty'];
    catDescription = json['cat_description'];
    catCreated = json['cat_created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cat_id'] = this.catId;
    data['cat_name'] = this.catName;
    data['cat_qty'] = this.catQty;
    data['cat_description'] = this.catDescription;
    data['cat_created'] = this.catCreated;
    return data;
  }
}
