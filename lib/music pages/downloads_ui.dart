import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:music_app/constants.dart';
import 'package:music_app/custom%20widgets/custom_icon_button.dart';
import 'package:music_app/player/music_player_ui.dart';

class DownloadUi extends StatefulWidget {
  Map args = {};
  DownloadUi({super.key, required items}) {
    args = items;
  }

  @override
  State<DownloadUi> createState() => _DownloadUiState();
}

class _DownloadUiState extends State<DownloadUi> {
  List visibiltyvar = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0.0,
        // leadingWidth: 150.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        toolbarHeight: 50.0,
        title: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                FontAwesomeIcons.music,
                size: 30.0,
                color: Colors.amber,
              ),
              Text(
                'Music App',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: font_family,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        // title: SizedBox(
        //   height: 50,
        //   width: MediaQuery.of(context).size.width * 0.4,
        //   child: customsearchField(
        //     "Search",
        //     _search,
        //     (value) {},
        //     (value) {
        //       _search.text = value!;
        //     },
        //     responsiveHW(context, wd: 100),
        //     responsiveHW(context, ht: 100),
        //     OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(50.0),
        //       borderSide: const BorderSide(
        //         style: BorderStyle.none,
        //         color: Colors.white,
        //       ),
        //     ),
        //   ),
        // ),
        actions: [
          Center(
            child: Text(
              'Shami',
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
              // radius: 40.0,
              // foregroundImage: NetworkImage(
              //   'https://w7.pngwing.com/pngs/831/88/png-transparent-user-profile-computer-icons-user-interface-mystique-miscellaneous-user-interface-design-smile.png',
              // ),
              child: const Icon(
                Icons.person,
                color: Colors.black45,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              "${widget.args['category_name']}",
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
            itemCount: widget.args['items_list'].length,
            itemBuilder: (context, index) {
              visibiltyvar.add(false);
              return InkWell(
                onTap: () {},
                onHover: ((ishovering) {
                  if (ishovering) {
                    setState(() {
                      visibiltyvar[index] = true;
                    });
                    print('hovering');
                  } else {
                    visibiltyvar[index] = false;
                    setState(() {});
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
                              image: NetworkImage(widget.args['items_list']
                                      [index]
                                  .toString()))),
                    ),
                    Visibility(
                      visible: visibiltyvar[index],
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
                                    Get.to(
                                      () => const MusicPlayerUi(),
                                    );
                                  },
                                  icon: Icons.play_arrow),
                            ),
                          ),
                        ),
                      ),
                    ),
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
