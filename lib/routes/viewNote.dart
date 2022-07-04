import 'package:flutter/material.dart';
import 'package:notes101/routes/homepage.dart';
import '../backend/note_dao.dart';
import '../backend/notes_model.dart';
import '../routes/addNotes.dart';

class ViewNote extends StatefulWidget {
  const ViewNote({Key? key, required this.note})
      : super(key: key); //Changed here.

  final Note note;

  @override
  State<ViewNote> createState() {
    //Changed here.

    return _ViewNoteState(note: note);
  }
}

// note = Note();

class _ViewNoteState extends State<ViewNote> {
  // final TextEditingController _titleController = TextEditingController();
  // final TextEditingController _descriptionController = TextEditingController();

  _ViewNoteState({required this.note}); //changed here.
  final Note note;

  NoteDao noteAccess = NoteDao();
  DateTime timeNow = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 27, 27, 25),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 40,
              left: 20,
              right: 20,
            ),
            child: Column(
              children: [
                TextFormField(
                  initialValue: note.title,
                  style: const TextStyle(color: Colors.white),
                  onChanged: ((value) {
                    note.title = value;
                    note.dateCreated = timeNow.toString();
                  }),
                  textAlign: TextAlign.start,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    labelStyle: TextStyle(
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                        fontFamily: "Montserrat"),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.white)),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                TextFormField(
                  initialValue: note.description,
                  style: const TextStyle(color: Colors.white),
                  maxLines: 19,
                  minLines: 19,
                  onChanged: (value) {
                    note.description = value;
                  },
                  textAlign: TextAlign.start,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                        fontFamily: "Montserrat"),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.white)),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        noteAccess.deleteNote(note); //changed here.
                        setState(() {
                          Navigator.of(context).pop();
                        });
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.redAccent),
                        fixedSize: MaterialStateProperty.all(Size.fromWidth(
                            (MediaQuery.of(context).size.width) / 3)),
                      ),
                      child: const Center(
                        child: Text(
                          'Delete Note',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Montserrat",
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        noteAccess.updateNote(note);
                        setState(() {
                          Navigator.of(context).pop();
                        });
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blueAccent),
                        fixedSize: MaterialStateProperty.all(Size.fromWidth(
                            (MediaQuery.of(context).size.width) / 3)),
                      ),
                      child: const Center(
                        child: Text(
                          'Update Note',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Montserrat",
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Note rebuildNote(String title, String description) {
//   note = Note(
//     dateCreated: DateTime.now().toString(),
//     title: title,
//     description: description,
//   );

//   return note;
// }
