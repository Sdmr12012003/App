import 'package:flutter/material.dart';
import 'package:login/authenticate/authenticate.dart';
import 'package:login/home/home1.dart';
import 'package:login/models/user.dart';
import 'package:login/pages/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserId?>(context);
    print(user);

    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
