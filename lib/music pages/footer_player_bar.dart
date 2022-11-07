import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:music_app/constants.dart';
import 'package:music_app/custom%20widgets/custom_icon_button.dart';
import 'package:music_app/provider/player_provider.dart';
import 'package:provider/provider.dart';

class FooterPlayerBar extends StatefulWidget {
  const FooterPlayerBar({super.key});

  @override
  State<FooterPlayerBar> createState() => _FooterPlayerBarState();
}

class _FooterPlayerBarState extends State<FooterPlayerBar> {
  var args = playerbox.read('songs_data');
  @override
  Widget build(BuildContext context) {
    final playerprovider =
        Provider.of<AudioPlayerProvider>(context, listen: false);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.005,
          // width: MediaQuery.of(context).size.width,
          child:
              Consumer<AudioPlayerProvider>(builder: (context, playerpro, _) {
            return Slider(
              min: 0.0,
              max: playerpro.maxduration,
              value: playerpro.seekpossec,
              onChanged: playerbox.read('isplaying')
                  ? (value) {
                      playerpro.seekDuration(value.toInt());
                      // print(value);
                    }
                  : null,
              activeColor: Colors.teal.shade200,
              inactiveColor: Colors.grey.shade300,
              // color: Colors.teal.shade300,
            );
          }),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.07,
          // width: MediaQuery.of(context).size.width,
          child:
              Consumer<AudioPlayerProvider>(builder: (context, playerpro, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomIconButton(
                  icon: playerpro.loop
                      ? Icons.repeat_one_rounded
                      : Icons.repeat_rounded,
                  size: 20.0,
                  ontap: playerbox.read('isplaying')
                      ? () {
                          playerpro.setLoop(!playerpro.loop);
                          print(playerbox.read('loop'));
                        }
                      : null,
                ),
                CustomIconButton(
                  icon: FontAwesomeIcons.backwardStep,
                  size: 20.0,
                  ontap: args['issingle']
                      ? null
                      : () async {
                          print('previous song');
                          List songs = args['songs_list'];
                          for (var i = 0; i < songs.length; i++) {
                            if (songs[i]['id'] == args['song_id']) {
                              if (i >= 1) {
                                args['music_img'] = songs[i - 1]['music_img'];
                                playerpro
                                    .setSongImage(songs[i - 1]['music_img']);
                                args['song_mp3'] = songs[i - 1]['song_mp3'];
                                args['song_name'] = songs[i - 1]['song_name'];
                                playerpro
                                    .setSongName(songs[i - 1]['song_name']);
                                args['artist'] = songs[i - 1]['artist'];
                                playerpro.setArtistName(songs[i - 1]['artist']);
                                args['song_id'] = songs[i - 1]['id'];
                                playerbox.write('songs_data', {
                                  'songs_list': args['songs_list'],
                                  'current_song': songs[i - 1]['id'],
                                });
                                args['isAsset']
                                    ? playerprovider.playfromAsset(
                                        songs[i - 1]['song_mp3'],
                                        issingle: args['issingle'],
                                        songslist: args['songs_list'],
                                        currentid: args['song_id'])
                                    : playerprovider
                                        .playfromUrl(songs[i - 1]['song_mp3']);
                              }
                            }
                          }
                        },
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.teal.shade400.withOpacity(0.5),
                    radius: 20.0,
                    child: CustomIconButton(
                      icon: playerpro.isplaying
                          ? FontAwesomeIcons.pause
                          : FontAwesomeIcons.play,
                      size: 18.0,
                      hovercolor: Colors.transparent,
                      ontap: playerbox.read('isplaying')
                          ? () {
                              // setState(() {});
                              playerpro.isplaying
                                  ? playerpro.pauseAudio()
                                  : playerpro.resumeAudio();
                            }
                          : null,
                    ),
                  ),
                ),
                CustomIconButton(
                  icon: FontAwesomeIcons.forwardStep,
                  size: 20.0,
                  ontap: args['issingle']
                      ? null
                      : () async {
                          print('Next song');
                          List songs = args['songs_list'];
                          print(songs);
                          for (int i = 0; i < songs.length; i++) {
                            print(songs[i]['id']);
                            print(args['song_id']);
                            if (songs[i]['id'] == args['song_id']) {
                              if (i < songs.length - 1) {
                                args['music_img'] = songs[i + 1]['music_img'];
                                playerpro
                                    .setSongImage(songs[i + 1]['music_img']);
                                args['song_mp3'] = songs[i + 1]['song_mp3'];
                                args['song_name'] = songs[i + 1]['song_name'];
                                playerpro
                                    .setSongName(songs[i + 1]['song_name']);
                                args['artist'] = songs[i + 1]['artist'];
                                playerpro.setArtistName(songs[i + 1]['artist']);
                                args['song_id'] = songs[i + 1]['id'];
                                // setState(() {});
                                playerbox.write('songs_data', {
                                  'songs_list': args['songs_list'],
                                  'current_song': songs[i + 1]['id'],
                                });
                                // playerprovider.dispose();
                                args['isAsset']
                                    ? playerprovider.playfromAsset(
                                        songs[i + 1]['song_mp3'],
                                        issingle: args['issingle'],
                                        songslist: args['songs_list'],
                                        currentid: args['song_id'])
                                    : playerprovider
                                        .playfromUrl(songs[i + 1]['song_mp3']);
                              }
                            }
                          }
                        },
                ),
                // CustomIconButton(
                //   icon: FontAwesomeIcons.shuffle,
                //   ontap: () {},
                // ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                ),
                Text(
                  playerbox.read('isplaying')
                      ? "${playerpro.seekpos}/${playerpro.duration} "
                      : "0:0:0/0:0:0",
                  style: TextStyle(
                    fontSize: 13.0,
                    fontFamily: font_family,
                  ),
                ),
                // CustomIconButton(
                //   icon: FontAwesomeIcons.ellipsis,
                //   ontap: () {},
                // ),
                CustomIconButton(
                  icon: FontAwesomeIcons.volumeHigh,
                  size: 20.0,
                  ontap: playerbox.read('isplaying')
                      ? () {
                          print('menu build');
                          showMenu(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              // elevation: 0.0,
                              color: Colors.grey.shade300,
                              context: context,
                              position: RelativeRect.fromLTRB(
                                  MediaQuery.of(context).size.width * 0.01,
                                  MediaQuery.of(context).size.height * 0.85,
                                  10,
                                  0.0),
                              items: [
                                PopupMenuItem(
                                  child: Row(
                                    children: [
                                      const Icon(
                                        FontAwesomeIcons.volumeLow,
                                        color: Colors.black,
                                        size: 25.0,
                                      ),
                                      StatefulBuilder(
                                          builder: (context, innerstate) {
                                        return Slider(
                                          min: 0,
                                          max: 1,
                                          inactiveColor: Colors.grey.shade400,
                                          activeColor: Colors.green,
                                          value: playerpro.volume,
                                          onChanged: (value) {
                                            playerpro
                                                .changeVolume(value.toDouble());
                                            innerstate(() {});
                                          },
                                        );
                                      }),
                                    ],
                                  ),
                                )
                              ]);
                        }
                      : null,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
              ],
            );
          }),
        ),
      ],
    );
  }
}
