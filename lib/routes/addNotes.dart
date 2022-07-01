import 'package:flutter/material.dart';
import '../backend/note_dao.dart';
import '../backend/notes_model.dart';

class AddNote extends StatefulWidget {
  AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  Note note = Note();

  NoteDao noteAccess = NoteDao();

  DateTime timeNow = DateTime.now();

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
                  style: const TextStyle(color: Colors.white),
                  onChanged: ((value) {
                    note.title = _titleController.text;
                    note.dateCreated = timeNow.toString();
                  }),
                  controller: _titleController,
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
                  style: const TextStyle(color: Colors.white),
                  maxLines: 19,
                  minLines: 19,
                  controller: _descriptionController,
                  onChanged: (value) {
                    note.description = _descriptionController.text;
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        noteAccess.saveNote(note);
                        setState(() {
                          Navigator.of(context).pop();
                        });
                        /*Save to firebase and go back to view saved notes.*/
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
                          'Save Note',
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
