import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../utils/app_theme.dart';
import '../home_view.dart';

List<Widget> imagesHome = [
  for (var i = 1; i <= 5; i++) ...{
    Stack(
      alignment: AlignmentDirectional.center,
      children: [
      Image.asset("assets/images/gal$i.jpg"),
      Column(
        children: [
          SizedBox(width: double.maxFinite, height: 60, child: Material( color: const Color.fromRGBO(55, 55, 55, .75), child: Center(child: Text(galeriesTitle[i-1], style: textTheme.displayLarge)))),
          const Spacer()
        ],
      )
    ])
  }
];

Widget homeDesktop(context, swidth) {
  CarouselController buttonCarouselController = CarouselController();
  return Stack(
      fit: StackFit.expand,
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        CarouselSlider(
          items: imagesHome,
          carouselController: buttonCarouselController,
          options: CarouselOptions(
            autoPlay: true,
            autoPlayCurve: Easing.emphasizedDecelerate,
            autoPlayInterval: const Duration(seconds: 5),
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
                onPressed: () => buttonCarouselController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.linear),
                icon: const Icon(Icons.arrow_back_ios_sharp, color: primary),
              ),
              IconButton(
                onPressed: () => buttonCarouselController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.linear),
                icon: const Icon(Icons.arrow_forward_ios_sharp, color: primary),
              ),
            ],
          ),
        )
      ]);
}
