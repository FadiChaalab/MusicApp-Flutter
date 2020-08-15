import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:modern_music/bloc/bloc.dart';
import 'package:modern_music/utils/icon_color.dart';
import 'package:modern_music/widgets/account_screen.dart';
import 'package:modern_music/widgets/color_settings.dart';
import 'package:modern_music/widgets/theme_screen.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget with NavigationStates {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  IconChanger iconChanger;
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    iconChanger = Provider.of<IconChanger>(context);
    return WillPopScope(
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
                      right: 20.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Settings',
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
                        Icon(
                          Ionicons.md_settings,
                          color: iconChanger.getIcon(),
                          size: 24,
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
              child: ListView(
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 0.0, 20.0, 0.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ColorScreen(),
                          ),
                        );
                      },
                      child: Container(
                        height: _height * 0.25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: iconChanger.getIcon(),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10,
                              color: Colors.black,
                            ),
                          ],
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                                vertical: 12.0,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      FontAwesome.paint_brush,
                                    ),
                                    color: Colors.blue[900],
                                    iconSize: 24,
                                  ),
                                  SizedBox(
                                    width: _width * 0.01,
                                  ),
                                  Text(
                                    "Look",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                      letterSpacing: 1.1,
                                      fontFamily: 'Poppins',
                                      shadows: <Shadow>[
                                        Shadow(
                                          color: Colors.black,
                                          blurRadius: 1,
                                          offset: Offset(1, 1),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                                vertical: 2,
                              ),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    'Customize The Accent Of The App',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      letterSpacing: 1.1,
                                      fontFamily: 'Poppins',
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 0.0, 20.0, 0.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ThemePage(),
                          ),
                        );
                      },
                      child: Container(
                        height: _height * 0.25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: iconChanger.getIcon(),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10,
                              color: Colors.black,
                            ),
                          ],
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                                vertical: 12.0,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      FontAwesome5Solid.palette,
                                    ),
                                    color: Colors.deepPurple,
                                    iconSize: 24,
                                  ),
                                  SizedBox(
                                    width: _width * 0.01,
                                  ),
                                  Text(
                                    "Themes",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                      letterSpacing: 1.1,
                                      fontFamily: 'Poppins',
                                      shadows: <Shadow>[
                                        Shadow(
                                          color: Colors.black,
                                          blurRadius: 1,
                                          offset: Offset(1, 1),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                                vertical: 2,
                              ),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    'Customize The Themes Of The App',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      letterSpacing: 1.1,
                                      fontFamily: 'Poppins',
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 0.0, 20.0, 0.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AccountScreen(),
                          ),
                        );
                      },
                      child: Container(
                        height: _height * 0.25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: iconChanger.getIcon(),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10,
                              color: Colors.black,
                            ),
                          ],
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                                vertical: 12.0,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      FontAwesome.user_o,
                                    ),
                                    color: Colors.pink,
                                    iconSize: 24,
                                  ),
                                  SizedBox(
                                    width: _width * 0.01,
                                  ),
                                  Text(
                                    "Account Settings",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                      letterSpacing: 1.1,
                                      fontFamily: 'Poppins',
                                      shadows: <Shadow>[
                                        Shadow(
                                          color: Colors.black,
                                          blurRadius: 1,
                                          offset: Offset(1, 1),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                                vertical: 2,
                              ),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    'Customize The Settings Of The App',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      letterSpacing: 1.1,
                                      fontFamily: 'Poppins',
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: _width * 0.02,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
