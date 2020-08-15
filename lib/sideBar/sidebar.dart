import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:modern_music/bloc/bloc.dart';
import 'package:modern_music/sideBar/menu_items.dart';
import 'package:modern_music/utils/color.dart';
import 'package:modern_music/utils/icon_color.dart';
import 'package:modern_music/utils/image.dart';
import 'package:modern_music/utils/user.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar>
    with SingleTickerProviderStateMixin<SideBar> {
  AnimationController _animationController;
  StreamController<bool> isSidebarOpenedStreamController;
  Stream<bool> isSidebarOpenedStream;
  StreamSink<bool> isSidebarOpenedSink;
  final _animationDuration = const Duration(milliseconds: 200);
  Username username;
  Image imageFromPreferences;
  ColorChanger colorChanger;
  IconChanger iconChanger;
  loadImageFromPreferences() {
    SaveImage.getImageFromPreferences().then((img) {
      if (null == img) {
        return;
      }
      setState(() {
        imageFromPreferences = SaveImage.imageFromBase64String(img);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: _animationDuration);
    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSidebarOpenedStream = isSidebarOpenedStreamController.stream;
    isSidebarOpenedSink = isSidebarOpenedStreamController.sink;
    loadImageFromPreferences();
  }

  @override
  void dispose() {
    _animationController.dispose();
    isSidebarOpenedStreamController.close();
    isSidebarOpenedSink.close();
    super.dispose();
  }

  void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      isSidebarOpenedSink.add(false);
      _animationController.reverse();
    } else {
      isSidebarOpenedSink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    colorChanger = Provider.of<ColorChanger>(context);
    iconChanger = Provider.of<IconChanger>(context);
    return WillPopScope(
      onWillPop: () {
        return null;
      },
      child: StreamBuilder<bool>(
        initialData: false,
        stream: isSidebarOpenedStream,
        builder: (context, isSideBarOpenedAsync) {
          username = Provider.of<Username>(context);
          final _width = MediaQuery.of(context).size.width;
          final _height = MediaQuery.of(context).size.height;
          return AnimatedPositioned(
            duration: _animationDuration,
            top: 0,
            bottom: 0,
            left: isSideBarOpenedAsync.data ? 0 : -screenWidth,
            right: isSideBarOpenedAsync.data ? 0 : screenWidth - 45,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          color: Colors.black,
                        ),
                      ],
                      color: colorChanger.getAccent(),
                    ),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: _height * 0.15,
                        ),
                        ListTile(
                          title: Text.rich(
                            TextSpan(
                              text: 'Welcome, ',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                                letterSpacing: 1.2,
                                fontFamily: 'Poppins',
                                color: Colors.pink,
                                shadows: <Shadow>[
                                  Shadow(
                                    color: Colors.black,
                                    blurRadius: 2,
                                    offset: Offset(1, 1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          subtitle: Text(
                            username.getName(),
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              letterSpacing: 1.1,
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              shadows: <Shadow>[
                                Shadow(
                                  color: Colors.black,
                                  blurRadius: 2,
                                  offset: Offset(1, 1),
                                ),
                              ],
                            ),
                          ),
                          leading: Container(
                            height: _width * 0.14,
                            width: _width * 0.14,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: iconChanger.getIcon(),
                                width: 2,
                              ),
                            ),
                            child: imageFromPreferences == null
                                ? CircleAvatar(
                                    backgroundImage: AssetImage(
                                        'assets/images/user-default.png'),
                                  )
                                : CircleAvatar(
                                    backgroundImage: imageFromPreferences.image,
                                  ),
                          ),
                        ),
                        Divider(
                          height: _height * 0.04,
                          thickness: 0.5,
                          color: Colors.white.withOpacity(0.3),
                          indent: 32,
                          endIndent: 32,
                        ),
                        MenuItem(
                          icon: FontAwesome.home,
                          title: "Home",
                          onTap: () {
                            onIconPressed();
                            BlocProvider.of<NavigationBloc>(context)
                                .add(NavigationEvents.HomePageClickedEvent);
                          },
                        ),
                        MenuItem(
                          icon: FontAwesome.user_o,
                          title: "My Account",
                          onTap: () {
                            onIconPressed();
                            BlocProvider.of<NavigationBloc>(context)
                                .add(NavigationEvents.MyAccountClickedEvent);
                          },
                        ),
                        MenuItem(
                          icon: FontAwesome.heart,
                          title: "My Favorites",
                          onTap: () {
                            onIconPressed();
                            BlocProvider.of<NavigationBloc>(context)
                                .add(NavigationEvents.MyFavoritesClickedEvent);
                          },
                        ),
                        MenuItem(
                          icon: FontAwesome.info,
                          title: "About",
                          onTap: () {
                            onIconPressed();
                            BlocProvider.of<NavigationBloc>(context)
                                .add(NavigationEvents.AboutClickedEvent);
                          },
                        ),
                        Divider(
                          height: _height * 0.04,
                          thickness: 0.5,
                          color: Colors.white.withOpacity(0.3),
                          indent: 32,
                          endIndent: 32,
                        ),
                        MenuItem(
                          icon: Ionicons.md_settings,
                          title: "Settings",
                          onTap: () {
                            onIconPressed();
                            BlocProvider.of<NavigationBloc>(context)
                                .add(NavigationEvents.MySettingsClickedEvent);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(0, -0.8),
                  child: GestureDetector(
                    onTap: () {
                      onIconPressed();
                    },
                    child: ClipPath(
                      clipper: CustomMenuClipper(),
                      child: Container(
                        width: 35,
                        height: 120,
                        decoration: BoxDecoration(
                          color: colorChanger.getAccent(),
                        ),
                        alignment: Alignment.centerLeft,
                        child: AnimatedIcon(
                          progress: _animationController.view,
                          icon: AnimatedIcons.menu_close,
                          color: iconChanger.getIcon(),
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.transparent;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
