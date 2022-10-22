import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/player/music_player_ui.dart';

class CategoriesUi extends StatelessWidget {
  const CategoriesUi({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
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
  }
}
