// ignore_for_file: library_private_types_in_public_api

import 'package:ddanieloli/app/components/instagram_btn.dart';
import 'package:ddanieloli/app/components/menu_desktop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gif_view/gif_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  List<Albums> albumsData = [];
  bool displayImage = true;
  double videoHeight = double.maxFinite;
  final _controller = GifController(autoPlay: true, loop: false);
  @override
  void initState() {
    super.initState();

    hideImage();
    getCache().then((response) {
      displayData(response);
    });
  }

  void hideImage() {
    setState(() {
      displayImage = false;
    });
  }

  void displayData(data) {
    setState(() {
      albumsData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    final album = ref.read(selectedAlbum);

    return Container(
      padding: const EdgeInsets.all(10),
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
                aspectRatio: 7 / 5,
                child: GifView.asset("assets/images/danieloli.gif",
                    controller: _controller),
              )),
          // AnimatedContainer(
          //     height: displayVideo ? double.maxFinite : 0,
          //     constraints: const BoxConstraints(maxHeight: 262.5),
          //     padding: const EdgeInsets.only(top: 20),
          //     duration: const Duration(milliseconds: 500),
          //     child: VideoDisplayer(
          //       videoController: _controller,
          //       initializeVideoPlayerFuture: _initializeVideoPlayerFuture,
          //     )),
          // } else ...{
          Container(
              width: widget.swidth * .9,
              margin: const EdgeInsets.only(bottom: 5),
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
                        displayImage = true;
                      });
                      _controller.play();
                      hideImage();
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
                            fixedSize: WidgetStatePropertyAll(
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

// class VideoDisplayer extends StatefulWidget {
//   final VideoPlayerController videoController;
//   final Future<void> initializeVideoPlayerFuture;
//   const VideoDisplayer({
//     super.key,
//     required this.videoController,
//     required this.initializeVideoPlayerFuture,
//   });

//   @override
//   State<VideoDisplayer> createState() => _VideoDisplayerState();
// }

// class _VideoDisplayerState extends State<VideoDisplayer> {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: widget.initializeVideoPlayerFuture,
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             return Padding(
//               padding: const EdgeInsets.only(bottom: 20),
//               child: AspectRatio(
//                   aspectRatio: widget.videoController.value.aspectRatio,
//                   child: VideoPlayer(widget.videoController)),
//             );
//           }
//           return const AspectRatio(
//               aspectRatio: 7/5,
//               child: Center(child: CircularProgressIndicator()));
//         });
//   }
// }
