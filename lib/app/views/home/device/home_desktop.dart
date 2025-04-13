import 'package:carousel_slider/carousel_slider.dart';
import 'package:ddanieloli/app/components/menu_desktop.dart';
import 'package:ddanieloli/app/models/home_models.dart';
import 'package:flutter/material.dart';

import '../../../../utils/app_theme.dart';

class HomeDesktop extends StatefulWidget {
  final double swidth;
  const HomeDesktop({super.key, required this.swidth});

  @override
  State<HomeDesktop> createState() => _HomeDesktopState();
}

class _HomeDesktopState extends State<HomeDesktop> {
  List<Albums> albumsData = [];
  CarouselSliderController buttonCarouselController =
      CarouselSliderController();

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
    List<Widget> buildImagesHome = [
      for (var i = 1; i < albumsData.length; i++)
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Image.asset("assets/images/gal$i.jpg"),
            Column(
              children: [
                SizedBox(
                  width: double.maxFinite,
                  height: 60,
                  child: Material(
                    color: const Color.fromRGBO(55, 55, 55, .75),
                    child: Center(
                      child: Text(
                        albumsData[i - 1].title,
                        style: textTheme.displayLarge,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            )
          ],
        )
    ];

    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        CarouselSlider(
          items: buildImagesHome,
          carouselController: buttonCarouselController,
          options: CarouselOptions(
            autoPlay: true,
            autoPlayCurve: Easing.emphasizedDecelerate,
            autoPlayInterval: const Duration(seconds: 5),
            initialPage: 0,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: widget.swidth * .05),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => buttonCarouselController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.linear,
                ),
                icon: const Icon(Icons.arrow_back_ios_sharp, color: primary),
              ),
              IconButton(
                onPressed: () => buttonCarouselController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.linear,
                ),
                icon: const Icon(Icons.arrow_forward_ios_sharp, color: primary),
              ),
            ],
          ),
        )
      ],
    );
  }
}
