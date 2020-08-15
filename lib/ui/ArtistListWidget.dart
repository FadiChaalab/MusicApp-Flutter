import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:snaplist/snaplist.dart';
import './CardItemWidget.dart';

class ArtistListWidget extends StatelessWidget {
  final List<ArtistInfo> artistList;
  final _callback;

  ArtistListWidget({
    @required this.artistList,
    onArtistSelected(final ArtistInfo info),
  }) : _callback = onArtistSelected;

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
            ArtistInfo artist = artistList[index];
            return Stack(
              children: <Widget>[
                CardItemWidget(
                  title: "${artist.name}",
                  infoS: "Songs : ",
                  subtitle: "${artist.numberOfTracks}",
                  infoT: "Albums : ",
                  infoText: "${artist.numberOfAlbums}",
                  backgroundImage: artist.artistArtPath,
                ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(onTap: () {
                      if (_callback != null) _callback(artist);
                      print("Artist clicked ${artist.name}");
                    }),
                  ),
                ),
              ],
            );
          },
          count: artistList.length,
          snaplistController: controller,
          snipCurve: Curves.decelerate,
          snipDuration: Duration(milliseconds: 400),
        ),
      ],
    );
  }
}
