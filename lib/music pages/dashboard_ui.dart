import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:music_app/player/music_player_ui.dart';
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

  Future getMusic({required String categoryid}) async {
    print('fetching music for category_id: $categoryid');
    var headers = {'Accept': 'application/json'};
    var url = Uri.parse(
        'https://desktopapp.inshopmedia.com/api/music-list?category_id=$categoryid');

    final response = await http.get(
      url,
      headers: headers,
    );
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      allmusic[categoryid] = data['data'];
      print(allmusic.length);
      // allmusic[categoryid] = data['data'];
      // print(data['data']);
    } else {
      print(response.reasonPhrase.toString());
    }
  }

  Future fetchallmusic(context) async {
    final categoriesprovider = Provider.of<MusicCategoriesProvider>(context);
    print('in fetch all music');
    List cats = [];
    categoriesprovider.getCategories().then((value) {
      cats = value;
      print(cats.length);
    });
    for (var cat in cats) {
      await getMusic(categoryid: cat['id']);
    }
    return cats;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        // future: fetchallmusic(context),
        builder: (context, snapshot) {
      return ListView.builder(
        itemCount: 5,
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
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text("Title $index"),
              ),
              GridView.builder(
                padding: const EdgeInsets.all(5.0),
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                ),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Get.to(() => const MusicPlayerUi(), arguments: {
                        'isAsset': false,
                        'filepath': '',
                      });
                    },
                    onHover: ((ishovering) {
                      if (ishovering) {
                        print('hovering');
                      } else {
                        print('not hovering');
                      }
                    }),
                    child: Container(
                      margin: const EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.blueGrey,
                          image: const DecorationImage(
                              image: NetworkImage(
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSc6U4X9ugWzyY5xqJJeYJroGruDh5Cq325szRQiI7e8R0zZ1ODOvGsuYtE3jbI9PiaP4U&usqp=CAU'))),
                    ),
                  );
                },
              ),
            ],
          );
        },
      );
    });
  }
}
