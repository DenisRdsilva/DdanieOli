import 'dart:convert';

import 'package:ddanieloli/app/models/home_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

Future<List<dynamic>> getAlbums() async {
  final response = await http.get(Uri.parse(
      "https://www.flickr.com/services/rest/?method=flickr.photosets.getList&api_key=b9d49290484e32fd53f7ab3de4020cf6&user_id=200584034%40N02&format=json&nojsoncallback=1"));
  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    final albumsData = jsonData["photosets"]["photoset"] as List<dynamic>;

    final albums = albumsData.map((album) {
      final albumId = album["id"];
      final titleContent = album["title"]["_content"];
      return Albums(albumId: albumId, title: titleContent, isSelected: false);
    }).toList();

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> albumIdList = [];
      List<String> albumTitleList = [];
      for (var album in albums) {
        logger.info(album.albumId);
        albumIdList.add(album.albumId);
        albumTitleList.add(album.title);
      }
      await prefs.setStringList("albumId", albumIdList);
      await prefs.setStringList("albumTitle", albumTitleList);

      logger.info('Data saved to SharedPreferences.');
    } catch (e) {
      logger.info('Error saving data to SharedPreferences: $e');
    }

    return albums;
  } else {
    throw Exception('Failed to load data: ${response.statusCode}');
  }
}

final selectedAlbum = StateProvider<List<String?>>((ref) {
  return [];
});

final imagesUrl = StateProvider<List<String?>>((ref) {
  return [];
});

Future<List<String>> getPhotosfromAlbum(
    String galeryId, String sizeImg, WidgetRef ref) async {
  final response = await http.get(Uri.parse(
      "https://www.flickr.com/services/rest/?method=flickr.photosets.getPhotos&api_key=b9d49290484e32fd53f7ab3de4020cf6&photoset_id=$galeryId&user_id=200584034%40N02&format=json&nojsoncallback=1"));
  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    final albumData = jsonData["photoset"];

    // final albumID = albumData["id"];
    // final owner = albumData["owner"];
    final photos = (albumData["photo"] as List<dynamic>).map<Photos>((image) {
      return Photos(
          photoId: image['id'],
          secret: image['secret'],
          server: image['server'],
          farm: image['farm'],
          title: image['title']);
    }).toList();

    List<String> imageSrcs = [];

    final imgSrc = ref.read(imagesUrl);
    imgSrc.clear();

    for (var image in photos) {
      String imageUrl =
          "https://live.staticflickr.com/${image.server}/${image.photoId}_${image.secret}_$sizeImg.jpg";
      imageSrcs.add(imageUrl);
      imgSrc.add(imageUrl);
    }

    // logger.info(photos);
    return imageSrcs;
  } else {
    throw Exception('Failed to load data: ${response.statusCode}');
  }
}
