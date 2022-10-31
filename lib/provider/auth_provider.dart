import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:music_app/auth/login_ui.dart';
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
          loginbox.write('userdata', {});
          // Get.back();
          Get.to(
            () => const LoginUi(),
          );
        });
    notifyListeners();
  }

  Future login(String email, password) async {
    setLoading(true);
    try {
      var response = await post(
          Uri.parse('https://desktopapp.inshopmedia.com/api/login'),
          body: {'email': email, 'password': password},
          headers: {'Accept': 'application/json'});

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data);
        if (data['data'] == 'null' || data['data'] == null) {
          setLoading(false);
          styledsnackbar(txt: 'Login Failed', icon: Icons.error);
        } else {
          setLoading(false);
          styledsnackbar(txt: 'Login Successful', icon: Icons.login);
          print('Login successfully');
          loginbox.write('islogin', true);
          loginbox.write('userdata', data['data']);
          Get.to(
            () => const MainWidget(),
          );
        }
      } else {
        setLoading(false);
        styledsnackbar(txt: 'Incorrect email or password', icon: Icons.error);

        print(response.reasonPhrase);
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
    required confirmpassword,
  }) async {
    setLoading(true);
    try {
      var response = await post(
          Uri.parse('https://desktopapp.inshopmedia.com/api/register'),
          body: {
            'email': email,
            'password': password,
            'name': username,
            'password_confirmation': confirmpassword
          });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        if (data['data'] == 'null' || data['data'] == null) {
          setLoading(false);
          styledsnackbar(txt: 'Registeration Failed', icon: Icons.error);
        } else {
          setLoading(false);
          styledsnackbar(txt: 'Registeration Successful', icon: Icons.login);
          print(data);
          print('Registered successfully');
          loginbox.write('islogin', true);
          loginbox.write('userdata', data['data']);
          Get.to(
            () => const MainWidget(),
          );
        }
      } else {
        setLoading(false);
        if (response.reasonPhrase == 'Found') {
          styledsnackbar(txt: 'User Already Found', icon: Icons.error);
        } else {
          styledsnackbar(txt: 'Registeration Failed', icon: Icons.error);
        }

        print(response.reasonPhrase);
      }
    } catch (e) {
      setLoading(false);
      styledsnackbar(txt: 'Register Failed', icon: Icons.error);

      print(e.toString());
    }
  }
}
