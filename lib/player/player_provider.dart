import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

class AudioPlayerProvider with ChangeNotifier {
  static final _player = AudioPlayer();

  bool _isplaying = false;
  dynamic _duration = 0;
  dynamic _sliderval = 0;

  bool get isplaying => _isplaying;

  setPlaying(bool value) {
    _isplaying = value;
    notifyListeners();
  }

  get duration => _duration;
  get sliderval => _sliderval;

  setDuration(durationVal) {
    _duration = durationVal;
    notifyListeners();
  }

  setSlidervalue(sliderVal) {
    _sliderval = sliderVal;
    notifyListeners();
  }

  Future playfromAsset(path) async {
    try {
      Stream source = await _player.setSourceDeviceFile(path).asStream();
      playAudio(src: _duration);
    } catch (e) {
      print(e);
    }
  }

  Future playAudio({src}) async {
    await _player.play(
      src,
      mode: PlayerMode.mediaPlayer,
    );
  }

  Future pauseAudio() async {
    setPlaying(false);
    await _player.pause();
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

// enum ButtonState { paused, playing, loading }
