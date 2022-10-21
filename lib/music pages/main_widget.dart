import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:music_app/constants.dart';
import 'package:music_app/custom%20widgets/custom_formfield.dart';
import 'package:music_app/music%20pages/categories_ui.dart';
import 'package:music_app/music%20pages/category_ui.dart';

class MainWidget extends StatefulWidget {
  const MainWidget({super.key});

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  static PageController page = PageController();
  final TextEditingController _search = TextEditingController();

  List<SideMenuItem> items = [
    SideMenuItem(
      // Priority of item to show on SideMenu, lower value is displayed at the top
      priority: 0,
      title: 'Dashboard',
      onTap: () => page.jumpToPage(0),
      icon: const Icon(
        Icons.dashboard,
        size: 25.0,
      ),
    ),
    SideMenuItem(
      // Priority of item to show on SideMenu, lower value is displayed at the top
      priority: 1,
      title: 'Downloads',
      onTap: () => page.jumpToPage(1),
      icon: const Icon(
        Icons.download,
        size: 25.0,
      ),
    ),
    SideMenuItem(
      priority: 2,
      title: 'Browse & Play',
      onTap: () => page.jumpToPage(2),
      icon: const Icon(Icons.browse_gallery_outlined),
    ),
    SideMenuItem(
      priority: 3,
      title: 'My Account',
      onTap: () => page.jumpToPage(3),
      icon: const Icon(Icons.account_circle_outlined),
    ),
    SideMenuItem(
      priority: 4,
      title: 'Logout',
      onTap: () {
        print('logged out');
      },
      icon: const Icon(Icons.logout_outlined),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100.withOpacity(1.0),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        leadingWidth: 150.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        toolbarHeight: 50.0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                ),
              ),
            ],
          ),
        ),
        title: SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width * 0.4,
          child: customsearchField(
            "Search",
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
          ),
        ),
        actions: [
          Center(
            child: Text(
              'Shami',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.0,
                fontFamily: font_family,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: CircleAvatar(
              // radius: 40.0,
              backgroundImage: NetworkImage(
                'https://w7.pngwing.com/pngs/831/88/png-transparent-user-profile-computer-icons-user-interface-mystique-miscellaneous-user-interface-design-smile.png',
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
              // backgroundColor: Colors.grey,
              openSideMenuWidth: 200.0,
              selectedColor: Colors.grey.shade200.withOpacity(0.9),
              hoverColor: Colors.grey.shade200.withOpacity(0.9),
            ),
            // Page controller to manage a PageView
            controller: page,
            // Will shows on top of all items, it can be a logo or a Title text
            title: Container(
              margin: const EdgeInsets.all(8.0),
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
              child: ListView.builder(
                padding: const EdgeInsets.all(5.0),
                itemCount: 30,
                itemBuilder: ((context, index) {
                  return ListTile(
                    onLongPress: (() {}),
                    onTap: () {
                      print('pressed');
                      // page.jumpToPage(0);
                      Get.to(() => const CategoryUi(), arguments: {
                        'category_name': 'Category ${index + 1}',
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
                    tileColor: Colors.grey.shade100.withOpacity(1.0),
                    title: Text(
                      'Category ${index + 1}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: font_family,
                      ),
                    ),
                  );
                }),
              ),
            ),
            showToggle: true,
            items: items,
          ),
          Expanded(
            child: PageView(
              controller: page,
              children: const [
                CategoriesUi(),
                Center(
                  child: Text('downloads'),
                ),
                CategoriesUi(),
                Center(
                  child: Text('My Account'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
