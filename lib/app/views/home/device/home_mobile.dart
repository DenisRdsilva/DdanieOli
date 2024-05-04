import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:ddanieloli/app/views/home/home_view.dart';
import 'package:flutter/material.dart';

import '../../../../utils/app_theme.dart';

class HomeMobile extends StatefulWidget {
  final double swidth;
  const HomeMobile({super.key, required this.swidth});

  @override
  State<HomeMobile> createState() => _HomeMobileState();
}

class _HomeMobileState extends State<HomeMobile> {
  List<bool> thisAlbum = List.filled(5, false);
  int currentIndex = 0;
  Timer? timer;

  List<Widget> imagesHome = [
    for (var i = 1; i <= 5; i++) ...{
      Image.asset("assets/images/gal${i}m.jpg"),
    }
  ];

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      setState(() {
        thisAlbum[currentIndex] = false;
        currentIndex = (currentIndex + 1) % galeriesTitle.length;
        thisAlbum[currentIndex] = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    CarouselController buttonCarouselController = CarouselController();
    return Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Divider(height: 5, color: secondary),
                for (var i = 0; i < galeriesTitle.length; i++) ...[
                  Material(
                      color: Colors.transparent,
                      child: Text(galeriesTitle[i],
                          textScaler: const TextScaler.linear(2),
                          style: TextStyle(
                              letterSpacing: 0,
                              color: thisAlbum[i] ? primary : secondary))),
                  const Divider(height: 5, color: secondary),
                ],
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: CarouselSlider(
              items: imagesHome,
              carouselController: buttonCarouselController,
              options: CarouselOptions(
                scrollDirection: Axis.vertical,
                scrollPhysics: const NeverScrollableScrollPhysics(),
                autoPlay: true,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(seconds: 5),
                pauseAutoPlayOnTouch: false,
                enlargeCenterPage: true,
                enlargeFactor: .2,
                viewportFraction: .55,
                initialPage: 0,
              ),
            ),
          ),
        ]);
  }
}
