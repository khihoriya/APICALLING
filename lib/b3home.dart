import 'dart:convert';

import 'package:apicalling/b1update.dart';
import 'package:apicalling/b3add.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:http/http.dart' as http;

class b3home extends StatefulWidget {
  const b3home({Key? key}) : super(key: key);

  @override
  State<b3home> createState() => _b3homeState();
}

class _b3homeState extends State<b3home> {
  List<b3homeee> temp = [];
  b3homeee? dd;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    forGetData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Row(children: [
                IconButton(
                    onPressed: () {
                      setState(() {});
                    },
                    icon: Icon(Icons.menu)),
                SizedBox(
                  width: 120,
                ),
                Text("TASK B3")
              ]),
              centerTitle: true,
              backgroundColor: Color(0xFF00425A),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return b3add();
                  },
                ));
              },
              child: Icon(Icons.add),
            ),
            body: (dd == null)
                ? Center(
                    child: CircularProgressIndicator(
                    backgroundColor: Colors.blueGrey,
                  ))
                : ListView.builder(
                    // itemCount:
                    //     Issearch ? Search.length : ff!.categoryList!.length,
                    itemCount: dd!.addressList!.length,
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
                                        Text("${dd!.addressList![index].name}"),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Mobile :"),
                                        Text(
                                            "${dd!.addressList![index].mobile}"),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Address Type :"),
                                        Text(
                                            "${dd!.addressList![index].addressType}"),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("GPS Address :"),
                                        Text(
                                            "${dd!.addressList![index].gpsAddress}"),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Address Id :"),
                                        Text(
                                            "${dd!.addressList![index].addressId}"),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Address Created :"),
                                        Text(
                                            "${dd!.addressList![index].created}"),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Address Latitude :"),
                                        Text(
                                            "${dd!.addressList![index].latitude}"),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Address Longitude :"),
                                        Text(
                                            "${dd!.addressList![index].longitude}"),
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
                                                dd!.addressList![index]
                                                    .addressId,
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
    var url = Uri.parse('http://workfordemo.in/bunch3/get_address.php');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    Map<String, dynamic> mm = jsonDecode(response.body);

    setState(() {
      dd = b3homeee.fromJson(mm);
    });
  }
}

class b3homeee {
  int? success;
  List<AddressList>? addressList;

  b3homeee({this.success, this.addressList});

  b3homeee.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['address_list'] != null) {
      addressList = <AddressList>[];
      json['address_list'].forEach((v) {
        addressList!.add(new AddressList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.addressList != null) {
      data['address_list'] = this.addressList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AddressList {
  String? addressId;
  String? addressType;
  String? gpsAddress;
  String? latitude;
  String? longitude;
  String? mobile;
  String? name;
  String? created;

  AddressList(
      {this.addressId,
      this.addressType,
      this.gpsAddress,
      this.latitude,
      this.longitude,
      this.mobile,
      this.name,
      this.created});

  AddressList.fromJson(Map<String, dynamic> json) {
    addressId = json['address_id'];
    addressType = json['address_type'];
    gpsAddress = json['gps_address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    mobile = json['mobile'];
    name = json['name'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_id'] = this.addressId;
    data['address_type'] = this.addressType;
    data['gps_address'] = this.gpsAddress;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['mobile'] = this.mobile;
    data['name'] = this.name;
    data['created'] = this.created;
    return data;
  }
}
