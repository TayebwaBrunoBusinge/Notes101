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
    //Changed saveNote.
    await usersNotesCollection.add(note.toJson()).then((value) async {
      await usersNotesCollection
          .doc(value.id)
          .set({'id': value.id}, SetOptions(merge: true));
    });
  }

  void updateNote(Note note) async {
    try {
      print('trying to update note.');
      print('Note id is:' + note.id.toString());
      await usersNotesCollection
          .where('noteId' == note.id.toString())
          .get()
          .then((value) {
        for (var element in value.docs) {
          print('id is ' + element.reference.id);
          usersNotesCollection
              .doc(element.reference.id)
              .set(note.toJson(), SetOptions(merge: true));
        }
      });
    } on PlatformException catch (e) {
      print('Error while saving note.' + e.toString());
    }
  }

  void deleteNote(Note note) async {
    await usersNotesCollection.doc(note.id).delete();
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
