import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:music_app/constants.dart';
import 'package:music_app/provider/download_provider.dart';
import 'package:music_app/provider/player_provider.dart';
import 'package:music_app/provider/auth_provider.dart';
import 'package:music_app/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await windowManager.ensureInitialized();
  // windowManager.waitUntilReadyToShow().then((_) async {
  //   await windowManager.setAsFrameless();
  // });
  await GetStorage.init('login_session');
  await GetStorage.init('playlist');
  await GetStorage.init('player');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    playerbox.writeIfNull('isplaying', false);
    playerbox.writeIfNull('loop', false);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AudioPlayerProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => DownloadProvider()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Music App',
        theme: ThemeData(
          hoverColor: Colors.grey.shade200.withOpacity(1.0),
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
        home: const SplashScreen(),
      ),
    );
  }
}
