import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:music_app/constants.dart';
import 'package:music_app/custom%20widgets/custom_icon_button.dart';
import 'package:music_app/player/music_player_ui.dart';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class DownloadUi extends StatefulWidget {
  Map args = {};
  DownloadUi({super.key, required items}) {
    args = items;
  }

  @override
  State<DownloadUi> createState() => _DownloadUiState();
}

class _DownloadUiState extends State<DownloadUi> {
  ValueNotifier<List<bool>> visibiltyvar = ValueNotifier<List<bool>>([]);
  bool isloading = true;
  List files = [];
  Future getdownloads() async {
    // isloading = true;
    Directory? downloadDir = await getDownloadsDirectory();
    String downloadPath = downloadDir!.path;
    Directory dir = Directory('$downloadPath/inshopmedia_downloads/');
    dir.listSync().forEach((e) {
      print(e.path);
      files.add(e.path);
      visibiltyvar.value.add(false);
    });
  }

  @override
  void initState() {
    getdownloads().then((value) {
      setState(() {
        isloading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: isloading
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
                  itemCount: files.length,
                  itemBuilder: (context, index) {
                    // visibiltyvar.value.add(false);
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
                                    image: const DecorationImage(
                                        image: NetworkImage(
                                            'https://online.berklee.edu/takenote/wp-content/uploads/2019/03/killerHooks-1920x1200.png'),
                                        fit: BoxFit.fill),
                                  ),
                                ),
                              ),
                              Text(
                                files[index].toString().split('/').last,
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
                                        color: Colors.blueGrey.withOpacity(0.5),
                                      ),
                                      child: Center(
                                        child: CircleAvatar(
                                          backgroundColor: Colors.black54,
                                          child: CustomIconButton(
                                              ontap: () {
                                                playerbox.write(
                                                    'isplaying', false);
                                                Get.to(
                                                    () => const MusicPlayerUi(),
                                                    arguments: {
                                                      'isAsset': true,
                                                      'filepath': files[index]
                                                          .toString(),
                                                      'song_name': files[index]
                                                          .toString()
                                                          .split('/')
                                                          .last,
                                                      'data': {}
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
