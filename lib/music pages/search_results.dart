import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:music_app/constants.dart';
import 'package:music_app/custom%20widgets/custom_formfield.dart';
import 'package:music_app/custom%20widgets/custom_icon_button.dart';
import 'package:music_app/player/music_player_ui.dart';

class SearchUi extends StatefulWidget {
  const SearchUi({super.key});

  @override
  State<SearchUi> createState() => _SearchUiState();
}

class _SearchUiState extends State<SearchUi> {
  ValueNotifier<List<bool>> visibiltyvar = ValueNotifier<List<bool>>([]);
  final TextEditingController _search = TextEditingController();
  List filteredsongs = [];
  bool issearching = false;
  Future searchsongs() async {
    filteredsongs = [];
    issearching = true;
    List templist = [];
    Map tempmap = {};
    Map allmusic = musicbox.read('allmusic');
    allmusic.forEach((key, value) {
      templist = value;
      if (templist.isNotEmpty) {
        for (var songmap in templist) {
          tempmap = songmap;
          if (tempmap['song_name']
              .toString()
              .toLowerCase()
              .startsWith(_search.text)) {
            filteredsongs.add(tempmap);
          }
        }
      }
    });
    setState(() {
      _search.selection =
          TextSelection.fromPosition(TextPosition(offset: _search.text.length));
      issearching = false;
      filteredsongs;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        toolbarHeight: 50.0,
        title: SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width * 0.4,
          child: customsearchField(
              "Search By Song Name",
              _search,
              (value) {},
              (value) {
                _search.text = value!;
              },
              responsiveHW(context, wd: 100),
              responsiveHW(context, ht: 100),
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.0),
                borderSide: const BorderSide(
                  style: BorderStyle.none,
                  color: Colors.white,
                ),
              ),
              isreadonly: false,
              onchanged: (val) {
                _search.text = val;
                searchsongs();
              }),
        ),
        actions: [
          Center(
            child: Text(
              loginbox.read('userdata')['data']['name'].toString(),
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
              child: const Icon(
                Icons.person,
                color: Colors.black45,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.grey.shade100.withOpacity(1.0),
      body: issearching
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
          : filteredsongs.isEmpty
              ? Center(
                  child: Text(
                    "No Songs Matches",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontFamily: font_family_bold,
                    ),
                  ),
                )
              : ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        "Search Results",
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
                      itemCount: filteredsongs.length,
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
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: Colors.blueGrey.withOpacity(0.5),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                filteredsongs[index]
                                                        ['music_img']
                                                    .toString()),
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    filteredsongs[index]['song_name'],
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
                                                    musicbox.write(
                                                        'cat_download', false);
                                                    Get.to(
                                                        () =>
                                                            const MusicPlayerUi(),
                                                        arguments: {
                                                          'isAsset': false,
                                                          'issingle': true,
                                                          'filepath': '',
                                                          'songs_list': [],
                                                          'cat_id': musicbox
                                                              .read('allmusic')
                                                              .keys
                                                              .first
                                                              .toString(),
                                                          'song_id':
                                                              filteredsongs[
                                                                  index]['id'],
                                                          'song_name':
                                                              filteredsongs[
                                                                      index]
                                                                  ['song_name'],
                                                          'desc': filteredsongs[
                                                              index]['desc'],
                                                          'artist':
                                                              filteredsongs[
                                                                      index]
                                                                  ['artist'],
                                                          'song_type':
                                                              filteredsongs[
                                                                      index]
                                                                  ['song_type'],
                                                          'language':
                                                              filteredsongs[
                                                                      index]
                                                                  ['language'],
                                                          'song_mp3':
                                                              filteredsongs[
                                                                      index]
                                                                  ['song_mp3'],
                                                          'music_img':
                                                              filteredsongs[
                                                                      index]
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
                ),
    );
  }
}
