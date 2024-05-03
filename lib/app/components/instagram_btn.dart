import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utils/app_theme.dart';

Widget instagramButton(context) {
  return Tooltip(
    message: "Siga @ddanieloli_fotografias",
    child: IconButton(
        onPressed: () {},
        icon: const Icon(FontAwesomeIcons.instagram, size: 20, color: primary)),
  );
}
