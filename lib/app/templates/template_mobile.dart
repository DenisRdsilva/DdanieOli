import 'package:ddanieloli/app/components/menu_mobile.dart';
import 'package:ddanieloli/utils/app_theme.dart';
import 'package:flutter/material.dart';

import '../components/footer.dart';

class TemplateColMenu extends StatelessWidget {
  final dynamic content;
  const TemplateColMenu({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    double swidth = MediaQuery.of(context).size.width;
    double sheight = MediaQuery.of(context).size.height;
    return Container(
        height: sheight,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [surface, onPrimary, surface],
                stops: [.15, .60, .80])),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SizedBox(
                height: sheight,
                width: swidth,
                child: Image.asset("assets/images/backmobile.jpg",
                    opacity: const AlwaysStoppedAnimation(.6),
                    fit: BoxFit.cover)),
            content,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Material(elevation: 2, child: MenuMobile(swidth: swidth)),
                const Material(
                    elevation: 2,
                    color: Color.fromRGBO(55, 55, 55, .7),
                    child: SizedBox(height: 50, child: Footer())),
              ],
            )
          ],
        ));
  }
}
