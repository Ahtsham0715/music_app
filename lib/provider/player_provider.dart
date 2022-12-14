import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_app/custom%20widgets/utils.dart';
import 'package:music_app/constants.dart';

class AudioPlayerProvider with ChangeNotifier {
  final AudioPlayer _player = AudioPlayer(playerId: 'local');
  AudioCache cache = AudioCache();
  late bool _isplaying = false;
  bool _loop = playerbox.read('loop');
  dynamic _duration = 0.0;
  dynamic _maxduration = 0.1;
  dynamic _seekpos = 0.0;
  dynamic _seekpossec = 0.0;
  double _volume = 0.3;
  String _songimage = '';
  String _songname = '';
  String _artistname = '';

  get isplaying => _isplaying;
  get songimage => _songimage;
  get songname => _songname;
  get artistname => _artistname;

  setPlaying(bool value) {
    _isplaying = value;
    notifyListeners();
  }

  setSongName(String value) {
    _songname = value;
    notifyListeners();
  }

  setSongImage(String value) {
    _songimage = value;
    notifyListeners();
  }

  setArtistName(String value) {
    _artistname = value;
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

  Future onComplete({songsList, required isSingle, currentId}) async {
    print('in oncomplete func');
    if (playerbox.read('loop')) {
      await _player.setReleaseMode(ReleaseMode.loop);
    } else {
      if (isSingle) {
        await _player.setReleaseMode(ReleaseMode.release);
        // playerbox.write('isplaying', false);
      } else {
        await _player.setReleaseMode(ReleaseMode.stop);
        // playerbox.write('isplaying', false);
        for (var i = 0; i < songsList.length; i++) {
          if (songsList[i]['id'] == currentId.toString()) {
            if (currentId == songsList[songsList.length - 1]['id']) {
              await _player.setReleaseMode(ReleaseMode.release);
              playerbox.write('isplaying', false);
              stopAudio();
            } else {
              if (i < songsList.length - 1) {
                print(songsList[i + 1]['song_mp3']);
                print('matched id: ${songsList[i + 1]['id']}');
                setSongImage(songsList[i + 1]['music_img']);
                setSongName(songsList[i + 1]['song_name']);
                setArtistName(songsList[i + 1]['artist']);
                playfromAsset(songsList[i + 1]['song_mp3'],
                    songslist: songsList,
                    issingle: isSingle,
                    currentid: songsList[i + 1]['id']);
                playerbox.write('songs_data', {
                  'songs_list': songsList,
                  'song_id': songsList[i + 1]['id'],
                  'issingle': isSingle,
                  'isAsset': true,
                });
              } else {
                // print(songsList[0]['song_mp3']);
                // playfromAsset(songsList[0]['song_mp3'],
                //     songslist: songsList,
                //     issingle: isSingle,
                //     currentid: songsList[0]['id']);
                await _player.setReleaseMode(ReleaseMode.stop);
                playerbox.write('isplaying', false);
              }
            }
          }
        }
      }
    }
  }

  Future playfromAsset(path,
      {required songslist, required issingle, required currentid}) async {
    playerbox.write('isplaying', true);
    try {
      print(_player.state.name);
      setPlaying(true);
      await _player.play(DeviceFileSource(path));
      _player.onPlayerComplete.listen((event) {
        print('on complete event fired.');
        onComplete(
          isSingle: issingle,
          currentId: currentid,
          songsList: songslist,
        );
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
        setDuration(d.toString().split('.')[0]);
        // setDuration('${d.inHours}:${d.inMinutes}:${d.inSeconds.floor()}');
      });
    } catch (e) {
      setPlaying(false);
      styledsnackbar(txt: 'An occured while loading file');
      print(e);
    }
  }

  Future playfromUrl(path) async {
    playerbox.write('isplaying', true);
    try {
      print(_player.state.name);
      setPlaying(true);
      await _player.play(UrlSource(path));
      _player.onPlayerComplete.listen((event) {
        onComplete(isSingle: false);
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
