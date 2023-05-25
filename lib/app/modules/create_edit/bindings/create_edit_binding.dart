import 'package:get/get.dart';

import '../controllers/create_edit_controller.dart';

class CreateEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateEditController>(
      () => CreateEditController(),
    );
  }
}
