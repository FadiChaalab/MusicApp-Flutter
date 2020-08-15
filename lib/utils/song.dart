class Song {
  String _title;
  String _id;
  String _album;
  String _artist;
  String _albumArt;
  String _duration;
  String _albumId;
  String _uri;
  int min;
  int sec;
  int time;

  Song(this._album, this._id, this._artist, this._title, this._albumId,
      this._duration, this._uri, this._albumArt);

  String get album => this._album;
  String get title => this._title;
  String get data => this._id;
  String get albumId => this._albumId;
  String get url => this._uri;
  String get artist => this._artist;
  String get albumArt => this._albumArt;
  String get duration {
    time = int.parse(this._duration);
    time = (time / 1000).floor();
    min = (time / 60).floor();
    sec = time - min * 60;
    String secs = sec > 9 ? '$sec' : '0$sec';
    return '$min:$secs';
  }

  set albumId(String albumId) => this._title = albumId;
  set url(String uri) => this._id = uri;
  set title(String title) => this._title = title;
  set data(String data) => this._id = data;
  set album(String album) => this._album = album;
  set artist(String artist) => this._artist = artist;
  set albumArt(String art) => this._albumArt = art;
  set duration(String dur) => this._duration = dur;

  static Song fromJson(dynamic json) {
    return new Song(json['Album'], json['Id'], json['Artist'], json['Title'],
        json['AlbumId'], json['Duration'], json['Url'], json['AlbumArt']);
  }

  Map<String, dynamic> toJson() => {
        'Title': _title,
        'Data': _id,
        'Album': _album,
        'AlbumArt': _albumArt,
        'Artist': _artist,
        'Duration': _duration,
      };
}
