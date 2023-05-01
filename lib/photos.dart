import 'package:apicalling/DummyJson.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class photos extends StatefulWidget {
  photos(List<String>? this.images);

  List<String>? images;

  @override
  State<photos> createState() => _photosState();
}

class _photosState extends State<photos> {
  List<Widget> photo = [];
  List<String> title = [];
  String? ph;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    List<String>? photos = widget.images;
    // for (int i = 0; i < photos!.length; i++) {
    //   photo.add(Image(image: NetworkImage("${photos[i]}")));
    //   title.add("$i");
    // }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return DummyJson();
                },
              ));
            },
            child: Icon(Icons.home),
          ),
          body: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Expanded(
                flex: 1,
                child: CarouselSlider(
                  options: CarouselOptions(
                    animateToClosest: true,
                    pageSnapping: true,
                    height: 500.0,
                    autoPlay: true,
                    autoPlayAnimationDuration: Duration(seconds: 1),
                  ),
                  items: widget.images!.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              ph = i;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            child: PhotoView(
                                imageProvider:
                                    NetworkImage("$i")), //Image.network("$i")
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Expanded(
                flex: 3,
                child: ph == null
                    ? CircularProgressIndicator()
                    : Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.transparent,
                        ),
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.fromLTRB(20, 0, 20, 80),
                        child: PhotoView(
                          enableRotation: true,
                          backgroundDecoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          imageProvider: NetworkImage(ph!),
                        )),
              )
            ],
          )
          // CoverFlow(
          //   images: photo,
          //   titles: title,
          //   displayOnlyCenterTitle: true,
          //   textStyle: TextStyle(color: Colors.red),
          //   onCenterItemSelected: (index) {
          //     print('Selected Item\'s index: $index');
          //   },
          //   // shadowOpacity: 0.3,
          //   // shadowOffset: Offset(1, 10),
          // ),
          ),
    );
  }
}
