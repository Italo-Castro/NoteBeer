import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:note_beer/model/note.dart';
import 'package:note_beer/database/dao/note_dao.dart';

class FormNote extends StatefulWidget {
  @override
  State<FormNote> createState() => _FormNoteState();
}

class _FormNoteState extends State<FormNote> {
  final TextEditingController _manufacturer = TextEditingController();
  final TextEditingController _style = TextEditingController();
  final TextEditingController _ibu = TextEditingController();
  final TextEditingController _abv = TextEditingController();
  final TextEditingController _obs = TextEditingController();
  final TextEditingController _color = TextEditingController();
  final TextEditingController _noteValue = TextEditingController();

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
                child: ItenFomr(_abv, 'ABV'),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ItenFomr(_ibu, 'IBU'),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ItenFomr(_color, 'COLOR'),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ItenFomr(_obs, 'Observation'),
              ), Padding(
                padding: const EdgeInsets.all(16.0),
                child: ItenFomr(_noteValue, 'Note'),
              ),
            ],
          ),
        )
        ,
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        final String manufacturer = _manufacturer.text;
        final String style = _style.text;
        final String obs = _obs.text;
        final String color = _color.text;
        final double? abv = double.tryParse(_abv.text);
        final double? ibu = double.tryParse(_ibu.text);
        final int? noteValue = int.tryParse(_noteValue.text);

        final Note newNote = Note(0,manufacturer,style,ibu!,abv!,obs,color,noteValue!);
        noteDao.save(newNote).then((id) => Navigator.pop(context));
      },
          child: Icon(Icons.wb_cloudy_rounded),),

    );
  }
}

class ItenFomr extends StatelessWidget {
  final TextEditingController _controller;
  final String label;

  ItenFomr(this._controller, this.label);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(labelText: label),
    );
  }
}
