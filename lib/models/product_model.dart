import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductModel {
  final int? id;
  final String name;
  final int price;

  ProductModel({this.id, required this.name, required this.price});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'name': name, 'price': price};
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      price: map['price'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
