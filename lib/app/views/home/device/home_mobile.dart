import 'package:carousel_slider/carousel_controller.dart' as slider;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ddanieloli/app/components/menu_desktop.dart';
import 'package:ddanieloli/app/models/home_models.dart';
import 'package:flutter/material.dart';

class HomeMobile extends StatefulWidget {
  final double swidth;
  const HomeMobile({super.key, required this.swidth});

  @override
  State<HomeMobile> createState() => _HomeMobileState();
}

class _HomeMobileState extends State<HomeMobile> {
  int currentIndex = 0;
  List<Albums> albumsData = [];

  @override
  void initState() {
    super.initState();

    getCache().then((response) {
      displayData(response);
    });
  }

  void displayData(data) {
    setState(() {
      albumsData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> imagesHome = [
      for (var i = 1; i < albumsData.length; i++) ...{
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image.asset("assets/images/gal${i}m.jpg"),
            SizedBox(
                child: Material(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(albumsData[i-1].title,
                          textScaler: const TextScaler.linear(1.8),
                          style: const TextStyle(
                            shadows: [
                              Shadow(
                                offset: Offset(0, 2),
                                blurRadius: 5,
                                color: Colors.black,
                              )
                            ],
                          )),
                    ))),
          ],
        ),
      }
    ];

    final slider.CarouselSliderController buttonCarouselController =
        slider.CarouselSliderController();
    return Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: <Widget>[
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
                viewportFraction: .46,
                initialPage: 0,
              ),
            ),
          ),
        ]);
  }
}
