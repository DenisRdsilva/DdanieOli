import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/app_theme.dart';

Widget instagramButton(context) {
  return Tooltip(
    message: "Siga @ddanieloli_fotografias",
    child: IconButton(
        onPressed: () => _launchUrl(),
        icon: const Icon(FontAwesomeIcons.instagram, size: 20, color: primary)),
  );
}

final Uri _url = Uri.parse('https://www.instagram.com/danieloli_fotografias/');

Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}
