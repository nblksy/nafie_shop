import 'package:nafie_shop/models/product_model.dart';
import 'package:nafie_shop/models/user_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Future<Database> db() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'my_app.db'),
      version: 5,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE user (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            email TEXT,
            password TEXT,
            nama TEXT,
            noHP TEXT,
            role TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE products(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            price INTEGER
          )
        ''');
      },
    );
  }

  // ================= USER =================

  static Future<void> registerUser(UserModel user) async {
    final dbs = await db();
    await dbs.insert('user', user.toMap());
  }

  static Future<UserModel?> loginUser({
    required String email,
    required String password,
  }) async {
    final dbs = await db();
    final results = await dbs.query(
      "user",
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (results.isNotEmpty) {
      return UserModel.fromMap(results.first);
    }
    return null;
  }

  // ================= PRODUCT =================

  static Future<int> insertProduct(ProductModel product) async {
    final dbs = await db();
    return await dbs.insert('products', product.toMap());
  }

  static Future<int> updateProduct(ProductModel product) async {
    final dbs = await db();
    return await dbs.update(
      'products',
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  static Future<int> deleteProduct(int id) async {
    final dbs = await db();
    return await dbs.delete('products', where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<ProductModel>> getProducts() async {
    final dbs = await db();
    final List<Map<String, dynamic>> maps = await dbs.query('products');

    return maps.map((e) => ProductModel.fromMap(e)).toList();
  }
}
