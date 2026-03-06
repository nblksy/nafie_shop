import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:nafie_shop/models/user_model.dart';

class DBHelper {
  static Database? _database;

  static Future<Database> db() async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  static Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'nafie_shop.db');

    print('Database path: $path');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        print('Creating database with table user...');
        await db.execute('''
          CREATE TABLE user (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nama TEXT NOT NULL,
            email TEXT NOT NULL UNIQUE,
            password TEXT NOT NULL,
            noHP TEXT NOT NULL
          )
        ''');
      },
    );
  }

  static Future<int> registerUser(UserModel user) async {
    final database = await db();

    final result = await database.insert(
      'user',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return result;
  }

  static Future<UserModel?> loginUser({
    required String email,
    required String password,
  }) async {
    final database = await db();

    final results = await database.query(
      'user',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
      limit: 1,
    );

    if (results.isNotEmpty) {
      return UserModel.fromMap(results.first);
    }

    return null;
  }

  static Future<bool> isEmailExists(String email) async {
    final database = await db();

    final results = await database.query(
      'user',
      where: 'email = ?',
      whereArgs: [email],
      limit: 1,
    );

    return results.isNotEmpty;
  }
}
