import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class Note{
  final String myName;
  final String yourName;
  final String gameResult;

  Note({
    required this.myName,
    required this.yourName,
    required this.gameResult
  }); 
  
  Map<String, dynamic> toMap(){
    return {
      'myName':myName,
      'yourName':yourName,
      'gameResult':gameResult,
    };
  }

  static Future<Database> get database async {
    final Future<Database> _database = openDatabase(
      join(await getDatabasesPath(),'note.db'),
      onCreate: (db,version){
        return db.execute(
          "CREATE TABLE note(recId INTEGER PRIMARY KEY AUTOINCREMENT, myName TEXT, yourName TEXT, gameResult TEXT)",
        );
      },
      version: 1,
    );
    return _database;
  }

  /** データの取得 */
  static Future<List<Note>> getDatas() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('note');
    return List.generate(maps.length,(i){
      return Note(
        myName: maps[i]['myName'],
        yourName: maps[i]['yourName'],
        gameResult: maps[i]['gameResult'],
      );
    });
  }

  /** データの挿入 */
  static Future<void> insertData(Note data) async {
    final Database db = await database;
    await db.insert(
      'note',
      data.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /** データの削除 */
  static Future<void> deleteData(int recId) async {
    final db = await database;
    await db.delete(
      'note',
      // where: "recId = ?",
      // whereArgs: [recId],
    );
  }
}
