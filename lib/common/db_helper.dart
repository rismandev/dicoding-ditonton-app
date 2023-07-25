import 'package:ditonton/features/movie/data/datasources/db/database_helper.dart';
import 'package:ditonton/features/tv_series/data/datasources/db/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;
  static int databaseVersion = 1;

  Future<Database?> get database async {
    _database ??= await initDb();
    return _database;
  }

  Future<Database> initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton.db';

    var db = await openDatabase(
      databasePath,
      version: DatabaseHelper.databaseVersion,
      onCreate: (db, version) {
        onCreateTable1(db, version);
        onCreateTable2(db, version);
      },
    );
    return db;
  }

  void onCreateTable1(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  ${MovieDBHelper.tblWatchlist} (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
  }

  void onCreateTable2(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  ${TvSeriesDBHelper.tblWatchlist} (
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT,
        firstAirDate TEXT
      );
    ''');
  }

  Future<int> onInsert(String tbName, Map<String, dynamic> map) async {
    final db = await database;
    return db!.insert(tbName, map);
  }

  Future<int> onDelete(String tbName, int id) async {
    final db = await database;
    return db!.delete(
      tbName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> onSelect(String tbName) async {
    final db = await database;
    return db!.query(tbName);
  }

  Future<Map<String, dynamic>?> getById(String tbName, int id) async {
    final db = await database;
    final results = await db!.query(
      tbName,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }
}
