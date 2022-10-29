import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:music_app/constants.dart';

class MusicCategoriesProvider with ChangeNotifier {
  bool _isloadingcategories = false;
  List _categories = [];
  Map _allmusic = {};
  bool get isloadingcategories => _isloadingcategories;
  List get categories => _categories;
  Map get allmusic => _allmusic;

  setLoadingCategories(bool value) {
    _isloadingcategories = value;
    notifyListeners();
  }

  setCategories(value) {
    _categories = value;
    notifyListeners();
  }

  setAllMusic(id, value) {
    _allmusic[id] = value;
    notifyListeners();
  }

  Future getCategories() async {
    setLoadingCategories(true);
    // print('get categories function');
    var headers = {'Accept': 'application/json'};

    var url =
        Uri.parse('https://desktopapp.inshopmedia.com/api/music-category');

    final response = await http.get(
      url,
      headers: headers,
    );
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setCategories(data['data']);
      print(data['data']);
      musicbox.write('cats', data['data']);
      setLoadingCategories(false);
    } else {
      setLoadingCategories(false);
      print(response.reasonPhrase.toString());
    }
  }
}
