import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerProvider with ChangeNotifier {
  final progressNotifier = ValueNotifier<ProgressBarState>(
    ProgressBarState(
      current: Duration.zero,
      buffered: Duration.zero,
      total: Duration.zero,
    ),
  );

  static final _player = AudioPlayer();

  bool _isplaying = _player.playerState.playing;
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
      final thisduration = await _player.setFilePath(
        path,
        preload: false,
      );
      setDuration(thisduration?.inMinutes);
      print('Duration: ${thisduration?.inMinutes}');
      playAudio();
    } catch (e) {
      print(e);
    }
  }

  Future playAudio() async {
    await _player.play();
  }

  Future pauseAudio() async {
    setPlaying(false);
    await _player.pause();
  }
}

class ProgressBarState {
  ProgressBarState({
    required this.current,
    required this.buffered,
    required this.total,
  });
  final Duration current;
  final Duration buffered;
  final Duration total;
}

enum ButtonState { paused, playing, loading }
