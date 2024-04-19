import 'package:dibry_app/app/modules/bookmark/controllers/bookmark_controller.dart';
import 'package:dibry_app/app/modules/bukupage/controllers/bukupage_controller.dart';
import 'package:dibry_app/app/modules/historypeminjaman/controllers/historypeminjaman_controller.dart';
import 'package:dibry_app/app/modules/historypeminjaman/views/historypeminjaman_view.dart';
import 'package:dibry_app/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(
      () => DashboardController(),
    );

    Get.lazyPut<HomeController>(
          () => HomeController(),
    );

    Get.lazyPut<BukupageController>(
          () => BukupageController(),
    );

    Get.lazyPut<BookmarkController>(
          () => BookmarkController(),
    );

    Get.lazyPut<HistorypeminjamanController>(
          () => HistorypeminjamanController(),
    );
  }
}
