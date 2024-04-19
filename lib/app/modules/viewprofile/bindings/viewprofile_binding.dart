import 'package:get/get.dart';

import '../controllers/viewprofile_controller.dart';

class ViewprofileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ViewprofileController>(
      () => ViewprofileController(),
    );
  }
}
