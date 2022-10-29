import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:music_app/constants.dart';

class CategoryMusicProvider with ChangeNotifier {
  bool _isloadingmusic = false;
  List _categorymusic = [];
  bool get isloadingmusic => _isloadingmusic;
  List get categorymusic => _categorymusic;

  setLoadingMusic(bool value) {
    _isloadingmusic = value;
    notifyListeners();
  }

  setCategoryMusic(value) {
    _categorymusic = value;
    notifyListeners();
  }

  Future getCategoryMusic({required id}) async {
    setLoadingMusic(true);
    print('set categories function');
    var headers = {'Accept': 'application/json'};

    var url = Uri.parse(
        'https://desktopapp.inshopmedia.com/api/music-list?category_id=$id');

    final response = await http.get(
      url,
      headers: headers,
    );
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setCategoryMusic(data['data']);
      print(data['data']);
      musicbox.write('musicloaded', true);
      setLoadingMusic(false);
      musicbox.write('cat_download', true);
    } else {
      setLoadingMusic(false);
      print(response.reasonPhrase.toString());
    }
  }
}
