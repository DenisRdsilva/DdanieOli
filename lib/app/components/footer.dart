import 'package:ddanieloli/utils/app_theme.dart';
import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Material(color: Colors.transparent, child: Text("Daniel Oli Photography © Designed by DSilva", style: textTheme.bodyMedium)),
      ],
    );
  }
}