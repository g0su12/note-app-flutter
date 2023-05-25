import 'package:note/app/models/note_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  static const _dbName = 'notes.db';
  static const _dbVersion = 1;
  static const String TABLE_NAME = 'notes';
  static const String COLUMN_ID = 'id';
  static const String COLUMN_CATEGORY = 'category';
  static const String COLUMN_DATE = 'date';
  static const String COLUMN_TITLE = 'title';
  static const String COLUMN_TIME = 'time';
  static const String COLUMN_CONTENT = 'content';
  static const String COLUMN_LOCATION = 'location';
  static const String COLUMN_TASKS = 'tasks';


  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB(_dbName);
    return _database!;
  }


  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: _dbVersion, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $TABLE_NAME (
            $COLUMN_ID INTEGER PRIMARY KEY,
            $COLUMN_CATEGORY TEXT,
            $COLUMN_DATE INTEGER,
            $COLUMN_TITLE TEXT,
            $COLUMN_TIME TEXT,
            $COLUMN_CONTENT TEXT,
            $COLUMN_LOCATION TEXT,
            $COLUMN_TASKS TEXT
          )
        ''');
  }

  Future<void> insert(NoteModel note) async {
    final db = await database;
    await db.insert(TABLE_NAME, note.toMap());
  }

  Future<List<NoteModel>> getAllNotes() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db.query(TABLE_NAME);
    return results.map((note) => NoteModel.fromMap(note)).toList();
  }

  Future<void> delete(int id) async {
    final db = await database;
    await db.delete(TABLE_NAME, where: '$COLUMN_ID = ?', whereArgs: [id]);
  }

  Future<void> update(NoteModel note) async {
    final db = await database;
    await db.update(TABLE_NAME, note.toMap(), where: '$COLUMN_ID = ?', whereArgs: [note.id]);
  }

  Future<void> saveOrUpdate(NoteModel note) async {
    final db = await database;
    if (note.id == null) {
      await db.insert(TABLE_NAME, note.toMap());
    } else {
      await db.update(TABLE_NAME, note.toMap(), where: '$COLUMN_ID = ?', whereArgs: [note.id]);
    }
  }

  Future<void> deleteAllNotes() async {
    final db = await database;
    await db.delete(TABLE_NAME);
  }

}