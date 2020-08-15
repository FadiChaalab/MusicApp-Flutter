import 'package:day_night_switch/day_night_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:modern_music/themes/notifier.dart';
import 'package:modern_music/themes/theme.dart';
import 'package:modern_music/utils/icon_color.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemePage extends StatefulWidget {
  @override
  _ThemePageState createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  var _darkTheme = true;
  IconChanger iconChanger;

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    _darkTheme = (themeNotifier.getTheme() == darkTheme);
    iconChanger = Provider.of<IconChanger>(context);
    return Scaffold(
      body: WillPopScope(
        onWillPop: () {
          return null;
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).accentColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(50.0)),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: 16,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        FontAwesome5Solid.palette,
                        size: 24,
                      ),
                      onPressed: () {},
                      color: iconChanger.getIcon(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        'Dark Theme',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                          letterSpacing: 1.1,
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
                      contentPadding: const EdgeInsets.only(left: 30.0),
                      trailing: Transform.scale(
                        scale: 0.4,
                        child: DayNightSwitch(
                          value: _darkTheme,
                          onChanged: (val) {
                            setState(() {
                              _darkTheme = val;
                            });
                            onThemeChanged(val, themeNotifier);
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onThemeChanged(bool value, ThemeNotifier themeNotifier) async {
    (value)
        ? themeNotifier.setTheme(darkTheme)
        : themeNotifier.setTheme(lightTheme);
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkMode', value);
  }
}
