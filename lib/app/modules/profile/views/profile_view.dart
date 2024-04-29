import 'package:dibry_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Size
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: width,
          height: height,
          color: const Color(0xFFFFF2EA),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Image.asset(
                  'assets/logo/logo_home.png',
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(
                height: 15,
              ),

              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: Colors.white
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/logo/logo_home.png',
                              width: 80,
                              fit: BoxFit.cover,
                            )
                          ],
                        ),

                        const SizedBox(height: 20),

                        sectionButtonProfile(width, height, Iconsax.information5, "Profile User", (){Get.toNamed(Routes.VIEWPROFILE);}),

                        const SizedBox(height: 10),

                        sectionButtonProfile(width, height, Iconsax.lock5, "Update Password", (){controller.showConfirmPeminjaman();}),

                        const SizedBox(height: 10),

                        sectionButtonProfile(width, height, Iconsax.logout5, "Logout",(){controller.logout();}),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }

  Widget sectionButtonProfile(double width, double height, IconData iconDepan, String text, Function() onTap){
    return Container(
      width: width,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFF5F5F5).withOpacity(0.60),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: InkWell(
          onTap: onTap,
          child: Row(
            children: [
              Icon(iconDepan),
              const SizedBox(width: 10),
              Text(text, style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black
              ),),
            ],
          ),
        ),
      ),
    );
  }
}
