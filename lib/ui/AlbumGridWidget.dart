import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:snaplist/snaplist.dart';
import './CardItemWidget.dart';

/// widget that show a gridView with all albums of a specific artist
class AlbumGridWidget extends StatelessWidget {
  final _onItemTap;
  final List<AlbumInfo> dataList;

  AlbumGridWidget(
      {@required List<AlbumInfo> albumList,
      onAlbumClicked(final AlbumInfo info)})
      : _onItemTap = onAlbumClicked,
        dataList = albumList;

  @override
  Widget build(BuildContext context) {
    final Size cardSize = Size(260.0, 360.0);
    final Size cardSizeSmall = Size(260.0, 300.0);
    final controller = SnaplistController(initialPosition: 0);
    return Stack(
      children: <Widget>[
        SnapList(
          padding: EdgeInsets.only(
              left: (MediaQuery.of(context).size.width - cardSize.width) / 2),
          sizeProvider: (index, data) {
            if (data.progress == 0 && data.center == index) {
              return cardSize;
            } else if (data.next < data.center && data.next == index) {
              return cardSize;
            } else if (data.next >= data.center && data.center == index - 1) {
              return cardSize;
            } else {
              return cardSizeSmall;
            }
          },
          separatorProvider: (index, data) => Size(10.0, 10.0),
          positionUpdate: (int index) {},
          builder: (context, index, data) {
            AlbumInfo album = dataList[index];
            return Stack(
              children: <Widget>[
                CardItemWidget(
                  title: album.title,
                  infoS: "Songs : ",
                  subtitle: "${album.numberOfSongs}",
                  infoT: "Artist : ",
                  infoText: "${album.artist}",
                  backgroundImage: album.albumArt,
                ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(onTap: () {
                      if (_onItemTap != null) _onItemTap(album);

                      print("Album clicked ${album.title}");
                    }),
                  ),
                ),
              ],
            );
          },
          count: dataList.length,
          snaplistController: controller,
        ),
      ],
    );
  }
}
