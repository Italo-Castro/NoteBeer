import 'package:flutter/material.dart';

import '../database/dao/note_dao.dart';
import '../model/note.dart';
import 'FormNote.dart';

class ListNotes extends StatefulWidget {
  @override
  State<ListNotes> createState() => _ListNotesState();
}

class _ListNotesState extends State<ListNotes> {
  final NoteDao _noteDao = NoteDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Evaluated Beers'),
      ),
      body: FutureBuilder<List<Note>>(
          initialData: [],
          future: Future.delayed(Duration(seconds: 1))
              .then((value) => _noteDao.findAll()),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      Text('Loanding beers evaluetedes'),
                      Image.asset('image/icon_beer.png'),
                    ],
                  ),
                );
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                final List<Note> notes = snapshot.data as List<Note>;
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final Note note = notes[index];
                    return _NoteItem(note);
                  },
                  itemCount: notes.length,
                );
            }

            if (snapshot.data != null) {
              final List<Note> notes = snapshot.data as List<Note>;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final Note note = notes[index];
                  return _NoteItem(note);
                },
                itemCount: notes.length,
              );
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [CircularProgressIndicator(), Text("Loading")],
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator
              .of(context)
              .push(MaterialPageRoute(builder: (context) => FormNote())).then((value) => setState(() {}));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class _NoteItem extends StatelessWidget {
  final Note note;

  _NoteItem(this.note);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(
          title: Text(note.style),
          subtitle: Text(note.manufacturer),
        ),
      ),
    );
  }
}
