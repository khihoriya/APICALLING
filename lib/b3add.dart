import 'package:apicalling/b3home.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class b3add extends StatefulWidget {
  const b3add({Key? key}) : super(key: key);

  @override
  State<b3add> createState() => _b3addState();
}

class _b3addState extends State<b3add> {
  final List<String> items = [
    'Surat',
    'Bharuch',
    'Vapi',
    'Ahemadabad',
    'Ankleshwar',
    'Banglore',
    'Pune',
    'Mahuva',
    'Bhavnagar',
    'Botad',
    'Navsari',
    'Nadiyad',
    'Anand',
  ];
  String? selectedValue;
  TextEditingController gps = TextEditingController();
  TextEditingController lati = TextEditingController();
  TextEditingController longi = TextEditingController();
  TextEditingController textEditingController = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController Name = TextEditingController();
  // String type = "Veg";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(50, 10, 50, 10),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                isExpanded: true,
                hint: Text(
                  'SELECT CITY',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                items: items
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                    .toList(),
                value: selectedValue,
                onChanged: (value) {
                  setState(() {
                    selectedValue = value as String;
                    print(
                        "fffffffffffffffffffffffffffffffffffffffff$selectedValue");
                  });
                },
                buttonHeight: 40,
                buttonWidth: 200,
                itemHeight: 40,
                dropdownMaxHeight: 200,
                searchController: textEditingController,
                searchInnerWidget: Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                    bottom: 4,
                    right: 8,
                    left: 8,
                  ),
                  child: TextFormField(
                    controller: textEditingController,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      hintText: 'Search for an item...',
                      hintStyle: const TextStyle(fontSize: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                searchMatchFn: (item, searchValue) {
                  return (item.value
                      .toString()
                      .toLowerCase()
                      .contains(searchValue.toLowerCase()));
                },
                //This to clear the search value when you close the menu
                onMenuStateChange: (isOpen) {
                  if (!isOpen) {
                    textEditingController.clear();
                  }
                },
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(50, 10, 50, 0),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(50, 10, 50, 10),
            child: TextField(
              decoration: InputDecoration(hintText: "Enter Description "),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(50, 10, 50, 10),
            child: TextField(
              decoration: InputDecoration(hintText: "Enter Qty "),
            ),
          ),
          Container(
              margin: EdgeInsets.fromLTRB(50, 10, 50, 10),
              child: ElevatedButton(
                  onPressed: () async {
                    var url = Uri.parse('');
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
                        return b3home();
                      },
                    ));
                  },
                  child: Text("SAVE")))
        ],
      )),
    );
  }
}
