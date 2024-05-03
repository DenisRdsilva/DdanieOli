
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/home_controllers.dart';

class GaleriesMobile extends ConsumerStatefulWidget {
  final bool displayContent;
  final String albumsData;
  const GaleriesMobile(
      {super.key, required this.displayContent, required this.albumsData});

  @override
  _GaleriesMobileState createState() => _GaleriesMobileState();
}

class _GaleriesMobileState extends ConsumerState<GaleriesMobile> {
  List<String> imagesList = [];
  CarouselController buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    // logger.info("$data, $albumData");
    return FutureBuilder<void>(
      future: getPhotosfromAlbum(widget.albumsData, 'z', ref),
      builder: (context, snapshot) {
        // if (snapshot.connectionState == ConnectionState.done) {
        final imagesData = ref.watch(imagesUrl);
        List<String?> imagesList = [...imagesData];
        List<Widget> imageWidgets = imagesList.map((imageString) {
          return Image.network(
            imageString!,
          );
        }).toList();
        if (widget.displayContent == true) {
          return Container(
            margin: const EdgeInsets.only(top: 100, bottom: 40),
            child: Stack(
                fit: StackFit.expand,
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  CarouselSlider(
                    items: imageWidgets,
                    carouselController: buttonCarouselController,
                    options: CarouselOptions(
                      scrollDirection: Axis.vertical,
                      autoPlay: false,
                      enlargeCenterPage: true,
                      enlargeFactor: .25,
                      autoPlayAnimationDuration: const Duration(seconds: 5),
                      viewportFraction: .5,
                      initialPage: 0,
                    ),
                  ),
                ]),
          );
        } else if (snapshot.hasError) {
          Container();
        }
        return Container();
      },
    );
  }
}
