import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:music_app/constants.dart';
import 'package:music_app/custom%20widgets/custom_icon_button.dart';
import 'package:music_app/player/music_player_ui.dart';
import 'package:music_app/provider/allcategories_music_provider.dart';
import 'package:music_app/provider/categories_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class CategoriesUi extends StatefulWidget {
  CategoriesUi({super.key});

  @override
  State<CategoriesUi> createState() => _CategoriesUiState();
}

class _CategoriesUiState extends State<CategoriesUi> {
  Map allmusic = {};
  List cats = [];

  Future getMusic() async {
    // allmusic = {};
    if (allmusic.isEmpty) {
      var headers = {'Accept': 'application/json'};
      cats = musicbox.read('cats');
      if (cats.isNotEmpty) {
        for (var cat in cats) {
          print(cat['id']);
          print('fetching music for category_id: ${cat['id']}');

          var url = Uri.parse(
              'https://desktopapp.inshopmedia.com/api/music-list?category_id=${cat['id']}');

          final response = await http.get(
            url,
            headers: headers,
          );
          var data = jsonDecode(response.body);
          if (response.statusCode == 200) {
            // if (data['data'].length != 0) {
            //   allmusic[cat['id']] = data['data'];
            // } else {
            //   cats.remove(cat);
            // }
            allmusic[cat['id']] = data['data'];
          } else {
            print(response.reasonPhrase.toString());
          }
        }
      }
      print(allmusic);
      return allmusic;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getMusic(),
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
            return ListView.builder(
                itemCount: allmusic.length,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(cats[index]['name']),
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
                        itemCount: allmusic[cats[index]['id']].length,
                        itemBuilder: (context, index1) {
                          print(
                              allmusic[cats[index]['id']][index1]['song_name']);

                          return InkWell(
                            onTap: () {
                              playerbox.write('isplaying', false);
                              musicbox.write('cat_download', false);
                              Get.to(() => const MusicPlayerUi(), arguments: {
                                'isAsset': false,
                                'filepath': '',
                                'cat_id': cats[index]['id'],
                                'song_id': allmusic[cats[index]['id']][index1]
                                    ['id'],
                                'song_name': allmusic[cats[index]['id']][index1]
                                    ['song_name'],
                                'desc': allmusic[cats[index]['id']][index1]
                                    ['desc'],
                                'artist': allmusic[cats[index]['id']][index1]
                                    ['artist'],
                                'song_type': allmusic[cats[index]['id']][index1]
                                    ['song_type'],
                                'language': allmusic[cats[index]['id']][index1]
                                    ['language'],
                                'song_mp3': allmusic[cats[index]['id']][index1]
                                    ['song_mp3'],
                                'music_img': allmusic[cats[index]['id']][index1]
                                    ['music_img'],
                              });
                            },
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    // margin: const EdgeInsets.all(2.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.blueGrey.withOpacity(0.5),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              allmusic[cats[index]['id']]
                                                      [index1]['music_img']
                                                  .toString()),
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                ),
                                Text(
                                  allmusic[cats[index]['id']][index1]
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
                          );
                        },
                      ),
                    ],
                  );
                });
          }
        });
  }
}
