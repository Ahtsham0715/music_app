import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:music_app/constants.dart';
import 'package:music_app/custom%20widgets/custom_icon_button.dart';
import 'package:music_app/player/music_player_ui.dart';
import 'package:music_app/provider/category_music_provider.dart';
import 'package:provider/provider.dart';

class CategoryUi extends StatefulWidget {
  CategoryUi({super.key}) {}

  @override
  State<CategoryUi> createState() => _CategoryUiState();
}

class _CategoryUiState extends State<CategoryUi> {
  final TextEditingController _search = TextEditingController();
  ValueNotifier<List<bool>> visibiltyvar = ValueNotifier<List<bool>>([]);

  var args = Get.arguments;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CategoryMusicProvider>(context, listen: false)
          .getCategoryMusic(
        id: args['category_id'],
        isplaylist: false,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final musicpro = Provider.of<CategoryMusicProvider>(context);
    // musicbox.read('musicloaded')
    //     // musicpro.categorymusic.isEmpty
    //     ? null
    //     : musicpro.getCategoryMusic(
    //         id: args['category_id'],
    //         isplaylist: false,
    //       );
    print('build');
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0.0,
        // leadingWidth: 150.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        toolbarHeight: 50.0,
        title: Center(
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

        actions: [
          Center(
            child: Text(
              loginbox.read('userdata')['data']['name'],
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
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              "${args['category_name']}",
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: font_family_bold,
              ),
            ),
          ),
          musicpro.isloadingmusic
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 200),
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
                  ),
                )
              : musicpro.categorymusic.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: 300.0),
                      child: Center(
                        child: Text(
                          'No Song Available',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                            fontFamily: font_family_bold,
                          ),
                        ),
                      ),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.all(5.0),
                      physics: const AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 5.0,
                      ),
                      itemCount: musicpro.categorymusic.length,
                      itemBuilder: (context, index) {
                        visibiltyvar.value.add(false);
                        return InkWell(
                          onTap: () {},
                          hoverColor: Colors.transparent,
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
                              print('not hovering');
                            }
                          }),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Container(
                                      // margin: const EdgeInsets.all(2.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: Colors.grey.shade100,
                                          image: DecorationImage(
                                              image: NetworkImage(musicpro
                                                  .categorymusic[index]
                                                      ['music_img']
                                                  .toString()),
                                              fit: BoxFit.cover)),
                                    ),
                                  ),
                                  Text(
                                    musicpro.categorymusic[index]['song_name']
                                        .toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      // backgroundColor:
                                      //     Colors.blueGrey.withOpacity(0.8),
                                      fontSize: 14.0,
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
                                              bottom: 18.0),
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
                                                          'filepath': '',
                                                          'cat_id': args[
                                                              'category_id'],
                                                          'song_id': musicpro
                                                                  .categorymusic[
                                                              index]['id'],
                                                          'song_name': musicpro
                                                                  .categorymusic[
                                                              index]['song_name'],
                                                          'desc': musicpro
                                                                  .categorymusic[
                                                              index]['desc'],
                                                          'artist': musicpro
                                                                  .categorymusic[
                                                              index]['artist'],
                                                          'song_type': musicpro
                                                                  .categorymusic[
                                                              index]['song_type'],
                                                          'language': musicpro
                                                                  .categorymusic[
                                                              index]['language'],
                                                          'song_mp3': musicpro
                                                                  .categorymusic[
                                                              index]['song_mp3'],
                                                          'music_img': musicpro
                                                                  .categorymusic[
                                                              index]['music_img'],
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
