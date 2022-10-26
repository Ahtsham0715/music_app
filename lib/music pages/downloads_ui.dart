import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/constants.dart';
import 'package:music_app/custom%20widgets/custom_icon_button.dart';
import 'package:music_app/player/music_player_ui.dart';

// class DownloadUi extends StatefulWidget {
//   Map args = {};
//   DownloadUi({super.key, required items}) {
//     args = items;
//   }

//   @override
//   State<DownloadUi> createState() => _DownloadUiState();
// }

class DownloadUi extends StatelessWidget {
  Map args = {};
  DownloadUi({super.key, required items}) {
    args = items;
  }
  ValueNotifier<List<bool>> visibiltyvar = ValueNotifier<List<bool>>([]);
  // List visibiltyvar = [];

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              "Downloads",
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
              visibiltyvar.value.add(false);
              return InkWell(
                onTap: () {},
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
                    Container(
                      margin: const EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.blueGrey,
                          image: DecorationImage(
                              image: NetworkImage(
                                  args['items_list'][index].toString()))),
                    ),
                    ValueListenableBuilder(
                        valueListenable: visibiltyvar,
                        builder: (context, val, _) {
                          return Visibility(
                            visible: val[index],
                            child: Positioned(
                              // top: 0,
                              child: Container(
                                margin: const EdgeInsets.all(2.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.blueGrey.withOpacity(0.5),
                                ),
                                child: Center(
                                  child: CircleAvatar(
                                    backgroundColor: Colors.black54,
                                    child: CustomIconButton(
                                        ontap: () {
                                          Get.to(() => const MusicPlayerUi(),
                                              arguments: {
                                                'isAsset': false,
                                                'filepath': '',
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
      ),
    );
  }
}
