import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:music_app/custom%20widgets/utils.dart';

class AudioPlayerProvider with ChangeNotifier {
  static final _player = AudioPlayer(playerId: 'local');

  var _isplaying = 'loading';
  dynamic _duration = 0;
  dynamic _sliderval = 0;

  get isplaying => _isplaying;

  setPlaying(value) {
    _isplaying = value;
    // notifyListeners();
  }

  get duration => _duration;
  get sliderval => _sliderval;

  setDuration(durationVal) {
    _duration = durationVal;
    // notifyListeners();
  }

  setSlidervalue(sliderVal) {
    _sliderval = sliderVal;
    // notifyListeners();
  }

  Future playfromAsset(path) async {
    try {
      setPlaying('playing');
      await _player.play(DeviceFileSource(path));
    } catch (e) {
      setPlaying('loading');
      styledsnackbar(txt: 'An occured while loading file');
      print(e);
    }
  }

  // Future playAudio() async {}

  Future pauseAudio() async {
    print('paused');
    setPlaying('paused');
    _player.pause();
  }

  Future stopAudio() async {
    print('stopped');
    setPlaying('stop');
    _player.stop();
  }

  Future resumeAudio() async {
    print('resumed');
    setPlaying('resume');
    _player.resume();
  }
}

// class ProgressBarState {
//   ProgressBarState({
//     required this.current,
//     required this.buffered,
//     required this.total,
//   });
//   final Duration current;
//   final Duration buffered;
//   final Duration total;
// }

// enum ButtonState { paused, playing, stopped }
