import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class MusicCategoriesProvider with ChangeNotifier {
  bool _isloadingcategories = false;
  List _categories = [];
  bool get isloadingcategories => _isloadingcategories;
  List get categories => _categories;

  setLoadingCategories(bool value) {
    _isloadingcategories = value;
    notifyListeners();
  }

  setCategories(value) {
    _categories = value;
    notifyListeners();
  }

  Future getCategories() async {
    setLoadingCategories(true);
    print('get categories function');
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
      setLoadingCategories(false);
    } else {
      setLoadingCategories(false);
      print(response.reasonPhrase.toString());
    }
  }
}
