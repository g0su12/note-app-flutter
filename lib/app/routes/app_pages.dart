import 'package:get/get.dart';

import '../modules/create_edit/bindings/create_edit_binding.dart';
import '../modules/create_edit/views/create_edit_screen.dart';
import '../modules/overview/bindings/overview_binding.dart';
import '../modules/overview/views/overview_screen.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.OVERVIEW,
      page: () => const OverViewScreen(),
      binding: OverviewBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_EDIT,
      page: () => const CreateEditScreen(),
      binding: CreateEditBinding(),
    ),
  ];
}
