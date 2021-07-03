import 'package:flutter/material.dart';
import 'package:sample_project/model/tourism_place.dart';
import 'detail_screen.dart';

void main() => runApp(MasterApp());

class MasterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My First Demo",
      theme: ThemeData(primarySwatch: Colors.green),
      home: ListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text("Wisata Bandung"),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            final TourismPlace place = tourismPlaceList[index];
            return InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return DetailScreen(
                      model: place,
                    );
                  }));
                },
                child: PlaceItemCard(
                  imageAssetUrl: place.imageAsset,
                  placeDescription: place.location,
                  placeName: place.name,
                ));
          },
          itemCount: tourismPlaceList.length,
        ));
  }
}

class PlaceItemCard extends StatelessWidget {
  String imageAssetUrl;
  String placeName;
  String placeDescription;

  PlaceItemCard(
      {required this.imageAssetUrl,
      required this.placeName,
      required this.placeDescription});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Hero(tag: "gambar", child: Image.asset(imageAssetUrl)),
            ),
            Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        placeName,
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(placeDescription)
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
