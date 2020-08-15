import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:modern_music/ui/detailed_song.dart';
import 'package:modern_music/utils/Utility.dart';

import './ListItemWidget.dart';
import './NoDataWidget.dart';

class SongListWidget extends StatefulWidget {
  final List<SongInfo> songList;
  final bool addToPlaylistAction;

  SongListWidget({@required this.songList, this.addToPlaylistAction = true});

  @override
  _SongListWidgetState createState() => _SongListWidgetState();
}

class _SongListWidgetState extends State<SongListWidget> {
  final String _dialogTitle = "Choose Playlist";

  final FlutterAudioQuery audioQuery = FlutterAudioQuery();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.songList.length,
        itemBuilder: (context, songIndex) {
          SongInfo song = widget.songList[songIndex];

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
                  "Duration : ${Utility.parseToMinutesSeconds(int.parse(song.duration))}",
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            trailing: (widget.addToPlaylistAction == true)
                ? IconButton(
                    icon: Icon(
                      Icons.playlist_add,
                      color: Colors.pink,
                      size: 32,
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(_dialogTitle),
                              content: FutureBuilder<List<PlaylistInfo>>(
                                  future: audioQuery.getPlaylists(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      print("has error");
                                      return Utility.createDefaultInfoWidget(
                                          Text("${snapshot.error}"));
                                    }

                                    if (snapshot.hasData) {
                                      if (snapshot.data.isEmpty) {
                                        print("is Empty");
                                        return NoDataWidget(
                                          title: "There is no playlists",
                                        );
                                      }

                                      return PlaylistDialogContent(
                                        options: snapshot.data
                                            .map((playlist) => playlist.name)
                                            .toList(),
                                        onSelected: (index) {
                                          snapshot.data[index]
                                              .addSong(song: song);
                                          Navigator.pop(context);
                                        },
                                      );
                                    }

                                    print("has no data");
                                    return Utility.createDefaultInfoWidget(
                                        CircularProgressIndicator());
                                  }),
                            );
                          });
                    },
                    tooltip: "add to playlist",
                  )
                : Container(
                    width: .0,
                    height: .0,
                  ),
            imagePath: song.albumArtwork,
            onTap: () {
              print(song.filePath);

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => DetailedSong(
                        songInfo: song,
                        url: song.filePath,
                        indexSong: songIndex,
                        length: widget.songList.length,
                        songs: widget.songList,
                        nowPlayTap: true,
                      )));
            },
          );
        });
  }
}

typedef OnSelected = void Function(int index);

class PlaylistDialogContent extends StatefulWidget {
  final List<String> options;
  final OnSelected onSelected;
  final int initialIndexSelected;

  PlaylistDialogContent(
      {@required this.options, this.onSelected, this.initialIndexSelected});

  @override
  _PlaylistDialogContentState createState() => _PlaylistDialogContentState();
}

class _PlaylistDialogContentState extends State<PlaylistDialogContent> {
  int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndexSelected;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: MediaQuery.of(context).size.height * 0.7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.options.length,
                itemBuilder: (context, index) {
                  return RadioListTile(
                      title: Text(widget.options[index]),
                      value: index,
                      groupValue: selectedIndex,
                      onChanged: (value) {
                        setState(() {
                          selectedIndex = value;
                        });
                        if (widget.onSelected != null)
                          widget.onSelected(selectedIndex);
                      });
                }),
          ),
        ],
      ),
    );
  }
}
