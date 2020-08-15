import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:modern_music/bloc/ApplicationBloc.dart';
import 'package:modern_music/bloc/BlocProvider.dart';
import 'package:modern_music/bloc/bloc.dart';
import 'package:modern_music/ui/AlbumGridWidget.dart';
import 'package:modern_music/ui/ArtistListWidget.dart';
import 'package:modern_music/ui/ChooseDialog.dart';
import 'package:modern_music/ui/DetailsContentScreen.dart';
import 'package:modern_music/ui/NewPlaylistDialog.dart';
import 'package:modern_music/ui/NoDataWidget.dart';
import 'package:modern_music/ui/PlaylistListWidget.dart';
import 'package:modern_music/ui/SongListWidget.dart';
import 'package:modern_music/utils/Utility.dart';
import 'package:modern_music/utils/color.dart';
import 'package:modern_music/utils/icon_color.dart';
import 'package:modern_music/widgets/bottom_bar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget with NavigationStates {
  final List<BarItem> barItems = [
    BarItem(
      text: "Artist",
      iconData: FontAwesome.user_o,
      color: Colors.yellow.shade900,
    ),
    BarItem(
      text: "Albums",
      iconData: Icons.album,
      color: Colors.pinkAccent,
    ),
    BarItem(
      text: "Songs",
      iconData: FontAwesome.music,
      color: Colors.indigo,
    ),
    BarItem(
      text: "Playlist",
      iconData: Icons.playlist_play,
      color: Colors.teal,
    ),
  ];
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NavigationOptions _currentNavigationOption;
  SearchBarState _currentSearchBarState;
  TextEditingController _searchController;
  ApplicationBloc bloc;

  static final Map<NavigationOptions, String> _titles = {
    NavigationOptions.ARTISTS: "Artists",
    NavigationOptions.ALBUMS: "Albums",
    NavigationOptions.SONGS: "Songs",
    NavigationOptions.PLAYLISTS: "Playlist",
  };
  @override
  void initState() {
    super.initState();
    _currentNavigationOption = NavigationOptions.ARTISTS;
    _currentSearchBarState = SearchBarState.COLLAPSED;
    _searchController = TextEditingController();
  }

  int selectedBarIndex = 0;
  int index;
  IconChanger iconChanger;
  ColorChanger colorChanger;

  @override
  Widget build(BuildContext context) {
    bloc ??= BlocProvider.of<ApplicationBloc>(context);
    colorChanger = Provider.of<ColorChanger>(context);
    iconChanger = Provider.of<IconChanger>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 15.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
          ),
          child: StreamBuilder<SearchBarState>(
              initialData: _currentSearchBarState,
              stream: bloc.searchBarState,
              builder: (context, snapshot) {
                if (snapshot.data == SearchBarState.EXPANDED)
                  return TextField(
                    controller: _searchController,
                    autofocus: true,
                    onChanged: (typed) {
                      print("make search for: ${_searchController.text}");
                      bloc.search(
                          option: _currentNavigationOption,
                          query: _searchController.text);
                    },
                    style: new TextStyle(
                      color: Theme.of(context).accentColor,
                    ),
                    decoration: new InputDecoration(
                      prefixIcon: new Icon(
                        FontAwesome.search,
                        color: Theme.of(context).accentColor,
                        size: 16,
                      ),
                      hintText:
                          "Search for ${_titles[_currentNavigationOption].toLowerCase()}...",
                      border: InputBorder.none,
                      hintStyle: new TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  );

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Music',
                        textAlign: TextAlign.center,
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
                        icon: Icon(
                          FontAwesome.music,
                        ),
                        color: Colors.indigo,
                        iconSize: 24,
                        onPressed: () {},
                      ),
                    ],
                  ),
                );
              }),
        ),
        actions: <Widget>[
          StreamBuilder<SearchBarState>(
              initialData: _currentSearchBarState,
              stream: bloc.searchBarState,
              builder: (context, snapshot) {
                switch (snapshot.data) {
                  case SearchBarState.EXPANDED:
                    return IconButton(
                        icon: Icon(
                          FontAwesome.close,
                          size: 16,
                        ),
                        tooltip:
                            "Search for ${_titles[_currentNavigationOption]}",
                        onPressed: () => bloc
                            .changeSearchBarState(SearchBarState.COLLAPSED));
                  default:
                    //case SearchBarState.COLLAPSED:
                    return IconButton(
                        icon: Icon(
                          FontAwesome.search,
                        ),
                        tooltip:
                            "Search for ${_titles[_currentNavigationOption]}",
                        onPressed: () =>
                            bloc.changeSearchBarState(SearchBarState.EXPANDED));
                }
              }),
          StreamBuilder<NavigationOptions>(
              initialData: _currentNavigationOption,
              stream: bloc.currentNavigationOption,
              builder: (context, snapshot) {
                return IconButton(
                  icon: Icon(
                    FontAwesome.sort_amount_desc,
                    size: 16,
                  ),
                  tooltip: "${_titles[snapshot.data]} Sort Type",
                  onPressed: () => _displaySortChooseDialog(snapshot.data),
                );
              }),
        ],
      ),
      body: StreamBuilder<NavigationOptions>(
        initialData: _currentNavigationOption,
        stream: bloc.currentNavigationOption,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _currentNavigationOption = snapshot.data;

            switch (_currentNavigationOption) {
              case NavigationOptions.ARTISTS:
                return StreamBuilder<List<ArtistInfo>>(
                  stream: bloc.artistStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasError)
                      return Utility.createDefaultInfoWidget(
                          Text("${snapshot.error}"));

                    if (!snapshot.hasData)
                      return Utility.createDefaultInfoWidget(
                          CircularProgressIndicator());

                    return (snapshot.data.isEmpty)
                        ? NoDataWidget(
                            title: "There is no Artists",
                          )
                        : ArtistListWidget(
                            artistList: snapshot.data,
                            onArtistSelected: _openArtistPage);
                  },
                );

              case NavigationOptions.ALBUMS:
                return StreamBuilder<List<AlbumInfo>>(
                  stream: bloc.albumStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasError)
                      return Utility.createDefaultInfoWidget(
                          Text("${snapshot.error}"));

                    if (!snapshot.hasData)
                      return Utility.createDefaultInfoWidget(
                          CircularProgressIndicator());

                    return (snapshot.data.isEmpty)
                        ? NoDataWidget(
                            title: "There is no Albums",
                          )
                        : AlbumGridWidget(
                            onAlbumClicked: _openAlbumPage,
                            albumList: snapshot.data);
                  },
                );

              case NavigationOptions.SONGS:
                return StreamBuilder<List<SongInfo>>(
                    stream: bloc.songStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasError)
                        return Utility.createDefaultInfoWidget(
                            Text("${snapshot.error}"));

                      if (!snapshot.hasData)
                        return Utility.createDefaultInfoWidget(
                            CircularProgressIndicator());

                      return (snapshot.data.isEmpty)
                          ? NoDataWidget(
                              title: "There is no Songs",
                            )
                          : SongListWidget(songList: snapshot.data);
                    });

              case NavigationOptions.PLAYLISTS:
                return StreamBuilder<List<PlaylistInfo>>(
                  stream: bloc.playlistStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasError)
                      return Utility.createDefaultInfoWidget(
                          Text("${snapshot.error}"));

                    if (!snapshot.hasData)
                      return Utility.createDefaultInfoWidget(
                          CircularProgressIndicator());

                    return (snapshot.data.isEmpty)
                        ? NoDataWidget(
                            title: "There is no Playlist",
                          )
                        : PlaylistListWidget(
                            appBloc: bloc, dataList: snapshot.data);
                  },
                );
            }
          }

          return NoDataWidget(
            title: "Something goes wrong!",
          );
        },
      ),
      bottomNavigationBar: _createBottomBarNavigator(),
      floatingActionButton: StreamBuilder<NavigationOptions>(
        initialData: _currentNavigationOption,
        stream: bloc.currentNavigationOption,
        builder: (context, snapshot) {
          switch (snapshot.data) {
            case NavigationOptions.PLAYLISTS:
              return FloatingActionButton(
                  backgroundColor: colorChanger.getAccent(),
                  elevation: 15,
                  child: Icon(
                    Icons.add,
                    color: iconChanger.getIcon(),
                  ),
                  onPressed: () => _showNewPlaylistDialog());
            default:
              return Container();
          }
        },
      ),
    );
  }

  Widget _createBottomBarNavigator() {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Theme.of(context).primaryColor,
      ),
      child: StreamBuilder<NavigationOptions>(
          initialData: _currentNavigationOption,
          stream: bloc.currentNavigationOption,
          builder: (context, snapshot) {
            if (snapshot.hasData) _currentNavigationOption = snapshot.data;

            return AnimatedBottomBar(
                barItems: widget.barItems,
                animationDuration: const Duration(milliseconds: 150),
                barStyle: BarStyle(fontSize: 18.0, iconSize: 24.0),
                onBarTap: (index) {
                  setState(() {
                    selectedBarIndex = index;
                    bloc.changeNavigation(NavigationOptions.values[index]);
                  });
                });
          }),
    );
  }

  void _displaySortChooseDialog(final NavigationOptions option) {
    showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return ChooseDialog(
            title: "${_titles[option]} Sort Options",
            initialSelectedIndex:
                bloc.getLastSortSelectionChooseBasedInNavigation(option),
            options: ApplicationBloc.sortOptionsMap[option],
            onChange: (index) {
              switch (option) {
                case NavigationOptions.ARTISTS:
                  bloc.changeArtistSortType(ArtistSortType.values[index]);
                  break;

                case NavigationOptions.ALBUMS:
                  bloc.changeAlbumSortType(AlbumSortType.values[index]);
                  break;

                case NavigationOptions.SONGS:
                  bloc.changeSongSortType(SongSortType.values[index]);
                  break;

                case NavigationOptions.PLAYLISTS:
                  bloc.changePlaylistSortType(PlaylistSortType.values[index]);
                  break;
              }
              Navigator.pop(context);
            },
          );
        });
  }

  void _showNewPlaylistDialog() async {
    showDialog(context: context, builder: (context) => NewPlaylistDialog())
        .then((data) {
      if (data != null) bloc.loadPlaylistData();
    });
  }

  @override
  void dispose() {
    print("HomeWidget dispose");
    super.dispose();
    _searchController.dispose();
  }

  void _openArtistPage(final ArtistInfo artist) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsContentScreen(
          appBarBackgroundImage: artist.artistArtPath,
          appBarTitle: artist.name,
          bodyContent: FutureBuilder<List<AlbumInfo>>(
              future: bloc.audioQuery.getAlbumsFromArtist(artist: artist.name),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Utility.createDefaultInfoWidget(
                      CircularProgressIndicator());

                return AlbumGridWidget(
                    onAlbumClicked: (album) {
                      _openArtistAlbumPage(artist, album);
                    },
                    albumList: snapshot.data);
              }),
        ),
      ),
    );
  }

  void _openArtistAlbumPage(final ArtistInfo artist, final AlbumInfo album) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsContentScreen(
          appBarBackgroundImage: album.albumArt,
          appBarTitle: album.title,
          bodyContent: FutureBuilder<List<SongInfo>>(
              future: bloc.audioQuery.getSongsFromArtistAlbum(
                  artist: artist.name,
                  sortType: SongSortType.DISPLAY_NAME,
                  albumId: album.id),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Utility.createDefaultInfoWidget(
                      CircularProgressIndicator());

                return SongListWidget(songList: snapshot.data);
              }),
        ),
      ),
    );
  }

  void _openAlbumPage(final AlbumInfo album) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsContentScreen(
          appBarBackgroundImage: album.albumArt,
          appBarTitle: album.title,
          bodyContent: FutureBuilder<List<SongInfo>>(
              future: bloc.audioQuery.getSongsFromAlbum(
                  sortType: SongSortType.DISPLAY_NAME, albumId: album.id),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Utility.createDefaultInfoWidget(
                      CircularProgressIndicator());

                return SongListWidget(songList: snapshot.data);
              }),
        ),
      ),
    );
  }

  bool searchBarIsOpen() {
    return _currentSearchBarState == SearchBarState.EXPANDED;
  }
}
