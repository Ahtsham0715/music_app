import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:music_app/constants.dart';
import 'package:music_app/custom%20widgets/custom_icon_button.dart';
import 'package:music_app/player/music_player_ui.dart';
import 'package:music_app/provider/get_playlist_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class PlaylistUi extends StatelessWidget {
  PlaylistUi({super.key}) {}
  ValueNotifier<List<bool>> visibiltyvar = ValueNotifier<List<bool>>([]);

  // List visibiltyvar = [];
  List userplaylist = [];

  Future getPlaylist({required String userid}) async {
    print('loading playlist for this user');
    var headers = {'Accept': 'application/json'};

    var url = Uri.parse(
        'https://desktopapp.inshopmedia.com/api/get-playlist?user_id=$userid');

    final response = await http.get(
      url,
      headers: headers,
    );
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      userplaylist = data['data'];
      print(data['data']);
      return userplaylist;
    } else {
      print(response.reasonPhrase.toString());
      return userplaylist;
    }
  }

  // @override
  // void initState() {
  //   print('inistate');
  //   // TODO: implement initState
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      backgroundColor: Colors.grey.shade100.withOpacity(1.0),
      body: FutureBuilder(
          future: getPlaylist(
              userid: loginbox.read('userdata')['data']['id'].toString()),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
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
              );
            } else {
              return ListView(
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
                    itemCount: userplaylist.length,
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
                                              userplaylist[index]['music_img']
                                                  .toString()),
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                ),
                                Text(
                                  userplaylist[index]['song_name'],
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
                                                  musicbox.write(
                                                      'cat_download', false);
                                                  Get.to(
                                                      () =>
                                                          const MusicPlayerUi(),
                                                      arguments: {
                                                        'isAsset': false,
                                                        'issingle': false,
                                                        'filepath': '',
                                                        'cat_id':
                                                            'https://desktopapp.inshopmedia.com/api/get-playlist?user_id=${loginbox.read('userdata')['data']['id'].toString()}',
                                                        'song_id':
                                                            userplaylist[index]
                                                                ['id'],
                                                        'song_name':
                                                            userplaylist[index]
                                                                ['song_name'],
                                                        'desc':
                                                            userplaylist[index]
                                                                ['desc'],
                                                        'artist':
                                                            userplaylist[index]
                                                                ['artist'],
                                                        'song_type':
                                                            userplaylist[index]
                                                                ['song_type'],
                                                        'language':
                                                            userplaylist[index]
                                                                ['language'],
                                                        'song_mp3':
                                                            userplaylist[index]
                                                                ['song_mp3'],
                                                        'music_img':
                                                            userplaylist[index]
                                                                ['music_img'],
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
            }
          }),
    );
  }
}
