import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class FavoritesHelper {
  static Database _database;
  String table = "favorites";

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    var documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "favorites.db";
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute("CREATE TABLE $table ("
            "_id TEXT,"
            "artist TEXT,"
            "title TEXT,"
            "album TEXT,"
            "album_id TEXT,"
            "duration TEXT,"
            "_data TEXT,"
            "album_artwork TEXT"
            ")");
      },
    );
  }

  remove(SongInfo s) async {
    final db = await database;
    await db.rawDelete("delete from $table where _id = ${s.id}");
  }

  add(SongInfo s) async {
    final db = await database;
    var res = await db.insert(table, toMap(s));
    return res;
  }

  getFavorites() async {
    final db = await database;
    var res = await db.query(table);
    List<SongInfo> list = res.isNotEmpty
        ? res.map((c) => SongInfo.fromMap(c)).toList()
        : List<SongInfo>();
    return list;
  }

  toMap(SongInfo s) {
    return {
      '_id': s.id,
      'artist': s.artist,
      'title': s.title,
      'album': s.album,
      'album_id': s.albumId,
      'duration': s.duration,
      '_data': s.filePath,
      'album_artwork': s.albumArtwork
    };
  }
}
