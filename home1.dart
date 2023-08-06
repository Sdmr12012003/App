// import 'package:flutter/material.dart';
// import 'package:login/services/auth.dart';

// class Home1 extends StatefulWidget {
//   const Home1({super.key});

//   @override
//   State<Home1> createState() => _HomeState();
// }

// class _HomeState extends State<Home1> {
//   final AuthService _auth = AuthService();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.brown[50],
//       appBar: AppBar(
//         title: Text('Brew Crew'),
//         backgroundColor: Colors.brown[400],
//         elevation: 0.0,
//         actions: <Widget>[
//           TextButton.icon(
//               onPressed: () async {
//                 await _auth.signOut();
//               },
//               icon: Icon(Icons.person),
//               label: Text('Logout')),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:login/pages/home.dart';
import 'package:login/pages/show.dart';
import 'package:login/pages/delete.dart';

void main() => runApp(MaterialApp(
      initialRoute: '/home',
      routes: {
        '/home': ((context) => Home()),
        '/show': (context) => Show(),
      },
    ));
