import 'package:dibry_app/app/components/customBarMaterial.dart';
import 'package:dibry_app/app/modules/bookmark/views/bookmark_view.dart';
import 'package:dibry_app/app/modules/bukupage/views/bukupage_view.dart';
import 'package:dibry_app/app/modules/historypeminjaman/views/historypeminjaman_view.dart';
import 'package:dibry_app/app/modules/home/views/home_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: IndexedStack(
              index: controller.tabIndex,
              children: const [
                HomeView(),
                BukupageView(),
                BookmarkView(),
                HistorypeminjamanView(),
              ],
            )
        ),

        bottomNavigationBar: CustomBottomBarMaterial(
          onTap: controller.changeTabIndex,
          currentIndex: controller.tabIndex,
        )
    );
  }
}
