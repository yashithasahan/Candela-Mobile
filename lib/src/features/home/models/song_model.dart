class SongModel {
  final String? id;
  final String? userId;
  final String? songName;
  final String? songArtist;
  final int? songPrice;
  final String? duration;
  final DateTime? songdate;
  final String? totalSongs;

  SongModel({
    this.id,
    this.userId,
    this.songName,
    this.songArtist,
    this.songPrice,
    this.duration,
    this.songdate,
    this.totalSongs,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'songName': songName,
      'songArtist': songArtist,
      'songPrice': songPrice,
      'duration': duration,
      'songdate': songdate,
      'totalSongs': totalSongs,
    };
  }

  factory SongModel.fromJson(Map<String, dynamic> json) {
    return SongModel(
      userId: json['userId'],
      songName: json['songName'],
      songArtist: json['songArtist'],
      songPrice: json['songPrice'],
      duration: json['duration'],
      songdate: (json['songdate']).toDate(),
      totalSongs: json['totalSongs'],
    );
    
  }
}
