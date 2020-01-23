import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home_page.dart';

enum Decision { hit, stand, double, split, none }
enum HandType { pairs, softHands, allHands }

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Must use app in portrait mode
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blackjack Trainer',
      home: StartPage(),
      routes: <String, WidgetBuilder>{
        // '/home_screen': (BuildContext context) => MyHome(),
        // '/error_screen': (BuildContext context) => ErrorScreen(),
      },
    );
  }
}

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HandType hand;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            color: Colors.white,
            child: Text('Soft Hands'),
            onPressed: () {
              hand = HandType.softHands;
              // Navigator.of(context).pushNamed('/home_screen');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => MyHome(hand),
                ),
              );
            },
          ),
          FlatButton(
            color: Colors.white,
            child: Text('Pairs'),
            onPressed: () {
              hand = HandType.pairs;
              // Navigator.of(context).pushNamed('/home_screen');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => MyHome(hand),
                ),
              );
            },
          ),
          FlatButton(
            color: Colors.white,
            child: Text('All Hands'),
            onPressed: () {
              hand = HandType.allHands;
              // Navigator.of(context).pushNamed('/home_screen');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => MyHome(hand),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
