import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:music_app/constants.dart';
import 'package:music_app/custom%20widgets/custom_icon_button.dart';
import 'package:music_app/player/music_player_ui.dart';
import 'package:music_app/provider/get_playlist_provider.dart';
import 'package:provider/provider.dart';

// class DownloadUi extends StatefulWidget {
//   Map args = {};
//   DownloadUi({super.key, required items}) {
//     args = items;
//   }

//   @override
//   State<DownloadUi> createState() => _DownloadUiState();
// }

class PlaylistUi extends StatelessWidget {
  Map args = {};
  PlaylistUi({super.key, required items}) {
    args = items;
  }
  ValueNotifier<List<bool>> visibiltyvar = ValueNotifier<List<bool>>([]);
  // List visibiltyvar = [];

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      backgroundColor: Colors.grey.shade100.withOpacity(1.0),
      body: Consumer<GetPlaylistProvider>(
          builder: (context, getplaylistprovider, _) {
        getplaylistprovider.userplaylist.isEmpty
            ? getplaylistprovider.getPlaylist(userid: '5')
            : null;
        return getplaylistprovider.islaodinglist
            ? Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: LoadingIndicator(
                    indicatorType: Indicator.ballTrianglePathColoredFilled,
                    colors: [
                      Colors.teal.shade200,
                      Colors.amber.shade300,
                      Colors.red.shade300
                    ],
                    strokeWidth: 1,
                  ),
                ),
              )
            : ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      "My Playlist",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: font_family_bold,
                      ),
                    ),
                  ),
                  GridView.builder(
                    padding: const EdgeInsets.all(5.0),
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 5.0,
                    ),
                    itemCount: getplaylistprovider.userplaylist.length,
                    itemBuilder: (context, index) {
                      visibiltyvar.value.add(false);
                      return InkWell(
                        onTap: () {},
                        hoverColor: Colors.grey.shade100,
                        onHover: ((ishovering) {
                          if (ishovering) {
                            // setState(() {
                            visibiltyvar.value[index] = true;
                            visibiltyvar.notifyListeners();
                            // });
                            print('hovering');
                          } else {
                            visibiltyvar.value[index] = false;
                            visibiltyvar.notifyListeners();

                            // setState(() {});
                            print('not hovering');
                          }
                        }),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    // margin: const EdgeInsets.all(2.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.blueGrey.withOpacity(0.5),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              getplaylistprovider
                                                  .userplaylist[index]
                                                      ['music_img']
                                                  .toString()),
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                ),
                                Text(
                                  getplaylistprovider.userplaylist[index]
                                      ['song_name'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    // backgroundColor:
                                    //     Colors.blueGrey.withOpacity(0.8),
                                    fontSize: 13.0,
                                    color: Colors.black,
                                    fontFamily: font_family,
                                  ),
                                ),
                              ],
                            ),
                            ValueListenableBuilder(
                                valueListenable: visibiltyvar,
                                builder: (context, val, _) {
                                  return Visibility(
                                    visible: val[index],
                                    child: Positioned(
                                      // top: 0,
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 16.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color:
                                              Colors.blueGrey.withOpacity(0.5),
                                        ),
                                        child: Center(
                                          child: CircleAvatar(
                                            backgroundColor: Colors.black54,
                                            child: CustomIconButton(
                                                ontap: () {
                                                  playerbox.write(
                                                      'isplaying', false);
                                                  Get.to(
                                                      () =>
                                                          const MusicPlayerUi(),
                                                      arguments: {
                                                        'isAsset': false,
                                                        'filepath': '',
                                                        'song_id':
                                                            getplaylistprovider
                                                                    .userplaylist[
                                                                index]['id'],
                                                        'song_name':
                                                            getplaylistprovider
                                                                    .userplaylist[
                                                                index]['song_name'],
                                                        'desc':
                                                            getplaylistprovider
                                                                    .userplaylist[
                                                                index]['desc'],
                                                        'artist':
                                                            getplaylistprovider
                                                                    .userplaylist[
                                                                index]['artist'],
                                                        'song_type':
                                                            getplaylistprovider
                                                                    .userplaylist[
                                                                index]['song_type'],
                                                        'language':
                                                            getplaylistprovider
                                                                    .userplaylist[
                                                                index]['language'],
                                                        'song_mp3':
                                                            getplaylistprovider
                                                                    .userplaylist[
                                                                index]['song_mp3'],
                                                        'music_img':
                                                            getplaylistprovider
                                                                    .userplaylist[
                                                                index]['music_img'],
                                                      });
                                                },
                                                icon: Icons.play_arrow),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              );
      }),
    );
  }
}
