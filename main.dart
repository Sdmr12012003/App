import 'package:flutter/material.dart';
import 'package:login/models/user.dart';
import 'package:login/pages/charts.dart';
import 'package:login/pages/home.dart';
import 'package:login/pages/show.dart';
import 'package:login/services/auth.dart';
import 'package:login/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserId?>.value(
      value: AuthService().user,
      catchError: (_, __) =>
          null, // Handle errors and return null for initialData
      initialData: null,
      child: MaterialApp(
        home: Wrapper(),
        routes: {
          '/chart': (context) => Charts(),
          '/home': ((context) => Home()),
          '/show': (context) => Show(),
        },
      ),
    );
  }
}
