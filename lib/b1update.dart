import 'package:apicalling/task.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class b1update extends StatefulWidget {
  b1update(
    this.catId,
  );
  String? catId;

  @override
  State<b1update> createState() => _b1updateState();
}

class _b1updateState extends State<b1update> {
  TextEditingController name = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController qty = TextEditingController();
  String type = "Veg";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(50, 10, 50, 10),
            child: TextField(
              decoration: InputDecoration(hintText: "Enter Name "),
              controller: name,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(50, 10, 50, 0),
            child: Row(
              children: [
                Text("Veg"),
                Radio(
                  value: "Veg",
                  groupValue: type,
                  onChanged: (value) {
                    setState(() {
                      type = value!;
                    });
                  },
                ),
                Text("Non-Veg"),
                Radio(
                  value: "Non-Veg",
                  groupValue: type,
                  onChanged: (value) {
                    setState(() {
                      type = value!;
                    });
                  },
                ),
                Text("Egg"),
                Radio(
                  value: "Egg",
                  groupValue: type,
                  onChanged: (value) {
                    setState(() {
                      type = value!;
                    });
                  },
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(50, 10, 50, 10),
            child: TextField(
              decoration: InputDecoration(hintText: "Enter Description "),
              controller: desc,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(50, 10, 50, 10),
            child: TextField(
              decoration: InputDecoration(hintText: "Enter Qty "),
              controller: qty,
            ),
          ),
          Container(
              margin: EdgeInsets.fromLTRB(50, 10, 50, 10),
              child: ElevatedButton(
                  onPressed: () async {
                    String aname = name.text.toString();
                    String adesc = desc.text.toString();
                    String aqty = qty.text.toString();

                    String atype = type;

                    var url = Uri.parse(
                        'http://workfordemo.in/bunch1/update_category.php?cat_id=${widget.catId}&cat_type=$atype&cat_name=$aname&cat_description=$adesc&cat_qty=$aqty');
                    var response = await http.get(url);
                    print('Response status: ${response.statusCode}');
                    print('Response body: ${response.body}');

                    Fluttertoast.showToast(
                        msg: "Record Added SuccessFully",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return task();
                      },
                    ));
                  },
                  child: Text("SAVE")))
        ],
      )),
    );
  }
}
