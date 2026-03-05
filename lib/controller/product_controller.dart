import 'package:nafie_shop/database/sqflite.dart';
import 'package:nafie_shop/models/product_model.dart';

class ProductController {
  static Future<int> insertProduct(ProductModel product) async {
    final dbs = await DBHelper.db();
    return await dbs.insert('Products', product.toMap());
  }

  static Future<List<ProductModel>> getProducts() async {
    final dbs = await DBHelper.db();
    final List<Map<String, dynamic>> maps = await dbs.query('Products');
    return maps.map((e) => ProductModel.fromMap(e)).toList();
  }

  static Future<int> updateProduct(ProductModel product) async {
    final dbs = await DBHelper.db();

    if (product.id == null) {
      throw Exception("ID wajib ada untuk update");
    }

    return await dbs.update(
      'Products',
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  static Future<int> deleteProduct(int id) async {
    final dbs = await DBHelper.db();

    return await dbs.delete('Products', where: 'id = ?', whereArgs: [id]);
  }
}
