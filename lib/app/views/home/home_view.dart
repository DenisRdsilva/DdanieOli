import 'package:carousel_slider/carousel_slider.dart';
import 'package:ddanieloli/app/views/home/device/home_desktop.dart';
import 'package:ddanieloli/app/views/home/device/home_mobile.dart';
import 'package:flutter/material.dart';

import '../../templates/template_desktop.dart';
import '../../templates/template_mobile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

List<String> galeriesTitle = [
  "A Arte Vive",
  "Andando pela Natureza",
  "Devaneios do Artista",
  "Selvas de Pedra",
  "Trabalhadores da Praia"
];

class _HomePageState extends State<HomePage> {
  CarouselController buttonCarouselController = CarouselController();
  

  @override
  Widget build(BuildContext context) {
    double swidth = MediaQuery.of(context).size.width;

    if (swidth > 1000) {
      return TemplateSideMenu(
          content: homeDesktop(context, swidth));
    } else {
      return TemplateColMenu(
          content: HomeMobile(swidth: swidth));
    }
  }
}
