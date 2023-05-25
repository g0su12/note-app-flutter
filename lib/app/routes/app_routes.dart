part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const SPLASH = _Paths.SPLASH;
  static const OVERVIEW = _Paths.OVERVIEW;
  static const CREATE_EDIT = _Paths.CREATE_EDIT;
}

abstract class _Paths {
  _Paths._();
  static const SPLASH = '/splash';
  static const OVERVIEW = '/overview';
  static const CREATE_EDIT = '/create-edit';
}
