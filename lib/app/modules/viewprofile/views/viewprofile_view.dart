import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/customButton.dart';
import '../../../components/customTextField.dart';
import '../controllers/viewprofile_controller.dart';

class ViewprofileView extends GetView<ViewprofileController> {
  const ViewprofileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 0,
        title: SizedBox(
          width: width,
          child: Text(
            'Update Profile',
            style: GoogleFonts.poppins(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkWell(
                onTap: (){
                  controller.getDataUser();
                },
                child: const SizedBox(
                  width: 40,
                  height: 40,
                  child: Icon(
                    Icons.refresh_rounded,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: Container(
        width: width,
        height: height,
        color: const Color(0xFFFFF2EA),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const SizedBox(
                    height: 50,
                  ),

                  Center(
                    child: Image.asset(
                      'assets/logo/logo_home.png',
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text(
                              "Nama Lengkap",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.grey,
                                letterSpacing: 0.3
                              ),
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            CustomTextField(
                              controller: controller.namalengkap,
                              onChanged: (value){
                              },
                              hinText: "Nama Lengkap",
                              obsureText:false,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Pleasse input nama lengkap';
                                }

                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text(
                              "Username",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Colors.grey,
                                  letterSpacing: 0.3
                              ),
                            ),

                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              controller: controller.username,
                              onChanged: (value){
                              },
                              hinText: "Username",
                              obsureText:false,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Pleasse input username';
                                }

                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  Text(
                    "Email Address",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.grey,
                        letterSpacing: 0.3
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  CustomTextField(
                    controller: controller.email,
                    onChanged: (value){
                    },
                    hinText: "Email Address",
                    obsureText:false,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Pleasse input email';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  Text(
                    "Bio",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.grey,
                        letterSpacing: 0.3
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  CustomTextField(
                    controller: controller.bio,
                    onChanged: (value){
                    },
                    hinText: "Bio",
                    obsureText:false,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Pleasse input bio';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  Text(
                    "Nomor Telepon",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.grey,
                        letterSpacing: 0.3
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  CustomTextField(
                    controller: controller.telepon,
                    onChanged: (value){
                    },
                    hinText: "Telepon",
                    obsureText:false,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Pleasse input telepon';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(
                    height: 40,
                  ),

                  Obx(() =>
                      CustomButton(
                          onPressed: (){
                            controller.updateProfilePost();
                          },
                          buttonColor: const Color(0xFFFFCD86),
                          child: controller.loading.value
                              ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                              :
                          Text(
                            "Update Profile",
                            style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          )
                      ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}
