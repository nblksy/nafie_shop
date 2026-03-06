import 'package:flutter/material.dart';
import 'package:nafie_shop/screen/cart_page.dart';
import 'package:nafie_shop/screen/home_page.dart';
import 'package:nafie_shop/screen/profile_page.dart';

class Tugas8Flutter extends StatefulWidget {
  const Tugas8Flutter({super.key});

  @override
  State<Tugas8Flutter> createState() => _Tugas8Flutter();
}

class _Tugas8Flutter extends State<Tugas8Flutter> {
  int _currentIndex = 0;
  void ontapItem(int index) {
    _currentIndex = index;
    setState(() {});
  }

  final List<Widget> listWidget = [
    HomePage(),
    CartPage(),
    ProfilePage(),
    // Tugas7Flutter(),
    // Tugas9Flutter(),
    // Tugas11Flutter(),
    // TentangAplikasi(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listWidget.elementAt(_currentIndex),

      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.app_registration),
            label: "Home",
            backgroundColor: Color(0xff12325E),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Cart",
            backgroundColor: Color(0xff12325E),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Profile",
            backgroundColor: Colors.white,
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.shopping_cart),
          //   label: "Produk",
          //   backgroundColor: Colors.white,
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.book_online_outlined),
          //   label: "Order",
          //   backgroundColor: Colors.white,
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.info),
          //   label: "Tentang Aplikasi",
          //   backgroundColor: Colors.white,
          // ),
        ],
        selectedItemColor: Colors.black,
        selectedIconTheme: IconThemeData(color: Colors.black),
        currentIndex: _currentIndex,
        onTap: ontapItem,
      ),
    );
  }
}
