import 'package:nafie_shop/models/user_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static Future<Database> db() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'my_app.db'),
      version: 3,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE user (id INTEGER PRIMARY KEY AUTOINCREMENT, email TEXT, password TEXT)',
        );

        await db.execute(
          'CREATE TABLE siswa (id INTEGER PRIMARY KEY AUTOINCREMENT, nama TEXT, kelas TEXT)',
        );

        await db.execute('''
          CREATE TABLE orders(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            namaCustomer TEXT,
            namaProduk TEXT,
            jumlah INTEGER,
            totalHarga INTEGER,
            alamat TEXT
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute(
            'CREATE TABLE siswa (id INTEGER PRIMARY KEY AUTOINCREMENT, nama TEXT, kelas TEXT)',
          );
        }

        if (oldVersion < 3) {
          await db.execute('''
            CREATE TABLE orders(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              namaCustomer TEXT,
              namaProduk TEXT,
              jumlah INTEGER,
              totalHarga INTEGER,
              alamat TEXT
            )
          ''');
        }
      },
    );
  }

  static Future<void> registerUser(UserModel user) async {
    final dbs = await db();
    await dbs.insert('user', user.toMap());
  }

  // static Future<int> insertOrder(OrderModel order) async {
  //   final dbs = await db();
  //   return await dbs.insert('orders', order.toMap());
  // }

  // static Future<List<OrderModel>> getOrders() async {
  //   final dbs = await db();
  //   final List<Map<String, dynamic>> maps = await dbs.query('orders');
  //   return maps.map((e) => OrderModel.fromMap(e)).toList();
  // }

  static Future<UserModel?> loginUser({
    required String email,
    required String password,
  }) async {
    final dbs = await db();
    final List<Map<String, dynamic>> results = await dbs.query(
      "user",
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (results.isNotEmpty) {
      return UserModel.fromMap(results.first);
    }
    return null;
  }
}
