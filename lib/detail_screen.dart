import 'package:flutter/material.dart';
import 'package:sample_project/model/tourism_place.dart';

class DetailScreen extends StatelessWidget {
  TourismPlace model;

  DetailScreen({required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Stack(
            children: [
              Hero(
                tag: "gambar",
                child: Image.asset(model.imageAsset),
              ),
              SafeArea(
                child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              )
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Container(
              child: Text(
            model.name,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          )),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Icon(Icons.calendar_today),
                    SizedBox(
                      height: 8,
                    ),
                    Text(model.openDays)
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.watch_later_outlined),
                    SizedBox(
                      height: 8,
                    ),
                    Text(model.openTime)
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.monetization_on_outlined),
                    SizedBox(
                      height: 8,
                    ),
                    Text(model.ticketPrice)
                  ],
                ),
              ],
            ),
          ),
          Container(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                model.description,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
              )),
          Container(
              padding: const EdgeInsets.only(top: 8),
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: model.imageUrls.map((url) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(url),
                    ),
                  );
                }).toList(),
              ))
        ],
      ),
    )));
  }
}
