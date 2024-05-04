// ignore_for_file: library_private_types_in_public_api

import 'package:ddanieloli/app/components/instagram_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import '../../main.dart';
import '../../utils/app_theme.dart';
import '../controllers/home_controllers.dart';
import '../models/home_models.dart';

class MenuMobile extends ConsumerStatefulWidget {
  final double swidth;
  const MenuMobile({super.key, required this.swidth});

  @override
  _MenuMobileState createState() => _MenuMobileState();
}

class _MenuMobileState extends ConsumerState<MenuMobile> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  List<Albums> albumsData = [];
  bool displayVideo = false;
  bool displayImage = true;
  double videoHeight = double.maxFinite;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset('assets/videos/DanielOli.mp4');
    _initializeVideoPlayerFuture = _controller.initialize();

    hideImage();
    getCache();
  }

  void hideImage() {
    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        displayImage = false;
      });
    });
  }

  void hideVideo() {
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.play();

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        displayVideo = false;
      });
    });
  }

  void getCache() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final List<String>? albumId = prefs.getStringList('albumId');
      final List<String>? albumTitle = prefs.getStringList('albumTitle');

      if (albumId!.isNotEmpty && albumTitle!.isNotEmpty) {
        List<Albums> albumsValues = [];
        for (var i = 0; i < albumId.length; i++) {
          albumsValues.add(Albums(
              albumId: albumId[i], title: albumTitle[i], isSelected: false));
        }
        setState(() {
          albumsData = albumsValues;
        });
      } else {
        logger.info("Cache expirou");
        checkData();
      }
    } catch (e) {
      logger.info("Erro ao obter dados de cache: $e");
      checkData();
    }
  }

  Future checkData() async {
    final response = await getAlbums();
    final albums = response as List<Albums>;

    setState(() {
      albumsData = [...albums];
    });
  }

  @override
  Widget build(BuildContext context) {
    final album = ref.read(selectedAlbum);

    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 25, left: 15, right: 15),
      width: widget.swidth,
      color: terciary,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          // if (displayVideo) ...{
          AnimatedContainer(
            height: displayImage ? double.maxFinite : 0,
            constraints: const BoxConstraints(maxHeight: 262.5),
            padding: const EdgeInsets.only(top: 20),
            duration: const Duration(milliseconds: 500),
            child: AspectRatio(
                aspectRatio: 7/5,
                child: Image.asset("assets/images/danieloli.jpg")),
          ),
          AnimatedContainer(
              height: displayVideo ? double.maxFinite : 0,
              constraints: const BoxConstraints(maxHeight: 262.5),
              padding: const EdgeInsets.only(top: 20),
              duration: const Duration(milliseconds: 500),
              child: VideoDisplayer(
                videoController: _controller,
                initializeVideoPlayerFuture: _initializeVideoPlayerFuture,
              )),
          // } else ...{
          Container(
              width: widget.swidth * .9,
              margin: const EdgeInsets.only(bottom: 15),
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  if (ModalRoute.of(context)!.settings.name != '/') ...{
                    Tooltip(
                        message: "Voltar ao Home",
                        child: IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "/");
                            },
                            iconSize: 20,
                            icon: const Icon(Icons.home, color: primary))),
                  } else ...{
                    const SizedBox(
                      width: 30,
                    )
                  },
                  InkWell(
                    child: Container(
                        color: surface,
                        width: 100,
                        // margin: EdgeInsets.only(bottom: 20),
                        height: 5),
                    onTap: () {
                      setState(() {
                        displayVideo = true;
                      });
                      hideVideo();
                    },
                  ),
                  instagramButton(context)
                ],
              )),
          // },
          SizedBox(
            width: widget.swidth * .9,
            child: Material(
              elevation: 5,
              color: surface,
              child: ExpansionTile(
                  collapsedIconColor: primary,
                  title: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(FontAwesomeIcons.images,
                            color: primary, size: 15),
                      ),
                      Text("Galerias", style: textTheme.bodyMedium),
                    ],
                  ),
                  children: [
                    for (var galery in albumsData) ...{
                      MenuItemButton(
                        style: ButtonStyle(
                            fixedSize: MaterialStatePropertyAll(
                                Size(widget.swidth * 23, 40))),
                        child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(galery.title)),
                        onPressed: () async {
                          album.clear();
                          album.add(galery.albumId);
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.setString("galeryId", galery.albumId);
                          Navigator.pushNamed(context, "/galerias");
                        },
                      ),
                    }
                  ]),
            ),
          )
        ],
      ),
    );
  }
}

class VideoDisplayer extends StatefulWidget {
  final VideoPlayerController videoController;
  final Future<void> initializeVideoPlayerFuture;
  const VideoDisplayer({
    super.key,
    required this.videoController,
    required this.initializeVideoPlayerFuture,
  });

  @override
  State<VideoDisplayer> createState() => _VideoDisplayerState();
}

class _VideoDisplayerState extends State<VideoDisplayer> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.initializeVideoPlayerFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: AspectRatio(
                  aspectRatio: widget.videoController.value.aspectRatio,
                  child: VideoPlayer(widget.videoController)),
            );
          }
          return const AspectRatio(
              aspectRatio: 7/5,
              child: Center(child: CircularProgressIndicator()));
        });
  }
}
