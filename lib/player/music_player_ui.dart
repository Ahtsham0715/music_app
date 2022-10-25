import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:music_app/constants.dart';
import 'package:music_app/custom%20widgets/custom_icon_button.dart';
import 'package:music_app/player/player_provider.dart';
import 'package:provider/provider.dart';

class MusicPlayerUi extends StatefulWidget {
  const MusicPlayerUi({super.key});

  @override
  State<MusicPlayerUi> createState() => _MusicPlayerUiState();
}

class _MusicPlayerUiState extends State<MusicPlayerUi> {
  final TextEditingController _search = TextEditingController();
  var args = Get.arguments;
  double _slidervalue = 0.0;
  dynamic playerprovider;
  @override
  void initState() {
    playerprovider = Provider.of<AudioPlayerProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('build');

    if (args['isAsset']) {
      playerprovider.playfromAsset(args['filepath']);
    }
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
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.width * 0.25,
                        padding: const EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2.0),
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Image.network(
                          'https://i.ytimg.com/vi/-hg7ILmqadg/maxresdefault.jpg',
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          "Dil Cheez Hai Kya",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            fontFamily: font_family_bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(
                          "Khayam, Asha Bhosle",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: font_family,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, left: 25.0),
                        child: ListTile(
                          title: Text(
                            "Queue",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: font_family,
                            ),
                          ),
                          trailing: Padding(
                            padding: const EdgeInsets.only(right: 50.0),
                            child: MaterialButton(
                              onPressed: () {},
                              color: Colors.teal.shade200,
                              elevation: 0.0,
                              shape: const StadiumBorder(),
                              minWidth:
                                  MediaQuery.of(context).size.width * 0.01,
                              // height: MediaQuery.of(context).size.height * 0.07,
                              child: Text(
                                'Download',
                                style: TextStyle(
                                    fontSize: 12.0,
                                    // fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    fontFamily: font_family),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: Divider(
                          indent: 15.0,
                          endIndent: 45.0,
                          color: Colors.grey.shade400.withOpacity(0.7),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: ListView.builder(
                          itemCount: 25,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                "Dil Cheez Hai Kya",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: font_family_bold,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              subtitle: Text(
                                "Khayam, Asha Bhosle",
                                style: TextStyle(
                                  fontSize: 13.0,
                                  fontFamily: font_family,
                                ),
                              ),
                              trailing: ButtonBar(
                                mainAxisSize: MainAxisSize.min,
                                alignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.add,
                                      color:
                                          Colors.grey.shade800.withOpacity(0.7),
                                      // size: 25.0,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.download,
                                      color:
                                          Colors.grey.shade800.withOpacity(0.7),
                                      // size: 25.0,
                                    ),
                                  ),
                                  Text(
                                    "6:11",
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      fontFamily: font_family,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.005,
            width: MediaQuery.of(context).size.width,
            child:
                Consumer<AudioPlayerProvider>(builder: (context, playerpro, _) {
              return Slider(
                min: 0,
                max: playerpro.maxduration,
                value: playerpro.seekpossec,
                onChanged: (value) {
                  print(value);
                },
                activeColor: Colors.teal.shade200,
                inactiveColor: Colors.grey.shade300,
                // color: Colors.teal.shade300,
              );
            }),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width,
            child:
                Consumer<AudioPlayerProvider>(builder: (context, playerpro, _) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomIconButton(
                    icon: FontAwesomeIcons.repeat,
                    ontap: () {},
                  ),
                  CustomIconButton(
                    icon: FontAwesomeIcons.backwardStep,
                    ontap: () {},
                  ),
                  CustomIconButton(
                    icon: playerpro.isplaying
                        ? FontAwesomeIcons.pause
                        : FontAwesomeIcons.play,
                    ontap: () {
                      // setState(() {});
                      playerprovider.isplaying
                          ? playerprovider.pauseAudio()
                          : playerprovider.resumeAudio();
                    },
                  ),
                  CustomIconButton(
                    icon: FontAwesomeIcons.forwardStep,
                    ontap: () {},
                  ),
                  CustomIconButton(
                    icon: FontAwesomeIcons.shuffle,
                    ontap: () {},
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                  ),
                  Text(
                    "${playerprovider.seekpos}/${playerprovider.duration} ",
                    style: TextStyle(
                      fontSize: 13.0,
                      fontFamily: font_family,
                    ),
                  ),
                  // CustomIconButton(
                  //   icon: FontAwesomeIcons.ellipsis,
                  //   ontap: () {},
                  // ),
                  CustomIconButton(
                    icon: FontAwesomeIcons.volumeHigh,
                    ontap: () {
                      print('menu build');
                      showMenu(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          // elevation: 0.0,
                          color: Colors.grey.shade300,
                          context: context,
                          position: RelativeRect.fromLTRB(
                              MediaQuery.of(context).size.width * 0.01,
                              MediaQuery.of(context).size.height * 0.80,
                              10,
                              0.0),
                          items: [
                            PopupMenuItem(
                              child: Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.volumeLow,
                                    color: Colors.amber.shade800,
                                    size: 25.0,
                                  ),
                                  StatefulBuilder(
                                      builder: (context, innerstate) {
                                    return Slider(
                                      min: 0,
                                      max: 1,
                                      inactiveColor: Colors.grey.shade400,
                                      activeColor: Colors.green,
                                      value: playerpro.volume,
                                      onChanged: (value) {
                                        playerpro
                                            .changeVolume(value.toDouble());
                                        innerstate(() {});
                                      },
                                    );
                                  }),
                                ],
                              ),
                            )
                          ]);
                    },
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
