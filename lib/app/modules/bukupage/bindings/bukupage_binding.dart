import 'package:get/get.dart';

import '../controllers/bukupage_controller.dart';

class BukupageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BukupageController>(
      () => BukupageController(),
    );
  }
}
