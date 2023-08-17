import 'package:my_flutter_project/stamp.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  // Singleton pattern
  static final DatabaseHelper dbHelper = DatabaseHelper._internal();

  // Return already created db helper instance whenever it is created using factory keyword
  factory DatabaseHelper() => dbHelper;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    // Initialize the DB first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  // Create Database
  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    // Set the path to the database
    final path = join(databasePath, 'my_stamps.db');

    return await openDatabase(path,
        onCreate: _onCreate,
        version: 3,
        onConfigure: (db) async =>
            await db.execute('PRAGMA foreign_keys = ON'));
  }

  // When the db is first created, create a new table
  // 'CREATE TABLE stamp(id INTEGER PRIMARY KEY, date TEXT, cups INTEGER)'
  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE stamp(date TEXT PRIMARY KEY, cups INTEGER)');
  }

  Future<List<Stamp>> getAllStamps() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('stamp');

    // Convert the List<Map<String, dynamic> into a List<Stamp>.
    return List.generate(maps.length, (index) => Stamp.fromMap(maps[index]));
  }

  Future<Stamp> getStamp(String date) async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps =
        await db.query('stamp', where: 'date = ?', whereArgs: [date]);
    return Stamp.fromMap(maps[0]);
  }

  Future<void> insert(Stamp stamp) async {
    final db = await dbHelper.database;

    await db.insert('stamp', stamp.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> update(Stamp stamp) async {
    final db = await dbHelper.database;

    await db.update('stamp', stamp.toMap(), where: 'date = ?', whereArgs: [stamp.date]);
  }

  Future<void> delete(String date) async {
    final db = await dbHelper.database;

    await db.delete('stamp', where: 'date = ?', whereArgs: [date]);
  }

}
