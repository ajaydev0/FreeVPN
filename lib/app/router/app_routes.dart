part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const splashScreen = _Path.splashScreen;
  static const HOME_PAGE = '/home-page';
  static const MY_MAIN_APP = '/my-main-app';
  static const LOCATION_PAGE = '/location-page';
}

abstract class _Path {
  _Path._();
  static const splashScreen = "/";
}
