

import 'package:mingler_app/screens/CardSwipe/SwipeAnimation/index.dart';
import 'package:mingler_app/screens/admob/earn.dart';
import 'package:mingler_app/screens/messenger/messengerpage.dart';
import 'package:mingler_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mingler_app/shared/bottom_navy_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mingler_app/screens/settings/settings.dart';

var UserID ;

final databaseReference = Firestore.instance;
final AuthService _auth = AuthService();
const PrimaryColor = const Color(0xFF151026);
bool FlagLoc = false;

class Main extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'mingler app',
      theme: ThemeData(
        primarySwatch: colorCustom,
      ),
      home: MyHomePage(),
    );
  }
}

var lat ;
var Lng ;

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>  {
  int currentIndex = 0;
 
  int _currentIndex = 1;

 Position _currentPosition;
  final List<Widget> _children = [
    SettingsPage(),
    CardDemo(),
    EarnPage(),
    MessengerPage(),

  ];

  @override
  Widget build(BuildContext context)  {
  //  getDataF();
  //  getData();
    _getCurrentLocation();


    if(_currentPosition != null)
    {

      lat="LAT: ${_currentPosition.latitude}" ;
      Lng= "LNG: ${_currentPosition.longitude}";
    }

    return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
           
//  FlatButton.icon(
//                 padding: const EdgeInsets.only(right: 60.0),
//                  label: Text(''),
//                 icon: Icon(Icons.exit_to_app),
//                 onPressed: ()async {
//                    await _auth.signOut();
//                 },
//              ),

//           ],
            
//         ),
//           actions: <Widget>[
//       ]
//       ),


      body:  _children[_currentIndex],

      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 8,
        onItemSelected: (index) => setState(() {
          _currentIndex = index;
        }),
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
            activeColor: Colors.blue,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            activeColor: Colors.black,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.attach_money),
            title: Text('Earn'),
            activeColor: Colors.red,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.message),
            title: Text('Messages'),
            activeColor: Colors.green,
          ),
        ],
      ),
    );
  }

  _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }
}
Map<int, Color> color =
{
  50:Color.fromRGBO(217,180,111, .1),
  100:Color.fromRGBO(217,180,111, .2),
  200:Color.fromRGBO(217,180,111, .3),
  300:Color.fromRGBO(217,180,111, .4),
  400:Color.fromRGBO(217,180,111, 1),//change .5 na 1 vir die login button fix
  500:Color.fromRGBO(217,180,111, .6),
  600:Color.fromRGBO(217,180,111, .7),
  700:Color.fromRGBO(217,180,111, .8),
  800:Color.fromRGBO(217,180,111, .9),
  900:Color.fromRGBO(217,180,111, 1),
};
//waar die color func assign word
MaterialColor colorCustom = MaterialColor(0xFFd9b46f, color);
//color insert word
const PrimaryColorTwo = const Color(0xFFd9b46f);
 class userId {

userId(var id ){

UserID = id;
}

}