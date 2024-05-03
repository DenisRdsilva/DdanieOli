// ignore_for_file: library_private_types_in_public_api

import 'package:ddanieloli/app/controllers/home_controllers.dart';
import 'package:ddanieloli/app/templates/template_desktop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';
import '../../templates/template_mobile.dart';
import 'device/galeries_desktop.dart';
import 'device/galeries_mobile.dart';

class GaleriesPage extends ConsumerStatefulWidget {
  const GaleriesPage({super.key});

  @override
  _GaleriesPageState createState() => _GaleriesPageState();
}

class _GaleriesPageState extends ConsumerState<GaleriesPage> {
  String albumsData = '';
  bool displayContent = false;

  @override
  void initState() {
    super.initState();
    getAlbumId();
  }

  void getAlbumId() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? albumId = prefs.getString("galeryId");
      setState(() {
        albumsData = albumId!;
        displayContent = true;
      });
    } catch (e) {
      logger.info("Sem dado no cache: $e");
    }

    if (albumsData == "") {
      final albumData = ref.watch(selectedAlbum);

      List<String?> data = [...albumData];
      setState(() {
        albumsData = data[0]!;
        displayContent = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double swidth = MediaQuery.of(context).size.width;
    if (swidth > 1000) {
      return TemplateSideMenu(
          content: GaleriesDesktop(
              displayContent: displayContent, albumsData: albumsData));
    } else {
      return TemplateColMenu(
          content: GaleriesMobile(
              displayContent: displayContent, albumsData: albumsData));
    }
  }
}