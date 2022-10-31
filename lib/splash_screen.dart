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
  final ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  @override
  void initState() {
    super.initState();
    initTimer();
  }

  Future<bool> CheckConnection() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
      //  var connectivityResult = await (Connectivity().checkConnectivity());
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        print('connection available');
        return true;
      } else {
        print('connection unavailable');
        return false;
      }
    } on PlatformException catch (e) {
      print('Couldn\'t check connectivity status error: $e');
      print('connection unavailable');
      return false;
    }
  }

  Future<void> initTimer() async {
    if (await CheckConnection()) {
      Timer(const Duration(seconds: 3), () async {
        print(loginbox.read('islogin'));
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
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) =>
            WillPopScope(onWillPop: () async => false, child: customAlert()),
        barrierDismissible: false,
      );
      //  customAlert();
    }
  }

  Widget customAlert() {
    // SplashWidget().showSplashLogo();
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.32,
        // vertical: MediaQuery.of(context).size.width * 0.3,
      ),
      actionsPadding: const EdgeInsets.only(bottom: 10.0),
      title: Icon(
        CupertinoIcons.exclamationmark_circle_fill,
        color: Colors.red[400],
        size: 70.0,
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: const Text(
          'No internet available! Please\nReconnect and try again',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18.0,
              // color: Colors.black,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.0),
        ),
      ),
      actions: [
        Center(
          child: TextButton(
            onPressed: () async {
              exit(0);
            },
            style: TextButton.styleFrom(
              minimumSize: Size(MediaQuery.of(context).size.width * 0.3,
                  MediaQuery.of(context).size.height * 0.06),
              maximumSize: Size(MediaQuery.of(context).size.width * 0.35,
                  MediaQuery.of(context).size.height * 0.06),
              foregroundColor: Colors.black,
              backgroundColor: Colors.grey[350],
              elevation: 2.0,
              textStyle: const TextStyle(
                  fontSize: 20, fontFamily: "Viga", color: Colors.black),
            ),
            child: const Text('ok'),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/splash.gif'),
          ),
        ),
      ),
    );
  }
}
