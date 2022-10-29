import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:music_app/constants.dart';
import 'package:music_app/provider/categories_provider.dart';
import 'package:provider/provider.dart';

class AllCategoriesProvider with ChangeNotifier {
  bool _isloadingmusic = false;
  Map _allmusic = {};
  bool get isloadingmusic => _isloadingmusic;
  Map get allmusic => _allmusic;

  setLoadingCategories(bool value) {
    _isloadingmusic = value;
    notifyListeners();
  }

  setAllMusic(id, value) {
    _allmusic[id] = value;
    notifyListeners();
  }

  Future getMusic({required categoryid}) async {
    setLoadingCategories(true);
    // print('get categories function');
    var headers = {'Accept': 'application/json'};

    var url = Uri.parse(
        'https://desktopapp.inshopmedia.com/api/music-list?category_id=$categoryid');

    final response = await http.get(
      url,
      headers: headers,
    );
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      allmusic[categoryid] = data['data'];
      print(data['data']);
      setLoadingCategories(false);
    } else {
      setLoadingCategories(false);
      print(response.reasonPhrase.toString());
    }
  }

  // Future fetchallmusic() async {
  //   List cats = [];
  //   musicbox.listenKey('cats', (value) async {
  //     if (musicbox.read('cats').length >= 0) {
  //       cats = musicbox.read('cats');
  //       for (var cat in cats) {
  //         print(cat['id']);
  //         await getMusic(categoryid: cat['id']);
  //       }
  //     }
  //   });

  //   return cats;
  // }
}
