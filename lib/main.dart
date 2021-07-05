import 'package:flutter/foundation.dart' show kIsWeb;
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
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // If less than 600
          if (constraints.maxWidth <= 600) {
            return PlaceList();
          }
          // if less than 1200
          else if (constraints.maxWidth <= 1200) {
            return PlaceGridList(columnCount: 4);
          }
          // if more than 1200
          else {
            return PlaceGridList(columnCount: 6);
          }
        },
      ),
    );
  }
}

class PlaceList extends StatelessWidget {
  const PlaceList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final TourismPlace place = tourismPlaceList[index];
        return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return DetailScreen(
                      model: place,
                    );
                  },
                ),
              );
            },
            child: PlaceItemCard(
              imageAssetUrl: place.imageAsset,
              placeDescription: place.location,
              placeName: place.name,
            ));
      },
      itemCount: tourismPlaceList.length,
    );
  }
}

class PlaceGridList extends StatelessWidget {
  int columnCount;

  PlaceGridList({required this.columnCount});

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      isAlwaysShown: true,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
            crossAxisCount: columnCount,
            children: tourismPlaceList.map((place) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return DetailScreen(
                          model: place,
                        );
                      },
                    ),
                  );
                },
                child: PlaceItemGridCard(
                    imageAssetUrl: place.imageAsset,
                    placeName: place.name,
                    placeDescription: place.location),
              );
            }).toList()),
      ),
    );
  }
}

class PlaceItemGridCard extends StatelessWidget {
  String imageAssetUrl;
  String placeName;
  String placeDescription;

  PlaceItemGridCard(
      {required this.imageAssetUrl,
      required this.placeName,
      required this.placeDescription});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shadowColor: Colors.grey,
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Image(
              fit: BoxFit.cover,
              image: AssetImage(
                  kIsWeb ? imageAssetUrl : "assets/" + imageAssetUrl),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Text(
                placeName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              )),
          Padding(
              padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
              child: Text(
                placeDescription,
                style: TextStyle(fontSize: 11),
              )),
        ],
      ),
    );
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
              child: Hero(
                  tag: "gambar",
                  child: Image(
                    image: AssetImage(
                        //  On web version the assets are stored in "assets/" folder already.
                        kIsWeb ? imageAssetUrl : "assets/" + imageAssetUrl),
                  )),
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
