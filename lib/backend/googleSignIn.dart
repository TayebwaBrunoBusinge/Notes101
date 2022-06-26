import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes101/routes/homepage.dart';

GoogleSignIn googleSignIn = GoogleSignIn();
FirebaseAuth firebaseAuth = FirebaseAuth.instance;
CollectionReference usersCollection =
    FirebaseFirestore.instance.collection('users');

Future<bool> signInWithGoogle(BuildContext context) async {
  try {
    final GoogleSignInAccount? signedInGoogleAccount =
        await googleSignIn.signIn();

    if (signedInGoogleAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await signedInGoogleAccount.authentication;

      final AuthCredential googleCredentials = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      final UserCredential firebaseSignInResult =
          await firebaseAuth.signInWithCredential(googleCredentials);

      final User? signedInUser = firebaseSignInResult.user;

      var signedInUsersData = {
        'name': signedInGoogleAccount.displayName,
        'photo': signedInGoogleAccount.photoUrl,
        'email': signedInGoogleAccount.email,
      };

      await usersCollection
          .doc(signedInUser!.uid)
          .get()
          .then((usersDocumentSnapshot) async {
        if (usersDocumentSnapshot.exists) {
          await usersDocumentSnapshot.reference.update(signedInUsersData);

          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const Homepage(),
          ));
        } else {
          await usersCollection.doc(signedInUser.uid).set(signedInUsersData);

          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const Homepage(),
          ));
        }
      });
    }
  } catch (platformException) {
    print('Sign in not successful!');
    print(platformException);
  }

  return true;
}
