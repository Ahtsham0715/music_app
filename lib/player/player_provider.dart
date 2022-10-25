import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:music_app/custom%20widgets/utils.dart';

class AudioPlayerProvider with ChangeNotifier {
  static final _player = AudioPlayer(playerId: 'local');

  bool _isplaying = false;
  dynamic _duration = 0;
  dynamic _maxduration = 0;
  dynamic _seekpos = 0;
  dynamic _seekpossec = 0;
  double _volume = 0.4;

  get isplaying => _isplaying;

  setPlaying(bool value) {
    _isplaying = value;
    notifyListeners();
  }

  get duration => _duration;
  get maxduration => _maxduration;
  get seekpos => _seekpos;
  get seekpossec => _seekpossec;
  get volume => _volume;

  setDuration(durationVal) {
    _duration = durationVal;
    notifyListeners();
  }

  setVolume(volume) {
    _volume = volume;
    notifyListeners();
  }

  setMaxDuration(maxdurationVal) {
    _maxduration = maxdurationVal;
    notifyListeners();
  }

  setSeekPos(seekVal) {
    _seekpos = seekVal;
    notifyListeners();
  }

  setSeekPosSec(secseekVal) {
    _seekpossec = secseekVal;
    notifyListeners();
  }

  Future playfromAsset(path) async {
    try {
      setPlaying(true);
      await _player.play(DeviceFileSource(path));
      _player.onPlayerComplete.listen((event) {
        setSeekPos('00:00:00');
        setDuration('00:00:00');
        stopAudio();
      });
      _player.onPositionChanged.listen((Duration p) => {
            setSeekPosSec(p.inSeconds.toDouble()),
            setSeekPos(p.toString().split('.')[0]),
          });
      _player.onDurationChanged.listen((Duration d) {
        setMaxDuration(d.inSeconds.toDouble());
        print('Max duration: ${d.abs()}');
        setDuration(d.toString().split('.')[0]);
        // setDuration('${d.inHours}:${d.inMinutes}:${d.inSeconds.floor()}');
      });
    } catch (e) {
      setPlaying(false);
      styledsnackbar(txt: 'An occured while loading file');
      print(e);
    }
  }

  Future seekDuration(val) async {
    print(val);
    await _player.seek(Duration(
      seconds: val,
    ));
    setSeekPosSec(val);
  }

  Future changeVolume(vol) async {
    await _player.setVolume(vol);
    setVolume(vol);
  }

  Future pauseAudio() async {
    print('paused');
    setPlaying(false);
    _player.pause();
  }

  Future stopAudio() async {
    print('stopped');
    setPlaying(false);
    _player.stop();
  }

  Future resumeAudio() async {
    print('resumed');
    setPlaying(true);
    _player.resume();
  }
}
