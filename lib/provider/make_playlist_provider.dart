import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:music_app/custom%20widgets/utils.dart';

class MakePlaylistProvider with ChangeNotifier {
  final List<bool> _isaddinglist = [];
  List<bool> get isaddinglist => _isaddinglist;

  setAddingPlaylist(bool value, index) {
    _isaddinglist[index] = value;
    notifyListeners();
  }

  setLoadingListLength(length) {
    for (int i = 0; i < length; i++) {
      _isaddinglist.add(false);
    }
    notifyListeners();
  }

  Future AddToPlaylist({required songid, userid = 5, required id}) async {
    setAddingPlaylist(true, id);
    var headers = {'Accept': 'application/json'};

    var url = Uri.parse(
        'https://desktopapp.inshopmedia.com/api/make-playlist?user_id=5&song_id=$songid');

    final response = await http.get(
      url,
      headers: headers,
    );
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(data);
      setAddingPlaylist(false, id);
      if (data['data'] == 'added') {
        styledsnackbar(txt: 'Added to playlist', icon: Icons.check_circle);
      } else {
        styledsnackbar(txt: 'Deleted from playlist', icon: Icons.delete);
      }
    } else {
      setAddingPlaylist(false, id);
      styledsnackbar(txt: 'Error Occured', icon: Icons.error);
      print(response.reasonPhrase.toString());
    }
  }
}
