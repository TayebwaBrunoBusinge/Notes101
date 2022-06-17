import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
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
                    fontWeight: FontWeight.w100,
                    fontSize: 40,
                    color: Colors.amber),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  const RoundedRectangleBorder(
                    side: BorderSide(style: BorderStyle.solid),
                  ),
                ),
                elevation: MaterialStateProperty.all(2),
                shadowColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 36, 116, 253)),
                enableFeedback: true,
                backgroundColor: MaterialStateProperty.all(Colors.black12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Continue with Google",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 20,
                  ),
                ),
                SizedBox.square(
                  dimension: 30,
                  child: Image(
                    image:
                        AssetImage("assets/images/Google-Icon-PNG_rwscww.png"),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
