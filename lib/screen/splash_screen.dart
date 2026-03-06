import 'package:flutter/material.dart';
import 'package:nafie_shop/navbar/navigation_bar.dart';
import 'package:nafie_shop/screen/welcome_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    goNext();
  }

  void goNext() async {
    await Future.delayed(const Duration(seconds: 3));

    final prefs = await SharedPreferences.getInstance();
    bool? isLogin = prefs.getBool("is_login");

    if (isLogin == true) {
      // Langsung ke Tugas9Flutter kalau sudah login
      Navigator.pushReplacementNamed(context, '/tugas9');
    } else {
      // Kalau belum login, tampilkan WelcomePage dulu
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const WelcomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffb3800),
      body: Center(child: Image.asset("assets/images/logo.png")),
    );
  }
}
