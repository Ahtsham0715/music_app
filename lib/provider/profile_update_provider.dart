import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:music_app/custom%20widgets/utils.dart';

class ProfileUpdateProivder with ChangeNotifier {
  bool _issaving = false;

  bool get issaving => _issaving;

  setSaving(bool value) {
    _issaving = value;
    notifyListeners();
  }

  Future updateUserData({
    required String id,
    required String name,
    required String email,
    required String mobile,
    required String country,
    required String password,
  }) async {
    setSaving(true);
    var headers = {'Accept': 'application/json'};

    var url =
        Uri.parse('https://desktopapp.inshopmedia.com/api/profile-update');
    var updatedData = {
      'id': '5',
      'name': 'smith',
      'username': 'smith',
      'email': 'smith@gmail.com',
      'mobile': '4323442342',
      'country': 'India',
      'password': 'demouser'
    };
    final response = await http.post(url, headers: headers, body: updatedData);
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(data);
      setSaving(false);
      styledsnackbar(
          txt: 'Data Updated Successfully', icon: Icons.check_circle);
    } else {
      setSaving(false);
      styledsnackbar(txt: 'Saving Failed', icon: Icons.error);
      print(response.reasonPhrase.toString());
    }
  }
}
