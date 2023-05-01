import 'dart:convert';

import 'package:apicalling/photos.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:http/http.dart' as http;

class DummyJson extends StatefulWidget {
  const DummyJson({Key? key}) : super(key: key);

  @override
  State<DummyJson> createState() => _DummyJsonState();
}

class _DummyJsonState extends State<DummyJson> {
  // Map<String, dynamic>? m;
  Djson? ff;
  List dd = [];
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
        body: (ff == null)
            ? Center(
                child: CircularProgressIndicator(
                backgroundColor: Colors.blueGrey,
              ))
            : ListView.builder(
                itemCount: ff!.products!.length,
                itemBuilder: (context, index) {
                  return Neumorphic(
                    curve: Curves.decelerate,
                    duration: Duration(seconds: 1),
                    margin: EdgeInsets.all(15),
                    padding: EdgeInsets.all(5),
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.concave,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(12)),
                      depth: 8,
                      lightSource: LightSource.topLeft,
                    ),
                    child: ListTile(
                      onTap: () {
                        if (ff!.products![index].images!.length > 1) {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return photos(ff!.products![index].images);
                            },
                          ));
                        }
                      },
                      title: Row(
                        children: [
                          Text(
                            "${ff!.products![index].title}".toUpperCase(),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(Icons.star_border, size: 12),
                          Text("${ff!.products![index].rating}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      subtitle: Row(
                        children: [
                          Text(
                            "${ff!.products![index].category}",
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Icon(Icons.currency_pound, size: 12),
                          Text("${ff!.products![index].price}",
                              style: TextStyle(fontSize: 12)),
                          SizedBox(
                            width: 20,
                          ),
                          Icon(Icons.discount_outlined, size: 12),
                          Text("${ff!.products![index].discountPercentage}%",
                              style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      leading: Container(
                          width: 70,
                          child: Image(
                              image: NetworkImage(
                                  "${ff!.products![index].thumbnail}"))),
                    ),
                  );
                },
              ),
      ),
    );
  }

  Future<void> forGetData() async {
    var url = Uri.parse('https://dummyjson.com/products');
    print('44444444444444444444444444444444');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    Map<String, dynamic> m = jsonDecode(response.body);
    setState(() {
      print("UUUUUUUUUUUUUUUUU");
      ff = Djson.fromJson(m);
      ff!.products!.sort((a, b) {
        return a.price.compareTo(b.price);
      });
    });
  }
}

class Djson {
  List<Products>? products;
  int? total;
  int? skip;
  int? limit;

  Djson({this.products, this.total, this.skip, this.limit});

  Djson.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['skip'] = this.skip;
    data['limit'] = this.limit;
    return data;
  }
}

class Products {
  int? id;
  String? title;
  String? description;
  var price;
  double? discountPercentage;
  var rating;
  int? stock;
  String? brand;
  String? category;
  String? thumbnail;
  List<String>? images;

  Products(
      {this.id,
      this.title,
      this.description,
      this.price,
      this.discountPercentage,
      this.rating,
      this.stock,
      this.brand,
      this.category,
      this.thumbnail,
      this.images});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    discountPercentage = json['discountPercentage'];
    rating = json['rating'];
    stock = json['stock'];
    brand = json['brand'];
    category = json['category'];
    thumbnail = json['thumbnail'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['price'] = this.price;
    data['discountPercentage'] = this.discountPercentage;
    data['rating'] = this.rating;
    data['stock'] = this.stock;
    data['brand'] = this.brand;
    data['category'] = this.category;
    data['thumbnail'] = this.thumbnail;
    data['images'] = this.images;
    return data;
  }
}
