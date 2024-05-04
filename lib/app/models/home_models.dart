class PhotoSet {
  final String albumID;
  final String owner;
  final List<Photos> photo;

  PhotoSet({required this.albumID, required this.owner, required this.photo});
}

class Photos {
  final String photoId;
  final String secret;
  final String server;
  final int farm;
  final String title;

  Photos({required this.photoId, required this.secret, required this.server, required this.farm, required this.title});
}

class Albums {
  final String albumId;
  late final bool isSelected;
  final String title;

  Albums({required this.albumId, required this.isSelected, required this.title});
}
