import 'package:sqflite/sqflite.dart';

class DB {
  static Future<Database> getDB() async {
    var db = await openDatabase('profiles.db', onCreate: (db, version) async {
      await db.execute('CREATE TABLE profiles (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, url TEXT NOT NULL, email TEXT NOT NULL, password TEXT NOT NULL)');
    }, version: 2);
    return db;
  }
}