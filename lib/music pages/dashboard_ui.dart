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
  ValueNotifier<List<bool>> visibiltyvar = ValueNotifier<List<bool>>([]);

  Future getMusic() async {
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
            allmusic[cat['id']] = data['data'];
            print(allmusic.length);
            // allmusic[categoryid] = data['data'];
            // print(data['data']);
          } else {
            print(response.reasonPhrase.toString());
          }
        }
      }
    }

    return allmusic;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getMusic(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: cats.length,
            itemBuilder: (context, index) {
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
                        return InkWell(
                          onTap: () {
                            // Get.to(() => const MusicPlayerUi(), arguments: {
                            //   'isAsset': false,
                            //   'filepath': '',
                            // });
                          },
                          onHover: ((ishovering) {
                            if (ishovering) {
                              print('hovering');
                            } else {
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
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: Colors.blueGrey.withOpacity(0.5),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                allmusic[cats[index]['id']]
                                                        [index]['music_img']
                                                    .toString()),
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    allmusic[cats[index]['id']][index]
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
                                          margin: const EdgeInsets.only(
                                              bottom: 16.0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            color: Colors.blueGrey
                                                .withOpacity(0.5),
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
                                                          'song_id': allmusic[
                                                                  cats[index]
                                                                      ['id']]
                                                              [index]['id'],
                                                          'song_name': allmusic[
                                                                      cats[index]
                                                                          [
                                                                          'id']]
                                                                  [index]
                                                              ['song_name'],
                                                          'desc': allmusic[
                                                                  cats[index]
                                                                      ['id']]
                                                              [index]['desc'],
                                                          'artist': allmusic[
                                                                  cats[index]
                                                                      ['id']]
                                                              [index]['artist'],
                                                          'song_type': allmusic[
                                                                      cats[index]
                                                                          [
                                                                          'id']]
                                                                  [index]
                                                              ['song_type'],
                                                          'language': allmusic[
                                                                  cats[index]
                                                                      ['id']][
                                                              index]['language'],
                                                          'song_mp3': allmusic[
                                                                  cats[index]
                                                                      ['id']][
                                                              index]['song_mp3'],
                                                          'music_img': allmusic[
                                                                      cats[index]
                                                                          [
                                                                          'id']]
                                                                  [index]
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
            },
          );
        });
  }
}
