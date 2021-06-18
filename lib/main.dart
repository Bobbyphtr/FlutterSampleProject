import 'package:flutter/material.dart';

void main() => runApp(MasterApp());

class MasterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My First Demo",
      theme: ThemeData(primarySwatch: Colors.yellow),
      home: FirstScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("First Screen"),
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: null,
          ),
          actions: <Widget>[
            IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.search,
                  color: Colors.black,
                ))
          ],
        ),
        body: Column(
          children: [
            Heading("This is my heading"),
            Center(
              child: TextButton(
                child: Text("Hello button"),
                onPressed: () => print("Hello"),
              ),
            ),
            BiggerText("Bigger Me!")
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.all(8),
          child: FloatingActionButton(
            onPressed: () => print("Floating Pressed"),
            child: Icon(
              Icons.add,
              color: Colors.black,
            ),
          ),
        ));
  }
}

// Stateless example
class Heading extends StatelessWidget {
  final String _text;

  Heading(this._text);

  @override
  Widget build(BuildContext context) {
    return Text(
      this._text,
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}

// Stateful Example
class BiggerText extends StatefulWidget {
  final String text;

  BiggerText(this.text);

  @override
  _BiggerTextState createState() => _BiggerTextState();
}

class _BiggerTextState extends State<BiggerText> {
  double _textSize = 32.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          widget.text,
          style: TextStyle(fontSize: _textSize),
        ),
        ElevatedButton(
            onPressed: () => setState(() => _textSize += 8),
            child: Text("Perbesar"))
      ],
    );
  }
}
