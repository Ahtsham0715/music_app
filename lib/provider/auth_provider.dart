import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:music_app/constants.dart';
import 'package:music_app/custom%20widgets/utils.dart';
import 'package:music_app/music%20pages/main_widget.dart';

class AuthProvider with ChangeNotifier {
  bool _isloading = false;

  bool get isloading => _isloading;

  setLoading(bool value) {
    _isloading = value;
    notifyListeners();
  }

  Future logout() async {
    customYesNoDialog(
        titletext: 'Are you sure?',
        contenttext: 'Do you want to logout?',
        yesOnTap: () {
          loginbox.write('islogin', false);
          // Get.back();
          Get.back();
        });
    notifyListeners();
  }

  Future login(String email, password) async {
    setLoading(true);
    try {
      var response = await post(Uri.parse('https://reqres.in/api/login'),
          body: {'email': email, 'password': password});

      if (response.statusCode == 200) {
        setLoading(false);
        styledsnackbar(txt: 'Login Successful', icon: Icons.login);
        var data = jsonDecode(response.body.toString());
        print(data['token']);
        print('Login successfully');
        loginbox.write('islogin', true);
        Get.to(
          () => const MainWidget(),
        );
      } else {
        setLoading(false);
        styledsnackbar(txt: 'Login Failed', icon: Icons.error);

        print('failed');
      }
    } catch (e) {
      setLoading(false);
      styledsnackbar(txt: 'Login Failed', icon: Icons.error);

      print(e.toString());
    }
  }

  Future register({
    required String email,
    required password,
    required username,
    required phonenNumber,
  }) async {
    setLoading(true);
    try {
      var response = await post(Uri.parse('https://reqres.in/api/register'),
          body: {'email': email, 'password': password});

      if (response.statusCode == 200) {
        setLoading(false);
        styledsnackbar(txt: 'Register Successful', icon: Icons.login);
        var data = jsonDecode(response.body.toString());
        print(data['token']);
        print('Register successfully');
        loginbox.write('islogin', true);
        Get.to(
          () => const MainWidget(),
        );
      } else {
        setLoading(false);
        styledsnackbar(txt: 'Register Failed', icon: Icons.error);

        print('failed');
      }
    } catch (e) {
      setLoading(false);
      styledsnackbar(txt: 'Register Failed', icon: Icons.error);

      print(e.toString());
    }
  }
}
