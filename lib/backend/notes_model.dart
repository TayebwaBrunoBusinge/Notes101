import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  String? title;
  String? description;
  String? dateCreated;

  Note({
    this.title,
    this.description,
    this.dateCreated,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      title: json['title'].toString(),
      description: json['description'].toString(),
      dateCreated: json['dateCreated'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'dateCreated': dateCreated
    };
  }

  factory Note.fromSnapshot(DocumentSnapshot snapshot) {
    final note = Note.fromJson(snapshot.data() as Map<String, dynamic>);
    return note;
  }
}
