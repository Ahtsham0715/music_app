import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:music_app/constants.dart';
import 'package:music_app/provider/allcategories_music_provider.dart';
import 'package:music_app/provider/categories_provider.dart';
import 'package:music_app/provider/category_music_provider.dart';
import 'package:music_app/provider/download_provider.dart';
import 'package:music_app/provider/get_playlist_provider.dart';
import 'package:music_app/provider/make_playlist_provider.dart';
import 'package:music_app/provider/player_provider.dart';
import 'package:music_app/provider/auth_provider.dart';
import 'package:music_app/provider/profile_update_provider.dart';
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
  await GetStorage.init('music_box');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    playerbox.write('isplaying', false);
    playerbox.writeIfNull('songs_data', {
      'issingle': true,
      'isAsset': false,
      'songs_list': [],
      'song_id': '',
    });
    playerbox.writeIfNull('loop', false);
    musicbox.writeIfNull('musicloaded', false);
    musicbox.writeIfNull('allmusic', {});
    musicbox.writeIfNull('cats', []);
    musicbox.writeIfNull('cat_download', false);
    loginbox.writeIfNull('userdata', {});
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AudioPlayerProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => DownloadProvider()),
        ChangeNotifierProvider(create: (_) => ProfileUpdateProivder()),
        ChangeNotifierProvider(create: (_) => MusicCategoriesProvider()),
        ChangeNotifierProvider(create: (_) => CategoryMusicProvider()),
        ChangeNotifierProvider(create: (_) => MakePlaylistProvider()),
        ChangeNotifierProvider(create: (_) => GetPlaylistProvider()),
        ChangeNotifierProvider(create: (_) => AllCategoriesProvider()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'InshopMedia Player',
        theme: ThemeData(
          hoverColor: Colors.grey.shade200.withOpacity(1.0),
          // scaffoldBackgroundColor: Colors.grey.shade100.withOpacity(1.0),
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
