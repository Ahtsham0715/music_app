import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:music_app/custom%20widgets/utils.dart';
import 'package:music_app/constants.dart';

class AudioPlayerProvider with ChangeNotifier {
  final AudioPlayer _player = AudioPlayer(playerId: 'local');
  AudioCache cache = AudioCache();
  late bool _isplaying;
  bool _loop = playerbox.read('loop') ?? false;
  dynamic _duration = 0;
  dynamic _maxduration = 0.0;
  dynamic _seekpos = 0;
  dynamic _seekpossec = 0.0;
  double _volume = 0.3;

  get isplaying => _isplaying;

  setPlaying(bool value) {
    _isplaying = value;
    notifyListeners();
  }

  setLoop(bool loopval) {
    playerbox.write('loop', loopval);
    _loop = loopval;
    notifyListeners();
  }

  get duration => _duration;
  get maxduration => _maxduration;
  get seekpos => _seekpos;
  get seekpossec => _seekpossec;
  get volume => _volume;
  get loop => _loop;

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

  Future onComplete() async {
    if (playerbox.read('loop')) {
      await _player.setReleaseMode(ReleaseMode.loop);
    } else {
      await _player.setReleaseMode(ReleaseMode.release);
      playerbox.write('isplaying', false);
    }
  }

  Future playfromAsset(path) async {
    playerbox.write('isplaying', true);
    try {
      print(_player.state.name);
      setPlaying(true);
      await _player.play(DeviceFileSource(path));
      _player.onPlayerComplete.listen((event) {
        onComplete();
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
