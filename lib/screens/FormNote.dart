import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:note_beer/model/note.dart';
import 'package:note_beer/database/dao/note_dao.dart';
import 'package:note_beer/screens/listNotes.dart';

class FormNote extends StatefulWidget {
  final Note note;

  FormNote(this.note);

  @override
  State<FormNote> createState() => _FormNoteState();
}

class _FormNoteState extends State<FormNote> {
  final TextEditingController _manufacturer = TextEditingController();
  TextEditingController _style = TextEditingController();
  TextEditingController _ibu = TextEditingController();
  TextEditingController _abv = TextEditingController();
  TextEditingController _obs = TextEditingController();
  TextEditingController _color = TextEditingController();
  TextEditingController _noteValue = TextEditingController();

  @override
  void initState() {
    _manufacturer.text = widget.note.manufacturer;
    _style.text = widget.note.style;
    _ibu.text = widget.note.ibu.toString();
    _abv.text = widget.note.abv.toString();
    _obs.text = widget.note.obs;
    _color.text = widget.note.color;
    _noteValue.text = widget.note.noteValue.toString();
    super.initState();
  }

  final NoteDao noteDao = NoteDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Evalueted beer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ItenFomr(_manufacturer, 'Manufacuter'),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ItenFomr(_style, 'Style'),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ItenFomr(_abv, 'Alcohol by Volume (ABV)'),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ItenFomr(_ibu, 'International Bitterness Unit (IBU)'),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ItenFomr(_color, 'COLOR'),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ItenFomr(_obs, 'Observation'),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ItenFomr(_noteValue, 'Note'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (widget.note.id != null && widget.note.id != 0) {
            final String manufacturer = _manufacturer.text;
            final String style = _style.text;
            final String obs = _obs.text;
            final String color = _color.text;
            final double? abv = double.tryParse(_abv.text);
            final double? ibu = double.tryParse(_ibu.text);
            final int? noteValue = int.tryParse(_noteValue.text);
            final Note newNote = Note(widget.note.id, manufacturer, style, ibu!,
                abv!, obs, color, noteValue!);
            noteDao.update(newNote).then(
                  (id) => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ListNotes();
                      },
                    ),
                  ),
                );
          } else {
            String manufacturer = '';
            String style = "";
            String obs = "";
            String color = "";
            double? abv = 0;
            double? ibu = 0;
            int? noteValue = 0;

            if (_manufacturer.text.isEmpty) {
              snackBar('Please inform the manufacturer', context);
              return;
            } else {
              manufacturer = _manufacturer.text;
            }

            if (_style.text.isEmpty) {
              snackBar('Please inform the style', context);
              return;
            } else {
              style = _style.text;
            }

            if (_color.text.isEmpty) {
              snackBar('Please inform the color', context);
              return;
            } else {
              color = _color.text;
            }

            if (_abv.text.isEmpty) {
              snackBar('Please inform the ABV', context);
              return;
            } else {
              abv = double.tryParse(_abv.text);
            }

            if (_ibu.text.isEmpty) {
              snackBar('Please inform the IBU', context);
              return;
            } else {
              ibu = double.tryParse(_ibu.text);
            }

            if (_noteValue.text.isEmpty) {
              snackBar('Please inform the note value for the beer', context);
              return;
            } else {
              noteValue = int.tryParse(_noteValue.text);
            }

            final Note newNote = Note(
                0, manufacturer, style, ibu!, abv!, obs, color, noteValue!);
            noteDao.save(newNote).then(
                  (id) => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ListNotes();
                      },
                    ),
                  ),
                );
          }
        },
        child: Icon(Icons.wb_cloudy_rounded),
      ),
    );
  }
}

snackBar(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: 'OK',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    ),
  );
}

class ItenFomr extends StatelessWidget {
  final TextEditingController _controller;
  final String label;

  ItenFomr(this._controller, this.label);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      decoration: InputDecoration(labelText: label),
    );
  }
}
