import 'package:flutter/material.dart';
import 'package:startup_fintech_pt_bkn/data/database_helper.dart';
import 'package:startup_fintech_pt_bkn/screens/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Pastikan Flutter sudah terinisialisasi

  // Inisialisasi database
  await DatabaseHelper();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
