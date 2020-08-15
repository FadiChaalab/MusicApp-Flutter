import 'dart:io';

import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:marquee/marquee.dart';
import 'package:modern_music/Animation/FadeAnimation.dart';
import 'package:modern_music/bloc/favorites_model.dart';
import 'package:modern_music/ui/NoDataWidget.dart';
import 'package:modern_music/ui/SongListWidget.dart';
import 'package:modern_music/utils/Utility.dart';
import 'package:modern_music/utils/playerstate.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class DetailedSong extends StatefulWidget {
  final url;
  final SongInfo songInfo;
  final bool nowPlayTap;
  final PlayerMode mode;
  int indexSong;
  final length;
  final List<SongInfo> songs;

  DetailedSong(
      {Key key,
      this.songInfo,
      this.url,
      this.nowPlayTap,
      this.mode = PlayerMode.MEDIA_PLAYER,
      this.indexSong,
      this.length,
      this.songs})
      : super(key: key);
  @override
  _DetailedSongState createState() => _DetailedSongState(url, mode);
}

class _DetailedSongState extends State<DetailedSong>
    with TickerProviderStateMixin {
  AudioPlayer audioPlayer;
  PlayerState playerState;
  Duration _duration;
  Duration _position;
  String url;
  PlayerMode mode;
  bool isLoop = false;
  bool isShuffle = false;
  Random rnd = new Random();
  final String _dialogTitle = "Choose Playlist";
  SongInfo songCurrent;
  final FlutterAudioQuery audioQuery = FlutterAudioQuery();
  AudioPlayerState audioPlayerState;
  PlayerState _playerState = PlayerState.stopped;
  StreamSubscription _durationSubscription;
  StreamSubscription _positionSubscription;
  StreamSubscription _playerCompleteSubscription;
  StreamSubscription _playerErrorSubscription;
  StreamSubscription _playerStateSubscription;

  get _isPlaying => _playerState == PlayerState.playing;

  _DetailedSongState(this.url, this.mode);
  @override
  void initState() {
    super.initState();
    _initAudioPlayer();

    if (widget.nowPlayTap == true) {
      setState(() {
        _playerState = PlayerState.playing;
        stop();
        _play(widget.songInfo);
      });
    }
  }

  void toggleLoop() {
    isLoop = !isLoop;
  }

  void toggleShuffle() {
    isShuffle = !isShuffle;
  }

  get _durationText => _duration?.toString()?.split('.')?.first ?? '';
  get _positionText => _position?.toString()?.split('.')?.first ?? '';

  Future<int> _play(SongInfo song) async {
    final result = await audioPlayer.play(song.filePath);
    if (result == 1) setState(() => _playerState = PlayerState.playing);

    audioPlayer.setPlaybackRate(playbackRate: 1.0);

    return result;
  }

  Future<int> _pause() async {
    final result = await audioPlayer.pause();
    if (result == 1) setState(() => _playerState = PlayerState.paused);
    return result;
  }

  Future stop() async {
    int result = await audioPlayer.stop();
    if (result == 1)
      setState(() {
        playerState = PlayerState.stopped;
      });
  }

  Future<SongInfo> nextSong() async {
    if (widget.indexSong != null && widget.songs != null) {
      if (widget.indexSong < widget.length) widget.indexSong++;
      if (widget.indexSong == widget.length)
        widget.indexSong = widget.indexSong - widget.length;
    }
    return widget.songs[widget.indexSong];
  }

  Future<SongInfo> prevSong() async {
    if (widget.indexSong != null && widget.songs != null) {
      if (widget.indexSong > 0) widget.indexSong--;
      if (widget.indexSong == 0)
        widget.indexSong = widget.indexSong + widget.length - 1;
    }
    return widget.songs[widget.indexSong];
  }

  void _onComplete(SongInfo updateSong) {
    setState(() => songCurrent = updateSong);
  }

  @override
  void dispose() {
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _playerErrorSubscription?.cancel();
    _playerStateSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    if (isShuffle == false) {
      setState(() {
        songCurrent = widget.songs[widget.indexSong];
      });
    }

    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: songCurrent.albumArtwork != null
                            ? FileImage(
                                File(songCurrent.albumArtwork),
                              )
                            : AssetImage('assets/images/3.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.blue.withOpacity(0.4), Colors.blue],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: _height * 0.052),
                        FadeAnimation(
                          1,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(50.0)),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                              Column(
                                children: <Widget>[
                                  Text(
                                    'PLAYLIST',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.6),
                                    ),
                                  ),
                                  Text(
                                    'Best Vibes of all the Time',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              Consumer<FavoriteModel>(
                                builder: (context, favorites, _) => IconButton(
                                  onPressed: () {
                                    if (!favorites.alreadyExists(
                                        widget.songs[widget.indexSong])) {
                                      favorites
                                          .add(widget.songs[widget.indexSong]);
                                    } else {
                                      favorites.remove(
                                          widget.songs[widget.indexSong]);
                                    }
                                  },
                                  icon: Icon(
                                    favorites.alreadyExists(
                                            widget.songs[widget.indexSong])
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: favorites.alreadyExists(
                                            widget.songs[widget.indexSong])
                                        ? Colors.red
                                        : Colors.white,
                                    size: 35.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: _height * 0.14,
                        ),
                        FadeAnimation(
                          1.2,
                          Container(
                            height: _height * 0.1,
                            child: Marquee(
                              text: songCurrent.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 31,
                              ),
                              scrollAxis: Axis.horizontal,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              blankSpace: 68.0,
                              velocity: 100.0,
                              pauseAfterRound: Duration(seconds: 1),
                              startPadding: 10.0,
                              accelerationDuration: Duration(seconds: 1),
                              accelerationCurve: Curves.linear,
                              decelerationDuration: Duration(milliseconds: 500),
                              decelerationCurve: Curves.easeOut,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: _height * 0.06,
                        ),
                        FadeAnimation(
                            1.3,
                            Text(
                              songCurrent.artist,
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.6),
                                  fontSize: 18),
                            )),
                        SizedBox(height: _height * 0.04),
                        FadeAnimation(
                            1.4,
                            Slider(
                              value: (_position != null &&
                                      _duration != null &&
                                      _position.inMilliseconds > 0 &&
                                      _position.inMilliseconds <
                                          _duration.inMilliseconds)
                                  ? _position.inMilliseconds /
                                      _duration.inMilliseconds
                                  : 0.0,
                              inactiveColor: Colors.white38,
                              activeColor: Colors.pink,
                              onChanged: (double value) {
                                double position =
                                    value * _duration.inMilliseconds;
                                audioPlayer.seek(
                                    Duration(milliseconds: position.round()));
                              },
                            )),
                        SizedBox(height: _height * 0.02),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: FadeAnimation(
                            1.5,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  _position != null
                                      ? '${_positionText ?? ''}'
                                      : _duration != null ? _durationText : '',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.pink,
                                    fontSize: 22,
                                  ),
                                ),
                                Text(
                                  _durationText,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.pink,
                                    fontSize: 22,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: _height * 0.05),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: FadeAnimation(
                              1.6,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(
                                      Icons.fast_rewind,
                                      color: Colors.white54,
                                      size: 42,
                                    ),
                                    onPressed: () {
                                      prevSong();
                                      setState(() {
                                        stop();
                                        _play(widget.songs[widget.indexSong]);
                                        songCurrent =
                                            widget.songs[widget.indexSong];
                                      });
                                    },
                                  ),
                                  FloatingActionButton(
                                    onPressed: () {
                                      if (_isPlaying)
                                        _pause();
                                      else
                                        _play(songCurrent);
                                    },
                                    child: Icon(
                                      _isPlaying
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                      color: Colors.white,
                                    ),
                                    backgroundColor: Colors.pink,
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.fast_forward,
                                      color: Colors.white54,
                                      size: 42,
                                    ),
                                    onPressed: () {
                                      nextSong();
                                      setState(() {
                                        stop();
                                        _play(widget.songs[widget.indexSong]);
                                        songCurrent =
                                            widget.songs[widget.indexSong];
                                      });
                                    },
                                  ),
                                ],
                              )),
                        ),
                        SizedBox(
                          height: _height * 0.05,
                        ),
                        FadeAnimation(
                            1.7,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(
                                    FontAwesome.bookmark_o,
                                    color: Colors.pink,
                                  ),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text(_dialogTitle),
                                            content: FutureBuilder<
                                                    List<PlaylistInfo>>(
                                                future:
                                                    audioQuery.getPlaylists(),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasError) {
                                                    print("has error");
                                                    return Utility
                                                        .createDefaultInfoWidget(
                                                            Text(
                                                                "${snapshot.error}"));
                                                  }

                                                  if (snapshot.hasData) {
                                                    if (snapshot.data.isEmpty) {
                                                      print("is Empty");
                                                      return NoDataWidget(
                                                        title:
                                                            "There is no playlists",
                                                      );
                                                    }

                                                    return PlaylistDialogContent(
                                                      options: snapshot.data
                                                          .map((playlist) =>
                                                              playlist.name)
                                                          .toList(),
                                                      onSelected: (index) {
                                                        snapshot.data[index]
                                                            .addSong(
                                                                song:
                                                                    songCurrent);
                                                        Navigator.pop(context);
                                                      },
                                                    );
                                                  }

                                                  print("has no data");
                                                  return Utility
                                                      .createDefaultInfoWidget(
                                                          CircularProgressIndicator());
                                                }),
                                          );
                                        });
                                  },
                                  tooltip: "add to playlist",
                                ),
                                IconButton(
                                  icon: Icon(
                                    FontAwesome.random,
                                    color: isShuffle == false
                                        ? Colors.pink
                                        : Colors.pink[700],
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      toggleShuffle();
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: isLoop == false
                                      ? Icon(
                                          Icons.repeat,
                                          color: Colors.pink,
                                        )
                                      : Icon(
                                          Icons.repeat_one,
                                          color: Colors.pink,
                                        ),
                                  onPressed: () {
                                    setState(() {
                                      toggleLoop();
                                      if (isLoop == true) {
                                        audioPlayer
                                            .setReleaseMode(ReleaseMode.LOOP);
                                      } else {
                                        audioPlayer.setReleaseMode(
                                            ReleaseMode.RELEASE);
                                      }
                                    });
                                  },
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _initAudioPlayer() {
    audioPlayer = AudioPlayer(mode: mode);

    _durationSubscription = audioPlayer.onDurationChanged.listen((duration) {
      setState(() => _duration = duration);

      if (Theme.of(context).platform == TargetPlatform.iOS) {
        // (Optional) listen for notification updates in the background
        audioPlayer.startHeadlessService();

        // set at least title to see the notification bar on ios.
        audioPlayer.setNotification(
            title: 'App Name',
            artist: 'Artist or blank',
            albumTitle: 'Name or blank',
            imageUrl: 'url or blank',
            forwardSkipInterval: const Duration(seconds: 30), // default is 30s
            backwardSkipInterval: const Duration(seconds: 30), // default is 30s
            duration: duration,
            elapsedTime: Duration(seconds: 0));
      }
    });

    _positionSubscription =
        audioPlayer.onAudioPositionChanged.listen((p) => setState(() {
              _position = p;
            }));

    _playerCompleteSubscription =
        audioPlayer.onPlayerCompletion.listen((event) {
      setState(() {
        _position = _duration;
        if (isShuffle == true) {
          if (widget.songs.length > 1) {
            int max = widget.songs.length;
            int random = rnd.nextInt(max);
            _onComplete(widget.songs[random]);
            _play(widget.songs[random]);
          }
        } else {
          nextSong();
          stop();
          _play(widget.songs[widget.indexSong]);
        }
      });
    });

    _playerErrorSubscription = audioPlayer.onPlayerError.listen((msg) {
      print('audioPlayer error : $msg');
      setState(() {
        _playerState = PlayerState.stopped;
        _duration = Duration(seconds: 0);
        _position = Duration(seconds: 0);
      });
    });

    audioPlayer.onPlayerStateChanged.listen((state) {
      if (!mounted) return;
      setState(() {
        audioPlayerState = state;
      });
    });

    audioPlayer.onNotificationPlayerStateChanged.listen((state) {
      if (!mounted) return;
      setState(() => audioPlayerState = state);
    });
  }
}
