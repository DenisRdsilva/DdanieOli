import 'package:ddanieloli/utils/app_theme.dart';
import 'package:flutter/material.dart';

import '../components/footer.dart';
import '../components/menu_desktop.dart';

class TemplateSideMenu extends StatelessWidget {
  final dynamic content;
  const TemplateSideMenu({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    double swidth = MediaQuery.of(context).size.width;
    double sheight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Expanded(
          child: SizedBox(
              width: swidth,
              height: sheight,
              child: Padding(
                padding: EdgeInsets.only(left: swidth*.23),
                child: Stack(alignment: Alignment.bottomCenter, children: [
                  Expanded(
                    child: Container(
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [terciary, surface],
                                stops: [0, 1])),
                        child: content),
                  ),
                  Container( color: const Color.fromRGBO(55, 55, 55, .7), height: 50, child: const Footer()),
                ]),
              )),
        ),
        Material(
            elevation: 10,
            child: SizedBox(
                width: swidth * .23, child: MenuDesktop(swidth: swidth)))
      ],
    );
  }
}
