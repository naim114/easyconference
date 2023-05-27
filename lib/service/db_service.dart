import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBService {
  static final DBService instance = DBService._init();
  DBService._init();
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('easyconference.db');
    return _database!;
  }

  Future _createDB(Database db, int version) async {
    // tb_user
    await db.execute('''
      create table tb_user ( 
        id integer primary key autoincrement, 
        name text not null,
        email text not null,
        phone integer not null,
        role integer not null,
        username text not null,
        password text not null,
        avatarPath text,
        specializeArea integer)
    ''');

    // tb_conference
    await db.execute('''
      create table tb_conference ( 
        id integer primary key autoincrement, 
        name text not null,
        dateTime text not null,
        desc text not null,
        posterPath text,
        presenter integer not null)
    ''');

    // tb_specialize_area
    await db.execute('''
      create table tb_specialize_area ( 
        id integer primary key autoincrement, 
        area text not null)
    ''');

    // tb_auth
    await db.execute('''
      create table tb_auth ( 
        user integer)
    ''');
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }
}
