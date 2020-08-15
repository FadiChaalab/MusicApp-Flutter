import 'package:bloc/bloc.dart';
import 'package:modern_music/pages/about_page.dart';
import 'package:modern_music/pages/account_page.dart';
import 'package:modern_music/pages/favorite.dart';
import 'package:modern_music/pages/home_page.dart';
import 'package:modern_music/pages/settings_page.dart';

enum NavigationEvents {
  HomePageClickedEvent,
  MyAccountClickedEvent,
  MyFavoritesClickedEvent,
  MySettingsClickedEvent,
  AboutClickedEvent,
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  @override
  NavigationStates get initialState => HomePage();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.HomePageClickedEvent:
        yield HomePage();
        break;
      case NavigationEvents.MyAccountClickedEvent:
        yield MyAccountsPage();
        break;
      case NavigationEvents.MyFavoritesClickedEvent:
        yield MyFavoritesPage();
        break;
      case NavigationEvents.MySettingsClickedEvent:
        yield SettingsPage();
        break;
      case NavigationEvents.AboutClickedEvent:
        yield AboutPage();
        break;
    }
  }
}
