import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/auth/login_ui.dart';
import 'package:music_app/provider/auth_provider.dart';
import 'package:music_app/provider/hover_provider.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (_) => HoverProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Music App',
        theme: ThemeData(
          hoverColor: Colors.grey.shade100.withOpacity(1.0),
          // scaffoldBackgroundColor: Colors.grey.shade400,
          // iconTheme: IconThemeData(color: Colors.black),
          primarySwatch: Colors.teal,
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
          brightness: Brightness.light,
        ),
        home: const LoginUi(),
      ),
    );
  }
}
