import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_app/custom%20widgets/customalert.dart';

class ConnectivityChecker {
  static final ConnectivityResult _connectionStatus = ConnectivityResult.none;
  static final Connectivity _connectivity = Connectivity();
  static Future<bool> CheckConnection() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
      //  var connectivityResult = await (Connectivity().checkConnectivity());
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi ||
          result == ConnectivityResult.ethernet ||
          result == ConnectivityResult.vpn) {
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
//  Future checkconnectivity(context) async {
//     if (await CheckConnection()) {
//     } else {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) => const customAlert(),
//         barrierDismissible: false,
//       );
//     }
//   }

}
