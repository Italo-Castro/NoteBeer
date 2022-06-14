import 'package:note_beer/database/dao/note_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {

   final String path = join( await getDatabasesPath(), 'notbeer.db');

   return openDatabase(path, onCreate: (db, version) {
     db.execute(NoteDao().sqlTable);
   }, version: 1);
}