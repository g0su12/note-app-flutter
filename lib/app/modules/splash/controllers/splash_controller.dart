import 'dart:async';

import 'package:get/get.dart';
import 'package:note/app/routes/app_pages.dart';

class SplashController extends GetxController {

  @override
  void onInit() {
    Timer(const Duration(seconds: 2), () {
      Get.offNamed(Routes.OVERVIEW);
    });
    super.onInit();
  }

}
