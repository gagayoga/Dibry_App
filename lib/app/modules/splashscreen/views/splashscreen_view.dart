import 'package:dibry_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/provider/storage_provider.dart';
import '../controllers/splashscreen_controller.dart';

class SplashscreenView extends GetView<SplashscreenController> {
  const SplashscreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    // Size
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    // Color
    const Color whiteColor = Colors.white;

    // Route to login
    Future.delayed(
        const Duration(milliseconds: 5000),((){
      String? status = StorageProvider.read(StorageKey.status);

      if (status == "logged") {
        Get.offAllNamed(Routes.HOME);
      }else{
        Get.offAllNamed(Routes.LOGIN);
      }
    })
    );

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: whiteColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Image.asset(
            'assets/logo/logo.png',
          ),
        ),
      )
    );
  }
}
