import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:music_app/custom%20widgets/utils.dart';

class GetPlaylistProvider with ChangeNotifier {
  bool _islaodinglist = false;
  List _userplaylist = [];

  bool get islaodinglist => _islaodinglist;
  List get userplaylist => _userplaylist;

  setLoadingList(bool value) {
    _islaodinglist = value;
    notifyListeners();
  }

  setUserPlaylist(value) {
    _userplaylist = value;
    notifyListeners();
  }

  Future getPlaylist({required String userid}) async {
    setLoadingList(true);
    print('loading playlist for this user');
    var headers = {'Accept': 'application/json'};

    var url = Uri.parse(
        'https://desktopapp.inshopmedia.com/api/get-playlist?user_id=$userid');

    final response = await http.get(
      url,
      headers: headers,
    );
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setUserPlaylist(data['data']);
      print(data);
      setLoadingList(false);
    } else {
      setLoadingList(false);
      print(response.reasonPhrase.toString());
    }
  }
}
