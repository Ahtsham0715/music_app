import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/auth/login_ui.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await windowManager.ensureInitialized();
  // windowManager.waitUntilReadyToShow().then((_) async {
  //   await windowManager.setAsFrameless();
  // });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music App',
      theme: ThemeData(
          primarySwatch: Colors.amber,
          brightness: Brightness.light,
          iconTheme: IconThemeData(
            color: Colors.black,
          )),
      home: const LoginUi(),
    );
  }
}
