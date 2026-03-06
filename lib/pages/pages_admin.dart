// import 'package:flutter/material.dart';
// import 'package:nafie_shop/database/sqflite.dart';
// import '../models/product_model.dart';

// class AdminPage extends StatefulWidget {
//   const AdminPage({super.key});

//   @override
//   State<AdminPage> createState() => _AdminPageState();
// }

// class _AdminPageState extends State<AdminPage> {
//   final nameController = TextEditingController();
//   final priceController = TextEditingController();

//   Future<List<ProductModel>> getData() async {
//     return DBHelper.getProducts();
//   }

//   void saveProduct() async {
//     await DBHelper.insertProduct(
//       ProductModel(
//         name: nameController.text,
//         price: int.parse(priceController.text),
//       ),
//     );
//     nameController.clear();
//     priceController.clear();
//     setState(() {});
//   }

//   void deleteProduct(int id) async {
//     await DBHelper.deleteProduct(id);
//     setState(() {});
//   }

//   void updateProduct(ProductModel product) async {
//     await DBHelper.updateProduct(
//       ProductModel(
//         id: product.id,
//         name: nameController.text,
//         price: int.parse(priceController.text),
//       ),
//     );
//     nameController.clear();
//     priceController.clear();
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Admin - Manage Produk")),
//       body: Column(
//         children: [
//           TextField(
//             controller: nameController,
//             decoration: const InputDecoration(labelText: "Nama Produk"),
//           ),
//           TextField(
//             controller: priceController,
//             decoration: const InputDecoration(labelText: "Harga"),
//             keyboardType: TextInputType.number,
//           ),
//           ElevatedButton(
//             onPressed: saveProduct,
//             child: const Text("Tambah Produk"),
//           ),
//           Expanded(
//             child: FutureBuilder(
//               future: getData(),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return const Center(child: CircularProgressIndicator());
//                 }

//                 final products = snapshot.data!;
//                 return ListView.builder(
//                   itemCount: products.length,
//                   itemBuilder: (context, index) {
//                     final product = products[index];
//                     return ListTile(
//                       title: Text(product.name),
//                       subtitle: Text("Rp ${product.price}"),
//                       trailing: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           IconButton(
//                             icon: const Icon(Icons.edit),
//                             onPressed: () {
//                               nameController.text = product.name;
//                               priceController.text = product.price.toString();
//                               updateProduct(product);
//                             },
//                           ),
//                           IconButton(
//                             icon: const Icon(Icons.delete),
//                             onPressed: () => deleteProduct(product.id!),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
