import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:modern_music/bloc/ApplicationBloc.dart';
import 'package:modern_music/bloc/BlocProvider.dart';

import 'package:modern_music/ui/PlaylistDetailScreen.dart';
import './ListItemWidget.dart';

class PlaylistListWidget extends StatelessWidget {
  final List<PlaylistInfo> dataList;
  final ApplicationBloc appBloc;
  PlaylistListWidget({@required this.dataList, @required this.appBloc});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          PlaylistInfo playlistInfo = dataList[index];

          return ListItemWidget(
            title: Text(
              playlistInfo.name,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            subtitle: Text(
              "Total songs : ${playlistInfo.memberIds.length}",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              _showPlaylistDetailsScreen(playlistInfo, context);
            },
            trailing: IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 24,
                ),
                onPressed: () {
                  FlutterAudioQuery.removePlaylist(playlist: playlistInfo);
                  appBloc.loadPlaylistData();
                }),
          );
        });
  }

  void _showPlaylistDetailsScreen(
      final PlaylistInfo playlist, BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return BlocProvider(
        bloc: PlaylistDetailScreenBloc(playlist),
        child: PlaylistDetailScreen(),
      );
    }));
  }
}
