import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/model/tourism_place.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class DetailScreen extends StatelessWidget {
  TourismPlace model;

  DetailScreen({required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              if (constraints.maxWidth >= 800) {
                return DetailPageWeb(model: model);
              }
              return DetailPageMobile(model: model);
            },
          ),
        ),
      ),
    );
  }
}

class DetailPageWeb extends StatefulWidget {
  TourismPlace model;

  DetailPageWeb({required this.model});

  @override
  _DetailPageWebState createState() => _DetailPageWebState();
}

class _DetailPageWebState extends State<DetailPageWeb> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 16),
      child: Center(
        child: Container(
          width: 1200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Wisata Bandung".toUpperCase(),
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          clipBehavior: Clip.antiAlias,
                          child: Image(
                            image: AssetImage(kIsWeb
                                ? widget.model.imageAsset
                                : "assets/" + widget.model.imageAsset),
                          ),
                        ),
                        Container(
                          height: 150,
                          child: Scrollbar(
                            controller: _scrollController,
                            isAlwaysShown: true,
                            child: ListView(
                                controller: _scrollController,
                                padding: const EdgeInsets.only(bottom: 16),
                                scrollDirection: Axis.horizontal,
                                children: widget.model.imageUrls.map((url) {
                                  return Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 8, 8, 0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(url),
                                    ),
                                  );
                                }).toList()),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                      flex: 1,
                      child: Card(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                widget.model.name.toUpperCase(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 24),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.calendar_today,
                                      color: Colors.black),
                                  Text(widget.model.openDays),
                                  Spacer(),
                                  FavoriteButton(),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  Icon(Icons.watch_later_outlined),
                                  Text(widget.model.openTime),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  Icon(Icons.monochrome_photos_outlined),
                                  Text(widget.model.ticketPrice),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(widget.model.description)
                            ],
                          ),
                        ),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class DetailPageMobile extends StatelessWidget {
  TourismPlace model;

  DetailPageMobile({required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Stack(
          children: [
            Hero(
                tag: "gambar",
                child: Image(
                  image: AssetImage(
                      // This checks if runs on web or else. If runs on web, the "assets/" are added autmatically
                      kIsWeb ? model.imageAsset : "assets/" + model.imageAsset),
                )),
            // Back Button
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: IconButton(
                          color: Colors.white,
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    ),
                    FavoriteButton()
                  ],
                ),
              ),
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
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Icon(Icons.calendar_today),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      model.openDays,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Icon(Icons.watch_later_outlined),
                    SizedBox(
                      height: 8,
                    ),
                    Text(model.openTime)
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Icon(Icons.monetization_on_outlined),
                    SizedBox(
                      height: 8,
                    ),
                    Text(model.ticketPrice)
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
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
    );
  }
}

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({Key? key}) : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          isFavorite = !isFavorite;
        });
      },
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
      ),
    );
  }
}
