import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import 'notes_model.dart';

class NoteDao {
  final CollectionReference usersNotesCollection = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('notes');

  void saveNote(Note note) async {
    await usersNotesCollection.add(note.toJson());
  }

  void updateNote(Note note) async {
    try {
      await usersNotesCollection
          .where('title' == note.title.toString())
          .get()
          .then((value) {
        for (var element in value.docs) {
          usersNotesCollection.doc(element.reference.id).set(note.toJson());
        }
      });
    } on PlatformException catch (e) {
      print('Error while saving note.' + e.toString());
    }
  }

  Future<List<Note>> getNotesList() async {
    List<Note> notesList = [];

    await usersNotesCollection.get().then((value) {
      for (var element in value.docs) {
        notesList.add(Note.fromJson(element.data() as Map<String, dynamic>));
      }
    });
    return notesList;
  }
}
