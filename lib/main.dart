import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home_page.dart';
import 'count_deck.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Container(
            // color: Colors.black,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/start_screen_image.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            constraints:
                BoxConstraints.expand(), //forces container to fill screen
            //without it, screen's only width of the column
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Text(
                  'Blackjack Trainer',
                  style: TextStyle(
                      fontSize: 34, fontFamily: 'Verdana', color: Colors.white),
                ),
                Text(
                  'What kind of hand would you like to practice?',
                  style: TextStyle(
                      fontSize: 18, fontFamily: 'Verdana', color: Colors.white),
                ),
                FlatButton(
                  color: Colors.white,
                  child: Text(
                    'Soft Hands',
                    style: TextStyle(fontSize: 14, fontFamily: 'Verdana'),
                  ),
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
                  child: Text(
                    'Pairs',
                    style: TextStyle(fontSize: 14, fontFamily: 'Verdana'),
                  ),
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
                  child: Text(
                    'All Hands',
                    style: TextStyle(fontSize: 14, fontFamily: 'Verdana'),
                  ),
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
                FlatButton(
                  color: Colors.white,
                  child: Text(
                    'Countdown a Deck',
                    style: TextStyle(fontSize: 14, fontFamily: 'Verdana'),
                  ),
                  onPressed: () {
                    hand = HandType.allHands;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => CountDeck(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
