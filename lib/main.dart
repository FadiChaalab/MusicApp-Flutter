import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modern_music/bloc/ApplicationBloc.dart';
import 'package:modern_music/bloc/BlocProvider.dart';
import 'package:modern_music/bloc/favorites_model.dart';
import 'package:modern_music/sideBar/sidebar_layouts.dart';
import 'package:modern_music/themes/notifier.dart';
import 'package:modern_music/themes/theme.dart';
import 'package:modern_music/utils/bio.dart';
import 'package:modern_music/utils/color.dart';
import 'package:modern_music/utils/icon_color.dart';
import 'package:modern_music/utils/user.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]).then((_) {
    SharedPreferences.getInstance().then((prefs) {
      var darkModeOn = prefs.getBool('darkMode') ?? true;
      runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<ThemeNotifier>(
              create: (_) => ThemeNotifier(darkModeOn ? darkTheme : lightTheme),
            ),
            ChangeNotifierProvider<Username>(
              create: (context) => Username(),
            ),
            ChangeNotifierProvider<UserBio>(
              create: (context) => UserBio(),
            ),
            ChangeNotifierProvider<ColorChanger>(
              create: (context) => ColorChanger(),
            ),
            ChangeNotifierProvider<IconChanger>(
              create: (context) => IconChanger(),
            ),
            ChangeNotifierProvider<FavoriteModel>(
              create: (context) => FavoriteModel(),
            ),
          ],
          child: MyApp(),
        ),
      );
    });
  });
}

class MyApp extends StatelessWidget {
  final ApplicationBloc bloc = ApplicationBloc();
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeNotifier.getTheme(),
      home: BlocProvider(
        bloc: bloc,
        child: SideBarLayout(),
      ),
    );
  }
}
