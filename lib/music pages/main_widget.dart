import 'dart:convert';

import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:music_app/auth/login_ui.dart';
import 'package:music_app/constants.dart';
import 'package:music_app/custom%20widgets/connectivitycheck.dart';
import 'package:music_app/custom%20widgets/custom_formfield.dart';
import 'package:music_app/custom%20widgets/custom_icon_button.dart';
import 'package:music_app/custom%20widgets/utils.dart';
import 'package:music_app/music%20pages/dashboard_ui.dart';
import 'package:music_app/music%20pages/category_ui.dart';
import 'package:music_app/music%20pages/downloads_ui.dart';
import 'package:music_app/music%20pages/playlist_ui.dart';
import 'package:music_app/music%20pages/profile_ui.dart';
import 'package:music_app/music%20pages/search_results.dart';
import 'package:music_app/player/music_player_ui.dart';
import 'package:music_app/provider/categories_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class MainWidget extends StatefulWidget {
  const MainWidget({super.key});

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  final PageController page = PageController();
  final TextEditingController _search = TextEditingController();
  static SideMenuController sidecontroller = SideMenuController();
  List pages = [
    CategoriesUi(),
    PlaylistUi(),
    DownloadUi(),
    const ProfileUi(),
    const ProfileUi(),
  ];

  List<SideMenuItem> items = [
    SideMenuItem(
      // Priority of item to show on SideMenu, lower value is displayed at the top
      priority: 0,
      title: 'Dashboard',
      onTap: (page, _) => sidecontroller.changePage(page),
      icon: const Icon(
        Icons.dashboard,
        size: 25.0,
      ),
    ),
    SideMenuItem(
      // Priority of item to show on SideMenu, lower value is displayed at the top
      priority: 1,
      title: 'Playlist',
      onTap: (page, _) => sidecontroller.changePage(page),
      icon: const Icon(
        Icons.playlist_play,
        size: 25.0,
      ),
    ),
    SideMenuItem(
      // Priority of item to show on SideMenu, lower value is displayed at the top
      priority: 2,
      title: 'Downloads',
      onTap: (page, _) => sidecontroller.changePage(page),
      icon: const Icon(
        Icons.download,
        size: 25.0,
      ),
    ),
    SideMenuItem(
      priority: 3,
      title: 'Browse & Play',
      onTap: (page, _) async {
        await filepicker(filetype: FileType.audio).then((filepath) {
          print(filepath);
          playerbox.write('isplaying', false);
          Get.to(() => const MusicPlayerUi(), arguments: {
            'isAsset': true,
            'issingle': true,
            'songs_list': [],
            'filepath': filepath.path.toString(),
            'song_name': filepath.name.toString(),
            'data': {}
          });
        });
      },
      icon: const Icon(Icons.browse_gallery_outlined),
    ),
    SideMenuItem(
      priority: 4,
      title: 'My Account',
      onTap: (page, _) => sidecontroller.changePage(page),
      icon: const Icon(Icons.account_circle_outlined),
    ),
    SideMenuItem(
      priority: 5,
      title: 'Logout',
      onTap: (page, _) {
        print('logged out');
        // Get.to(
        //   () => const LoginUi(),
        // );
        customYesNoDialog(
            titletext: 'Are you sure?',
            contenttext: 'Do you want to logout?',
            yesOnTap: () {
              loginbox.write('islogin', false);
              loginbox.write('userdata', {});
              Get.to(
                () => const LoginUi(),
                // preventDuplicates: true,
              );
            });

        // page.keepPage;
      },
      icon: const Icon(Icons.logout_outlined),
    ),
  ];

  List categories = [
    // 'Pop',
    // 'Rock',
    // 'Hip Hop',
    // 'Classical',
    // 'Jazz',
    // 'Disco',
    // 'Electronic',
    // 'Traditional',
    // 'Mixed Genre',
  ];

  bool connectionavailable = true;

  @override
  void initState() {
    ConnectivityChecker.CheckConnection().then((value) {
      setState(() {
        connectionavailable = value;
      });
    });
    print('building state');
    sidecontroller.addListener((p0) {
      page.jumpToPage(p0);
    });

    super.initState();
  }

  @override
  void dispose() {
    page.dispose();
    sidecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      backgroundColor: Colors.grey.shade100.withOpacity(1.0),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        leadingWidth: 180.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        toolbarHeight: 50.0,
        leading: Center(
          child: Text(
            'InshopMedia Player',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.black,
              fontFamily: font_family,
            ),
          ),
        ),
        title: SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width * 0.4,
          child: customsearchField(
              "Search",
              _search,
              null,
              null,
              responsiveHW(context, wd: 100),
              responsiveHW(context, ht: 100),
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.0),
                borderSide: const BorderSide(
                  style: BorderStyle.none,
                  color: Colors.white,
                ),
              ),
              isreadonly: true,
              onchanged: null, ontap: () {
            Get.to(
              () => const SearchUi(),
            );
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
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SideMenu(
            style: SideMenuStyle(
              openSideMenuWidth: 200.0,
              selectedColor: Colors.grey.shade200.withOpacity(0.9),
              hoverColor: Colors.grey.shade200.withOpacity(0.9),
            ),
            controller: sidecontroller,
            title: Container(
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300.withOpacity(0.8),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey.shade100.withOpacity(1.0)),
              height: MediaQuery.of(context).size.height * 0.4,
              // width: MediaQuery.of(context).size.width * 0.5,
              child: !connectionavailable
                  ? Center(
                      child: Text(
                        'No Internet Available',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          // backgroundColor:
                          //     Colors.blueGrey.withOpacity(0.8),
                          fontSize: 13.0,
                          color: Colors.black,
                          fontFamily: font_family,
                        ),
                      ),
                    )
                  : Consumer<MusicCategoriesProvider>(
                      builder: (context, categoriespro, _) {
                      categoriespro.categories.isNotEmpty
                          ? null
                          : categoriespro.getCategories();
                      return categoriespro.isloadingcategories
                          ? Center(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                child: LoadingIndicator(
                                  indicatorType:
                                      Indicator.ballTrianglePathColoredFilled,
                                  colors: [
                                    Colors.teal.shade200,
                                    Colors.amber.shade300,
                                    Colors.red.shade300
                                  ],
                                  strokeWidth: 1,
                                ),
                              ),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.all(5.0),
                              itemCount: categoriespro.categories.length,
                              itemBuilder: ((context, index) {
                                return ListTile(
                                  onLongPress: (() {}),
                                  onTap: () {
                                    // print('pressed');
                                    musicbox.write('musicloaded', false);
                                    Get.to(() => CategoryUi(), arguments: {
                                      'category_name': categoriespro
                                          .categories[index]['name']
                                          .toString(),
                                      'category_id': categoriespro
                                          .categories[index]['id']
                                          .toString(),
                                      'items_list': [
                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQjSzVO5ZPeF-f5kucYJG1doKpXiPiooQfHKq0Rev-iVtpZE6zIPp9ylmrHabLcZpwk2gs&usqp=CAU',
                                        'https://i1.sndcdn.com/avatars-000528843336-cug73s-t500x500.jpg',
                                        'https://www.musicgrotto.com/wp-content/uploads/2021/09/best-songs-of-all-time-graphic-art.jpg',
                                        'https://i.ytimg.com/vi/vBGUB1dWfRg/maxresdefault.jpg',
                                        'https://i.ytimg.com/vi/wZl3j0I0fiA/maxresdefault.jpg',
                                        'https://i.ytimg.com/vi/-hg7ILmqadg/maxresdefault.jpg',
                                        'https://www.nettv4u.com/uploads/18-06-2019/top-10-indian-music-directors.jpg',
                                      ],
                                    });
                                  },
                                  hoverColor: Colors.grey.shade300,
                                  tileColor:
                                      Colors.grey.shade100.withOpacity(1.0),
                                  title: Text(
                                    '${categoriespro.categories[index]['name']}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontFamily: font_family,
                                    ),
                                  ),
                                );
                              }),
                            );
                    }),
            ),
            showToggle: true,
            items: items,
          ),
          Expanded(
            child: PageView.builder(
              itemBuilder: (context, index) {
                return pages[index];
              },
              controller: page,
            ),
          ),
        ],
      ),
    );
  }
}
