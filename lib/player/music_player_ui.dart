import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/constants.dart';
import 'package:music_app/custom%20widgets/custom_formfield.dart';
import 'package:music_app/custom%20widgets/custom_icon_button.dart';

class MusicPlayerUi extends StatefulWidget {
  const MusicPlayerUi({super.key});

  @override
  State<MusicPlayerUi> createState() => _MusicPlayerUiState();
}

class _MusicPlayerUiState extends State<MusicPlayerUi> {
  final TextEditingController _search = TextEditingController();
  final _player = AudioPlayer();
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
                              color: Colors.amber.shade600,
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
            child: LinearProgressIndicator(
              backgroundColor: Colors.grey.shade200,
              color: Colors.amber.shade600,
              value: 0.5,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width,
            child: Row(
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
                  icon: FontAwesomeIcons.play,
                  ontap: () {},
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
                  "0:17/6:11",
                  style: TextStyle(
                    fontSize: 13.0,
                    fontFamily: font_family,
                  ),
                ),
                CustomIconButton(
                  icon: FontAwesomeIcons.ellipsis,
                  ontap: () {},
                ),
                CustomIconButton(
                  icon: FontAwesomeIcons.volumeHigh,
                  ontap: () {},
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.03,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
