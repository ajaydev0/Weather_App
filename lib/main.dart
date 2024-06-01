import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'HomePage.dart';
import 'Services/services.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

String maincityName = "Feni";

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    if (box.read("City") != null) {
      maincityName = box.read("City");
    }
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
