import 'package:flutter/material.dart';
import 'package:notes101/backend/note_dao.dart';
import 'package:notes101/backend/notes_model.dart';
import 'package:notes101/routes/addNotes.dart';
import 'package:notes101/routes/viewNote.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  NoteDao accessNote = NoteDao();
  late Future<List<Note>> loadedNotes;
  late double columnWidth;
  late List<Note> notesList;

  @override
  void initState() {
    super.initState();
    loadedNotes = loadNotes();
  }

  Future<List<Note>> loadNotes() async {
    return await accessNote.getNotesList();
  }

  @override
  Widget build(BuildContext context) {
    columnWidth = (MediaQuery.of(context).size.width / 1.1);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: ((context) => AddNote())))
              .then((value) => setState(() {
                    loadedNotes = loadNotes();
                  }));
        },
        child: const Icon(Icons.add),
      ),
      backgroundColor: const Color.fromARGB(255, 27, 27, 25),
      body: FutureBuilder(
        future: loadedNotes,
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              print('snap has data.');
              notesList = snapshot.data as List<Note>;
              return renderNotesList(notesList);
            }
            if (snapshot.hasError) {
              var snapshotE = snapshot.error;
              print('Snapshot error: $snapshotE ');
              print('$snapshot');
              return MaterialBanner(
                forceActionsBelow: true,
                content: const Text(
                    'Failed to load notes. Try again or check Internet Connection.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        loadedNotes;
                      });
                    },
                    child: const Text('Refresh'),
                  ),
                ],
                backgroundColor: Colors.red,
                contentTextStyle: const TextStyle(color: Colors.white),
              );
            }
          }
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
              backgroundColor: Colors.grey,
            ),
          );
        }),
      ),
    );
  }

  Widget renderNotesList(List<Note> notesList) {
    print("getting list of length " + notesList.length.toString());

    if (notesList.isNotEmpty) {
      print('trying to build List View builder.');
      return ListView.builder(
        itemCount: notesList.length,
        itemBuilder: ((context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: customListTile(index),
          );
        }),
      );
    }

    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
          'No notes stored yet',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontFamily: "Montserrat",
          ),
        ),
        Text(
          'Click (+) button to add a new Note.',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 16,
            color: Colors.white,
            fontFamily: "Montserrat",
          ),
        ),
      ],
    ));
  }

  Widget customListTile(int index) {
    return ListTile(
      enabled: true,
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return ViewNote(note: notesList[index]);
          },
          //maintainState: true,
        )).then((value) {
          //added two lines.
          setState(() {
            loadedNotes = loadNotes();
          });
        });
      },
      tileColor: Colors.grey[800],
      style: ListTileStyle.drawer,
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: Colors.white,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      title: Text(
        notesList[index].title.toString(),
        style: const TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        notesList[index].description.toString(),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
