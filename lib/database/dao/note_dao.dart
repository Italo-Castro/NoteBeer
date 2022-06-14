import 'package:note_beer/database/app_database.dart';
import '../../model/note.dart';
import 'package:sqflite/sqflite.dart';
class NoteDao {

  static const String _tableName = 'notebeer';
  static const String _id = 'id';
  static const String _manufacturer = 'manufacturer';
  static const String _style = 'style';
  static const String _ibu = 'ibu';
  static const String _abv = 'abv';
  static const String _obs = 'obs';
  static const String _color = 'color';
  static const String _noteValue = 'note';

  final String sqlTable = 'CREATE TABLE $_tableName ('
    '$_id INTEGER PRIMARY KEY, '
    '$_manufacturer TEXT, '
    '$_style TEXT, '
    '$_ibu DOUBLE, '
    '$_abv DOUBLE, '
    '$_obs TEXT, '
    '$_color TEXT,  '
    '$_noteValue INTEGER ) ';


  Future<int> save (Note note) async {

    final Database db = await getDatabase();
    final Map<String, dynamic> noteMap = Map();
    noteMap['$_manufacturer'] = note.manufacturer;
    noteMap['$_style']  = note.style;
    noteMap['$_ibu'] = note.ibu;
    noteMap['$_abv'] = note.abv;
    noteMap['$_color'] = note.color;
    noteMap['$_obs'] = note.obs;
    noteMap['$_noteValue'] = note.noteValue;

    return db.insert(_tableName, noteMap);
  }

  Future<List<Note>> findAll() async {

    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);

    final List<Note> notes = [];
    for (Map<String, dynamic> row in result) {
      final Note note = Note(
      row[_id],
      row[_manufacturer],
      row[_style],
      row[_ibu],
      row[_abv],
      row[_obs],
      row[_color],
      row[_noteValue]
     );
      notes.add(note);
    }
    return notes;
  }




}