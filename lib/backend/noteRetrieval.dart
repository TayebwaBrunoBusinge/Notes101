import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth firebaseAuthenticatedUser = FirebaseAuth.instance;
CollectionReference authenticatedUserNotesCollection = FirebaseFirestore
    .instance
    .collection('users')
    .doc(firebaseAuthenticatedUser.currentUser!.uid)
    .collection('Notes');

getStoredNotes() async {
  int itemsPerColumn = await authenticatedUserNotesCollection
      .get()
      .then((value) => value.docs.length);
  try {
    print('trying to get stored notes.');

    return FutureBuilder(
        future: authenticatedUserNotesCollection.get(),
        builder: (BuildContext context, AsyncSnapshot notesSnapshot) {
          if (notesSnapshot.connectionState == ConnectionState.active) {
            print('Number of Notes:' + itemsPerColumn.toString());
            return ListView.builder(
                itemCount: itemsPerColumn,
                itemBuilder: (context, index) => ListTile(
                      title: notesSnapshot.data[index]['title'],
                      subtitle: notesSnapshot.data[index]['description'],
                    ));
          } else {
            return const CircularProgressIndicator(
              color: Colors.white,
            );
          }
        });
  } catch (platformException) {
    print(platformException);
  }
}
