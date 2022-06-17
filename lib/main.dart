import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';

import 'routes/login.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(Notes101());
}

class Notes101 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes 101',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.white,
      ),
      // ignore: prefer_const_constructors
      home: LoginPage(),
    );
  }
}
