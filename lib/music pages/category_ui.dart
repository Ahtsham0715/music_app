import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/constants.dart';
import 'package:music_app/player/music_player_ui.dart';

class CategoryUi extends StatelessWidget {
  Map args = {};
  CategoryUi({super.key, required items}) {
    args = items;
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            "${args['category_name']}",
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
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
          ),
          itemCount: args['items_list'].length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Get.to(
                  () => const MusicPlayerUi(),
                );
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
                    image: DecorationImage(
                        image: NetworkImage(
                            args['items_list'][index].toString()))),
              ),
            );
          },
        ),
      ],
    );
  }
}
