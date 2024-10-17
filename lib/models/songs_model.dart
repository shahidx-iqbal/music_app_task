class SongModel {
  int? id;
  String name;
  String artist;
  String url;
  bool isPlaying;

  SongModel({this.id, required this.name, required this.artist, required this.url, this.isPlaying = false});

  factory SongModel.fromMap(Map<String, dynamic> map) {
    return SongModel(
      id: map['id'],
      name: map['name'],
      artist: map['artist'],
      url: map['url'],
      isPlaying: map['isPlaying'] == 1, // Assuming isPlaying is stored as an integer (1 or 0)
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'artist': artist,
      'url': url,
      'isPlaying': isPlaying ? 1 : 0, // Store isPlaying as an integer (1 or 0)
    };
  }
}
