import 'package:flutter/material.dart';
import 'package:notes101/backend/googleSignIn.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    const double paddingFromEdges = 30;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 100),
          ),
          SizedBox.square(
            dimension: 600,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/Notes Icon.png"),
                ),
              ),
              child: const Text(
                "Create and manage your notes.",
                style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 40,
                    color: Colors.amber),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: paddingFromEdges,
              right: paddingFromEdges,
            ),
            child: TextButton(
              onPressed: () {
                signInWithGoogle(context);
              },
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    const RoundedRectangleBorder(
                      side: BorderSide(style: BorderStyle.solid),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                  ),
                  elevation: MaterialStateProperty.all(100),
                  shadowColor: MaterialStateProperty.all(
                      const Color.fromARGB(1, 255, 255, 255)),
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 128, 203, 196))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Continue with Google      ",
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 20,
                      color: Color.fromARGB(255, 2, 38, 122),
                    ),
                  ),
                  SizedBox.square(
                    dimension: 30,
                    child: Image(
                      image: AssetImage(
                          "assets/images/Google-Icon-PNG_rwscww.png"),
                    ),
                  )
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 50.0),
          ),
        ],
      ),
    );
  }
}
