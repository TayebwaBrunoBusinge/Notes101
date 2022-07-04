import 'package:cloud_firestore/cloud_firestore.dart';

//Remove id if shit f***s up.
class Note {
  String? title;
  String? description;
  String? dateCreated;
  String? id;

  Note({
    this.title,
    this.description,
    this.dateCreated,
    this.id,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      title: json['title'].toString(),
      description: json['description'].toString(),
      dateCreated: json['dateCreated'].toString(),
      id: json['id'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'dateCreated': dateCreated,
      'id': id,
    };
  }

  factory Note.fromSnapshot(DocumentSnapshot snapshot) {
    final note = Note.fromJson(snapshot.data() as Map<String, dynamic>);
    return note;
  }
}
