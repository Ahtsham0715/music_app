import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:music_app/constants.dart';
import 'package:music_app/custom%20widgets/custom_icon_button.dart';
import 'package:music_app/provider/category_music_provider.dart';
import 'package:music_app/provider/download_provider.dart';
import 'package:music_app/provider/make_playlist_provider.dart';
import 'package:music_app/provider/player_provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class MusicPlayerUi extends StatefulWidget {
  const MusicPlayerUi({super.key});

  @override
  State<MusicPlayerUi> createState() => _MusicPlayerUiState();
}

class _MusicPlayerUiState extends State<MusicPlayerUi> {
  final TextEditingController _search = TextEditingController();
  var args = Get.arguments;
  double _slidervalue = 0.0;
  // dynamic playerprovider;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AudioPlayerProvider>(context, listen: false).setPlaying(true);
      // Provider.of<AudioPlayerProvider>(context, listen: false).setPlaying(true);
      if (args['isAsset'] && !playerbox.read('isplaying')) {
        Provider.of<AudioPlayerProvider>(context, listen: false)
            .playfromAsset(args['filepath']);
      } else if (!args['isAsset'] && !playerbox.read('isplaying')) {
        Provider.of<AudioPlayerProvider>(context, listen: false)
            .playfromUrl(args['song_mp3']);
        print(args['song_mp3']);
      }
      musicbox.read('cat_download')
          ? null
          : Provider.of<CategoryMusicProvider>(context, listen: false)
              .getCategoryMusic(
              id: args['cat_id'],
              isplaylist:
                  args['cat_id'].toString().contains('https') ? true : false,
            );
      Provider.of<DownloadProvider>(context, listen: false)
          .setLoadingListLength(
              Provider.of<CategoryMusicProvider>(context, listen: false)
                  .categorymusic
                  .length);
      Provider.of<MakePlaylistProvider>(context, listen: false)
          .setLoadingListLength(
              Provider.of<CategoryMusicProvider>(context, listen: false)
                  .categorymusic
                  .length);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    final downloadprovider =
        Provider.of<DownloadProvider>(context, listen: false);
    final createplaylistpro =
        Provider.of<MakePlaylistProvider>(context, listen: false);
    final playerprovider =
        Provider.of<AudioPlayerProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0.0,
        // leadingWidth: 150.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        toolbarHeight: 50.0,
        title: Center(
          child: Text(
            'InshopMedia Player',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.black,
              fontFamily: font_family,
            ),
          ),
        ),

        actions: [
          Center(
            child: Text(
              loginbox.read('userdata')['data']['name'].toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.0,
                fontFamily: font_family,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              child: const Icon(
                Icons.person,
                color: Colors.black45,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.75,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: args['isAsset'] || args['issingle']
                      ? MediaQuery.of(context).size.width
                      : MediaQuery.of(context).size.width * 0.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.width * 0.25,
                        padding: const EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2.0),
                            borderRadius: BorderRadius.circular(5.0)),
                        child: args['isAsset']
                            ? Image.asset('assets/logo.png')
                            : Image.network(
                                args['music_img'],
                                fit: BoxFit.fill,
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          args['song_name'].toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            fontFamily: font_family_bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(
                          args['isAsset']
                              ? 'Unknown'
                              : args['artist'].toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: font_family,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                args['isAsset'] || args['issingle']
                    ? const Center()
                    : SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, left: 25.0),
                              child: ListTile(
                                title: Text(
                                  "Queue",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontFamily: font_family,
                                  ),
                                ),
                                trailing: Padding(
                                  padding: const EdgeInsets.only(right: 50.0),
                                  child: Consumer<DownloadProvider>(
                                      builder: (context, downloadpro, _) {
                                    return downloadpro.isloading
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: CircularPercentIndicator(
                                              radius: 20.0,
                                              lineWidth: 3.0,
                                              percent:
                                                  downloadpro.percentageVal,
                                              center: Text(
                                                "${downloadpro.percentage}%",
                                                style: TextStyle(
                                                    fontSize: 10.0,
                                                    // fontWeight: FontWeight.w500,
                                                    color: Colors.black,
                                                    fontFamily: font_family),
                                              ),
                                              progressColor: Colors.teal,
                                            ),
                                          )
                                        : MaterialButton(
                                            onPressed: downloadpro.isloadinglist
                                                        .contains(true) ||
                                                    downloadprovider.isloading
                                                ? null
                                                : () {
                                                    downloadpro.downloadFile(
                                                      url: args['song_mp3']
                                                          .toString(),
                                                      isList: false,
                                                      filename:
                                                          args['song_name'],
                                                    );
                                                  },
                                            color: Colors.teal.shade200,
                                            elevation: 0.0,
                                            shape: const StadiumBorder(),
                                            minWidth: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.01,
                                            // height: MediaQuery.of(context).size.height * 0.07,
                                            child: Text(
                                              'Download',
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  // fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                                  fontFamily: font_family),
                                            ),
                                          );
                                  }),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 25.0),
                              child: Divider(
                                indent: 15.0,
                                endIndent: 45.0,
                                color: Colors.grey.shade400.withOpacity(0.7),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.5,
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: Consumer<CategoryMusicProvider>(
                                  builder: (context, catmusicpro, _) {
                                // musicbox.read('cat_download')
                                //     ? null
                                //     : catmusicpro.getCategoryMusic(
                                //         id: args['cat_id'],
                                //         isplaylist: args['cat_id']
                                //                 .toString()
                                //                 .contains('https')
                                //             ? true
                                //             : false,
                                //       );
                                // downloadprovider.setLoadingListLength(
                                //     catmusicpro.categorymusic.length);
                                // createplaylistpro.setLoadingListLength(
                                //     catmusicpro.categorymusic.length);
                                return catmusicpro.isloadingmusic
                                    ? Center(
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.15,
                                          child: LoadingIndicator(
                                            indicatorType: Indicator
                                                .ballTrianglePathColoredFilled,
                                            colors: [
                                              Colors.teal.shade200,
                                              Colors.amber.shade300,
                                              Colors.red.shade300
                                            ],
                                            strokeWidth: 1,
                                          ),
                                        ),
                                      )
                                    : ListView.builder(
                                        itemCount:
                                            catmusicpro.categorymusic.length,
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                            leading: CircleAvatar(
                                              backgroundColor:
                                                  Colors.grey.shade100,
                                              foregroundImage: NetworkImage(
                                                  catmusicpro
                                                          .categorymusic[index]
                                                      ['music_img']),
                                              child: const Icon(
                                                Icons.music_note,
                                                size: 30.0,
                                                color: Colors.teal,
                                              ),
                                            ),
                                            title: Text(
                                              catmusicpro.categorymusic[index]
                                                      ['song_name']
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                fontFamily: font_family_bold,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            subtitle: Text(
                                              catmusicpro.categorymusic[index]
                                                      ['artist']
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 13.0,
                                                fontFamily: font_family,
                                              ),
                                            ),
                                            trailing:
                                                Consumer<DownloadProvider>(
                                                    builder: (context,
                                                        downloadprovider, _) {
                                              return ButtonBar(
                                                mainAxisSize: MainAxisSize.min,
                                                alignment: MainAxisAlignment
                                                    .spaceEvenly,
                                                children: [
                                                  Consumer<
                                                          MakePlaylistProvider>(
                                                      builder: (context,
                                                          makeplaylistpro, _) {
                                                    return makeplaylistpro
                                                            .isaddinglist[index]
                                                        ? const CircularProgressIndicator(
                                                            color: Colors.teal,
                                                          )
                                                        : IconButton(
                                                            onPressed: () {
                                                              makeplaylistpro.AddToPlaylist(
                                                                  songid: catmusicpro
                                                                          .categorymusic[
                                                                      index]['id'],
                                                                  id: index);
                                                            },
                                                            icon: Icon(
                                                              Icons.add,
                                                              color: Colors
                                                                  .grey.shade800
                                                                  .withOpacity(
                                                                      0.7),
                                                              // size: 25.0,
                                                            ),
                                                          );
                                                  }),
                                                  downloadprovider
                                                          .isloadinglist[index]
                                                      ? CircularPercentIndicator(
                                                          radius: 16.0,
                                                          lineWidth: 3.0,
                                                          percent:
                                                              downloadprovider
                                                                  .percentageVal,
                                                          center: Text(
                                                            "${downloadprovider.percentage}%",
                                                            style: TextStyle(
                                                                fontSize: 9.0,
                                                                // fontWeight: FontWeight.w500,
                                                                color: Colors
                                                                    .black,
                                                                fontFamily:
                                                                    font_family),
                                                          ),
                                                          progressColor:
                                                              Colors.teal,
                                                        )
                                                      : IconButton(
                                                          onPressed: downloadprovider
                                                                      .isloadinglist
                                                                      .contains(
                                                                          true) ||
                                                                  downloadprovider
                                                                      .isloading
                                                              ? null
                                                              : () {
                                                                  downloadprovider
                                                                      .downloadFile(
                                                                    url: catmusicpro
                                                                            .categorymusic[index]
                                                                        [
                                                                        'song_mp3'],
                                                                    isList:
                                                                        true,
                                                                    id: index,
                                                                    filename: args[
                                                                        'song_name'],
                                                                  );
                                                                },
                                                          icon: Icon(
                                                            Icons.download,
                                                            color: Colors
                                                                .grey.shade800
                                                                .withOpacity(
                                                                    0.7),
                                                            // size: 25.0,
                                                          ),
                                                        ),
                                                  // Text(
                                                  //   "6:11",
                                                  //   style: TextStyle(
                                                  //     fontSize: 13.0,
                                                  //     fontFamily: font_family,
                                                  //   ),
                                                  // ),
                                                ],
                                              );
                                            }),
                                          );
                                        },
                                      );
                              }),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.005,
            width: MediaQuery.of(context).size.width,
            child:
                Consumer<AudioPlayerProvider>(builder: (context, playerpro, _) {
              return Slider(
                min: 0.0,
                max: playerpro.maxduration,
                value: playerpro.seekpossec,
                onChanged: (value) {
                  playerpro.seekDuration(value.toInt());
                  print(value);
                },
                activeColor: Colors.teal.shade200,
                inactiveColor: Colors.grey.shade300,
                // color: Colors.teal.shade300,
              );
            }),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.width,
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
                    size: 28.0,
                    ontap: () {
                      playerpro.setLoop(!playerpro.loop);
                      print(playerbox.read('loop'));
                    },
                  ),
                  CustomIconButton(
                    icon: FontAwesomeIcons.backwardStep,
                    ontap: args['issingle']
                        ? null
                        : () {
                            print('previous song');
                            List songs = args['songs_list'];
                            for (var i = 0; i < songs.length; i++) {
                              if (songs[i]['id'] == args['id']) {
                                if (i >= 1) {
                                  args['music_img'] = songs[i - 1]['music_img'];
                                  args['song_mp3'] = songs[i - 1]['song_mp3'];
                                  args['song_name'] = songs[i - 1]['song_name'];
                                  args['artist'] = songs[i - 1]['artist'];
                                  setState(() {});
                                  playerprovider
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
                      radius: 30.0,
                      child: CustomIconButton(
                        icon: playerpro.isplaying
                            ? FontAwesomeIcons.pause
                            : FontAwesomeIcons.play,
                        size: 25.0,
                        hovercolor: Colors.transparent,
                        ontap: () {
                          // setState(() {});
                          playerpro.isplaying
                              ? playerpro.pauseAudio()
                              : playerpro.resumeAudio();
                        },
                      ),
                    ),
                  ),
                  CustomIconButton(
                    icon: FontAwesomeIcons.forwardStep,
                    ontap: args['issingle']
                        ? null
                        : () {
                            print('Next song');
                            List songs = args['songs_list'];
                            for (int i = 0; i < songs.length; i++) {
                              print(songs[i]['id']);
                              print(args['song_id']);
                              // if (songs[i]['id'] == args['song_id']) {
                              //   if (i < songs.length - 1) {
                              //     args['music_img'] = songs[i - 1]['music_img'];
                              //     args['song_mp3'] = songs[i - 1]['song_mp3'];
                              //     args['song_name'] = songs[i - 1]['song_name'];
                              //     args['artist'] = songs[i - 1]['artist'];
                              //     args['song_id'] = songs[i - 1]['id'];
                              //     // playerprovider.dispose();
                              //     playerprovider
                              //         .playfromUrl(songs[i - 1]['song_mp3']);
                              //     setState(() {});
                              //   }
                              // }
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
                    "${playerpro.seekpos}/${playerpro.duration} ",
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
                    ontap: () {
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
                              MediaQuery.of(context).size.height * 0.80,
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
                    },
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
