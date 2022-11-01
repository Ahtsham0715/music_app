import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:music_app/auth/login_ui.dart';
import 'package:music_app/constants.dart';
import 'package:music_app/custom%20widgets/utils.dart';
import 'package:music_app/music%20pages/main_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initTimer();
  }

  Future<void> initTimer() async {
    Timer(const Duration(seconds: 3), () async {
      // print(loginbox.read('islogin'));
      if (loginbox.read('islogin') == false ||
          loginbox.read('islogin') == null) {
        // pehly != tha
        Get.to(
          () => const LoginUi(),
        );
      } else {
        print(loginbox.read('userdata')['data']);
        if (loginbox.read('userdata')['data'] == null ||
            loginbox.read('userdata')['data'] == 'null') {
          Get.to(
            () => const LoginUi(),
          );
          styledsnackbar(txt: 'User Not Found', icon: Icons.error);
        } else {
          Get.to(() => const MainWidget());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/splash.gif'),
          ),
        ),
      ),
    );
  }
}
