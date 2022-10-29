import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class DownloadProvider with ChangeNotifier {
  bool _isloading = false;
  List<bool> isloadinglist = [];
  dynamic _percentage = 0;
  dynamic _percentageVal = 0.0;

  bool get isloading => _isloading;
  // List<bool> get isloadinglist => _isloadinglist;
  get percentage => _percentage;
  get percentageVal => _percentageVal;

  setLoading(bool value) {
    _isloading = value;
    notifyListeners();
  }

  setLoadingList(bool value, index) {
    isloadinglist[index] = value;
    notifyListeners();
  }

  setLoadingListLength(length) {
    for (int i = 0; i < length; i++) {
      isloadinglist.add(false);
    }
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

  Future downloadFile(
      {required url, required isList, id, required filename}) async {
    setPercentage(0);
    setPercentageVal(0.0);
    if (isList) {
      setLoadingList(true, id);
    } else {
      setLoading(true);
    }

    Directory? downloadDir = await getDownloadsDirectory();
    String downloadPath = downloadDir!.path;
    print(downloadPath);
    // var url = 'https://gaana.com/song/mitti-de-tibbe';
    // var filename = url.toString().split('/').last;
    print(filename);
    try {
      await Dio().download(
        url,
        "$downloadPath/inshopmedia_downloads/$filename.mp3",
        onReceiveProgress: (rec, total) {
          print('rec: $rec  total:$total');
          var perc = rec / total * 100;
          // print(perc);
          setPercentage(perc.toInt());
          setPercentageVal((perc / 100).toDouble());
        },
      );
      print("Download Completed.");

      if (isList) {
        setLoadingList(false, id);
      } else {
        setLoading(false);
      }
    } catch (e) {
      if (isList) {
        setLoadingList(false, id);
      } else {
        setLoading(false);
      }
      print("Download Failed.\n\n$e");
    }
  }
}
