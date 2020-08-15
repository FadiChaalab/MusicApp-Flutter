import 'package:flutter/widgets.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:modern_music/bloc/behavior.dart';

class FavoriteModel extends ChangeNotifier {
  FavoritesHelper db;
  List<SongInfo> favorites = List<SongInfo>();

  FavoriteModel() {
    db = FavoritesHelper();
    fetchFavorites();
  }

  add(SongInfo song) async {
    if (!alreadyExists(song)) {
      await db.add(song);
      fetchFavorites();
    }
  }

  remove(SongInfo song) async {
    await db.remove(song);
    fetchFavorites();
  }

  alreadyExists(SongInfo s) {
    for (SongInfo item in favorites) {
      if (s.filePath == item.filePath) return true;
    }
    return false;
  }

  fetchFavorites() async {
    favorites = await db.getFavorites();
    notifyListeners();
  }
}
