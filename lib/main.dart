import 'package:flutter/material.dart';
import 'package:nafie_shop/screen/cart_page.dart';
import 'package:nafie_shop/screen/home_page.dart';
import 'package:nafie_shop/screen/login.dart';
import 'package:nafie_shop/screen/splash_screen.dart';
import 'package:nafie_shop/screen/welcome_page.dart';
import 'package:nafie_shop/navbar/navigation_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tugas 9',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: SplashScreen(),
      // routes: {
      //   '/splash': (context) => const SplashScreen(),
      //   '/welcome': (context) => const WelcomePage(),
      //   '/login': (context) => const Login(),
      //   '/homepage': (context) => const Tugas8Flutter(),
      // },
    );
  }
}
