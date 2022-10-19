import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';

class MainWidget extends StatefulWidget {
  const MainWidget({super.key});

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  static PageController page = PageController();

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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        toolbarHeight: 50.0,
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SideMenu(
            style: SideMenuStyle(
              // backgroundColor: Colors.grey,
              openSideMenuWidth: 300.0,
            ),
            // Page controller to manage a PageView
            controller: page,
            // Will shows on top of all items, it can be a logo or a Title text
            title: Container(
              margin: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  // boxShadow: [
                  //   BoxShadow(

                  //   ),
                  // ],
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey.shade300.withOpacity(0.9)),
              height: MediaQuery.of(context).size.height * 0.5,
              // width: MediaQuery.of(context).size.width * 0.5,
              child: ListView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: 30,
                itemBuilder: ((context, index) {
                  return ListTile(
                    title: Text(
                      'Category ${index + 1}',
                      textAlign: TextAlign.center,
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
