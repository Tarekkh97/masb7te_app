import 'package:flutter/material.dart';
import 'package:masb7te_app/home_page.dart';
import 'package:masb7te_app/shared_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedHelper().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
