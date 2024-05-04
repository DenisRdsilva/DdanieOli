// ignore_for_file: library_private_types_in_public_api

import 'package:ddanieloli/app/components/instagram_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gif_view/gif_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../../utils/app_theme.dart';
import '../controllers/home_controllers.dart';
import '../models/home_models.dart';

class MenuDesktop extends ConsumerStatefulWidget {
  final double swidth;
  const MenuDesktop({super.key, required this.swidth});

  @override
  _MenuDesktopState createState() => _MenuDesktopState();
}

class _MenuDesktopState extends ConsumerState<MenuDesktop> {
  List<Albums> albumsData = [];
  bool displayImage = true;
  final _controller = GifController(
    autoPlay: true,
    loop: false,
  );

  @override
  void initState() {
    super.initState();

    hideImage();
    getCache();
  }

  void hideImage() {
    setState(() {
      displayImage = false;
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

    return Material(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [secondary, terciary],
                stops: [.75, 1])),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
                constraints: const BoxConstraints(maxWidth: 350),
                padding: const EdgeInsets.only(bottom: 20),
                child: displayImage
                    ? GifView.asset("assets/images/danieloli.gif",
                        controller: _controller)
                    : Image.asset("assets/images/danieloli.jpg")),
            MenuItemButton(
              style: ButtonStyle(
                  mouseCursor: MaterialStateMouseCursor.textable,
                  backgroundColor: const MaterialStatePropertyAll(surface),
                  fixedSize:
                      MaterialStatePropertyAll(Size(widget.swidth * 23, 35))),
              child: const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child:
                        Icon(FontAwesomeIcons.images, color: primary, size: 15),
                  ),
                  Text("Galerias"),
                ],
              ),
              onPressed: () {},
            ),
            for (var galery in albumsData) ...{
              MenuItemButton(
                style: ButtonStyle(
                    fixedSize:
                        MaterialStatePropertyAll(Size(widget.swidth * 23, 35))),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(galery.title),
                ),
                onPressed: () async {
                  album.clear();
                  album.add(galery.albumId);
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setString("galeryId", galery.albumId);
                  Navigator.pushNamed(context, "/galerias");
                },
              )
            },
            const Spacer(flex: 2),
            Container(
              padding: const EdgeInsets.only(top: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (ModalRoute.of(context)!.settings.name != '/') ...{
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Tooltip(
                        message: "Voltar ao Home",
                        child: IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/');
                          },
                          icon: const Icon(Icons.home, color: primary),
                        ),
                      ),
                    )
                  },
                  instagramButton(context)
                ],
              ),
            ),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
