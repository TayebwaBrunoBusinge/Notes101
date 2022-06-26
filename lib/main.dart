import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'routes/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  runApp(const Notes101());
}

class Notes101 extends StatelessWidget {
  const Notes101({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes 101',
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.white,
      ),
      // ignore: prefer_const_constructors
      home: LoginPage(),
    );
  }
}
