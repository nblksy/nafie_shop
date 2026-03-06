// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CartItem {
  String title;
  String price;
  String image;
  int quantity;

  CartItem({
    required this.title,
    required this.price,
    required this.image,
    this.quantity = 1,
  });

  int get priceInt {
    return int.parse(price.replaceAll("Rp", "").replaceAll(".", ""));
  }

  int get total => priceInt * quantity;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'price': price,
      'image': image,
      'quantity': quantity,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      title: map['title'] as String,
      price: map['price'] as String,
      image: map['image'] as String,
      quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItem.fromJson(String source) => CartItem.fromMap(json.decode(source) as Map<String, dynamic>);
}

class CartManager {
  static List<CartItem> cartItems = [];
}
