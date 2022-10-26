import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class DownloadProvider with ChangeNotifier {
  bool _isloading = false;
  dynamic _percentage = 0;
  dynamic _percentageVal = 0.0;

  bool get isloading => _isloading;
  get percentage => _percentage;
  get percentageVal => _percentageVal;

  setLoading(bool value) {
    _isloading = value;
    notifyListeners();
  }

  setPercentage(value) {
    _percentage = value;
    notifyListeners();
  }

  setPercentageVal(value) {
    _percentageVal = value;
    notifyListeners();
  }

  Future downloadFile({required url}) async {
    setLoading(true);
    Directory? downloadDir = await getDownloadsDirectory();
    String downloadPath = downloadDir!.path;
    print(downloadPath);
    // var url = 'https://gaana.com/song/mitti-de-tibbe';
    // var filename = url.toString().split('/').last;
    var filename = 'new song.mp3';
    print(filename);
    try {
      await Dio().download(
        url,
        "$downloadPath/inshopmedia_downloads/$filename",
        onReceiveProgress: (rec, total) {
          print('rec: $rec  total:$total');
          var perc = rec / total * 100;
          print(perc);
          setPercentage(perc.toInt());
          setPercentageVal((perc / 100).toDouble());
        },
      );
      print("Download Completed.");
      setLoading(false);
    } catch (e) {
      setLoading(false);
      print("Download Failed.\n\n$e");
    }
  }
}
