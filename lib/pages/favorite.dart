import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:modern_music/bloc/bloc.dart';
import 'package:modern_music/bloc/favorites_model.dart';
import 'package:modern_music/ui/ListItemWidget.dart';
import 'package:modern_music/ui/detailed_song.dart';
import 'package:modern_music/utils/Utility.dart';
import 'package:modern_music/utils/icon_color.dart';
import 'package:provider/provider.dart';

class MyFavoritesPage extends StatefulWidget with NavigationStates {
  @override
  _MyFavoritesPageState createState() => _MyFavoritesPageState();
}

class _MyFavoritesPageState extends State<MyFavoritesPage> {
  IconChanger iconChanger;

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    iconChanger = Provider.of<IconChanger>(context);
    return Scaffold(
      body: WillPopScope(
        onWillPop: () {
          return null;
        },
        child: Container(
          width: _width,
          height: _height,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: _height * 0.05,
              ),
              Container(
                height: _height * 0.1,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 50.0,
                        right: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Favorites',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                              letterSpacing: 1.2,
                              fontFamily: 'Poppins',
                              shadows: <Shadow>[
                                Shadow(
                                  color: Colors.black,
                                  blurRadius: 2,
                                  offset: Offset(1, 1),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              FontAwesome.heart,
                              color: iconChanger.getIcon(),
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: _height * 0.05,
              ),
              Container(
                height: _height * 0.8,
                child: Consumer<FavoriteModel>(
                  builder: (context, f, _) {
                    List<SongInfo> favorites = f.favorites;
                    if (f.favorites == null) {
                      return _buildWidgetLoading();
                    } else if (f.favorites.length == 0) {
                      return _buildWidgetNoResult();
                    }
                    return ListView.builder(
                      key: PageStorageKey<String>("favorites"),
                      itemCount: favorites.length,
                      itemBuilder: (BuildContext context, int index) {
                        SongInfo song = favorites[index];
                        return ListItemWidget(
                          title: Text(
                            "${song.title}",
                            softWrap: true,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                "Artist : ${song.artist}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Duration : " +
                                    Utility.parseToMinutesSeconds(
                                        int.parse(song.duration)),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              FontAwesome.heart,
                            ),
                            color: Colors.red,
                            onPressed: () {
                              favorites.remove(song);
                            },
                          ),
                          imagePath: song.albumArtwork,
                          onTap: () {
                            print(song.id);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => DetailedSong(
                                  songInfo: song,
                                  url: song.filePath,
                                  indexSong: index,
                                  length: favorites.length,
                                  songs: favorites,
                                  nowPlayTap: true,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWidgetLoading() {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.white54,
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    );
  }

  Widget _buildWidgetNoResult() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                "No Favorites",
                style: TextStyle(color: Colors.white54),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          )
        ],
      ),
    );
  }
}
