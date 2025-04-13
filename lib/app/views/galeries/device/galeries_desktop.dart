import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/app_theme.dart';
import '../../../controllers/home_controllers.dart';

class GaleriesDesktop extends ConsumerStatefulWidget {
  final bool displayContent;
  final String albumsData;
  const GaleriesDesktop(
      {super.key, required this.displayContent, required this.albumsData});

  @override
  _GaleriesDesktopState createState() => _GaleriesDesktopState();
}

class _GaleriesDesktopState extends ConsumerState<GaleriesDesktop> {
  List<String> imagesList = [];
  CarouselSliderController buttonCarouselController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    double swidth = MediaQuery.of(context).size.width;
    return FutureBuilder<void>(
      future: getPhotosfromAlbum(widget.albumsData, 'b', ref),
      builder: (context, snapshot) {
        // if (snapshot.connectionState == ConnectionState.done) {
        if (widget.displayContent == true) {
          final imagesData = ref.watch(imagesUrl);
          List<String?> imagesList = [...imagesData];
          List<Widget> imageWidgets = imagesList.map((imageString) {
            return Image.network(
              imageString!,
            );
          }).toList();
          return Stack(
              fit: StackFit.expand,
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                CarouselSlider(
                  items: imageWidgets,
                  carouselController: buttonCarouselController,
                  options: CarouselOptions(
                    autoPlay: true,
                    autoPlayCurve: Easing.emphasizedDecelerate,
                    autoPlayInterval: const Duration(seconds: 5),
                    enlargeCenterPage: true,
                    viewportFraction: .67,
                    initialPage: 0,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: swidth * .05),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        color: primary,
                        style: const ButtonStyle(
                            elevation: WidgetStatePropertyAll(4),
                            shape: WidgetStatePropertyAll(
                                CircleBorder(eccentricity: 1))),
                        onPressed: () => buttonCarouselController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.linear),
                        icon: const Icon(Icons.arrow_back_ios_sharp),
                      ),
                      IconButton(
                        color: primary,
                        style: const ButtonStyle(
                            elevation: WidgetStatePropertyAll(4),
                            shape: WidgetStatePropertyAll(
                                CircleBorder(eccentricity: 1))),
                        onPressed: () => buttonCarouselController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.linear),
                        icon: const Icon(Icons.arrow_forward_ios_sharp),
                      ),
                    ],
                  ),
                )
              ]);
        } else if (snapshot.hasError) {
          Container();
        }
        return Container();
      },
    );
  }
}
