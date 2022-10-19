import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:music_app/constants.dart';
import 'package:music_app/custom%20widgets/custom_formfield.dart';

class MainWidget extends StatefulWidget {
  const MainWidget({super.key});

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  static PageController page = PageController();
  TextEditingController _search = TextEditingController();

  List<SideMenuItem> items = [
    SideMenuItem(
      // Priority of item to show on SideMenu, lower value is displayed at the top
      priority: 0,
      title: 'Downloads',
      onTap: () => page.jumpToPage(0),
      icon: const Icon(
        Icons.download,
        size: 25.0,
      ),
    ),
    SideMenuItem(
      priority: 1,
      title: 'Browse & Play',
      onTap: () => page.jumpToPage(1),
      icon: const Icon(Icons.browse_gallery_outlined),
    ),
    SideMenuItem(
      priority: 2,
      title: 'My Account',
      onTap: () => page.jumpToPage(2),
      icon: const Icon(Icons.account_circle_outlined),
    ),
    SideMenuItem(
      priority: 3,
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
            (value) {
              // if (value!.isEmpty) {
              //   return "Please Enter Your Email";
              // }
              // if (!RegExp(
              //         r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              //     .hasMatch(value)) {
              //   return "Please Enter Valid Email Address";
              // }
            },
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
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey.shade200.withOpacity(0.9)),
              height: MediaQuery.of(context).size.height * 0.4,
              // width: MediaQuery.of(context).size.width * 0.5,
              child: ListView.builder(
                padding: const EdgeInsets.all(5.0),
                itemCount: 30,
                itemBuilder: ((context, index) {
                  return ListTile(
                    onTap: () {},
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
            // Will show on bottom of SideMenu when displayMode was SideMenuDisplayMode.open
            // footer: Text('demo'),
            // // Notify when display mode changed
            // onDisplayModeChanged: (mode) {
            //   print(mode);
            // },
            // List of SideMenuItem to show them on SideMenu
            items: items,
          ),
          Expanded(
            child: PageView(
              controller: page,
              children: const [
                Center(
                  child: Text('downloads'),
                ),
                Center(
                  child: Text('Browse and Play'),
                ),
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
