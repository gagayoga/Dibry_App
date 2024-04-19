import 'package:dibry_app/app/components/customButton.dart';
import 'package:dibry_app/app/components/customTextField.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    // Size
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    // Color
    const Color backgroundColor = Color(0xFFFFF2EA);
    const Color buttonColor = Color(0xFFFFAE7A);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: width,
          height: height,
          color: backgroundColor,
          child: Stack(
            children: [

              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Image.asset(
                  'assets/background/bg_login.png',
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    children: [

                      SizedBox(
                        height: height * 0.050,
                      ),

                      Image.asset(
                        'assets/logo/logo.png',
                        height: 150,
                      ),

                      SizedBox(
                        height: height * 0.040,
                      ),

                      SizedBox(
                        width: width,
                        child: Text(
                          'Username',
                          textAlign: TextAlign.start,
                          style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      SizedBox(
                        height: height * 0.010,
                      ),

                      CustomTextField(
                          controller: controller.emailController,
                          onChanged: (value){
                          },
                          hinText: "Email Address",
                          obsureText:false,
                          validator: (value) {
                          if (value!.isEmpty) {
                            return 'Pleasse input email address';
                          } else if (!EmailValidator.validate(value)) {
                            return 'Email address tidak sesuai';
                          }else if (!value.endsWith('@smk.belajar.id')){
                            return 'Email harus @smk.belajar.id';
                          }

                          return null;
                        },
                      ),

                      SizedBox(
                        height: height * 0.015,
                      ),

                      SizedBox(
                        width: width,
                        child: Text(
                          'Password',
                          textAlign: TextAlign.start,
                          style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      SizedBox(
                        height: height * 0.010,
                      ),

                      Obx(() =>
                          CustomTextField(
                            controller: controller.passwordController,
                            onChanged: (value){
                            },
                            hinText: "Password",
                            obsureText: controller.isPasswordHidden.value,
                            surficeIcon: InkWell(
                              child: Icon(
                                  controller.isPasswordHidden.value?
                                  Icons.visibility: Icons.visibility_off,
                                  color: Colors.grey, size: 24),
                              onTap: () {
                                controller.isPasswordHidden.value =
                                !controller.isPasswordHidden.value;
                              },
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Pleasse input password';
                              }

                              // Validasi setidaknya satu huruf besar
                              if (!value.contains(RegExp(r'[A-Z]'))) {
                                return 'Password harus mengandung satu huruf besar';
                              }

                              // Validasi setidaknya satu karakter khusus
                              if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                                return 'Password harus mengandung satu karakter khusus';
                              }

                              return null;
                            },
                          ),),

                      SizedBox(
                        height: height * 0.020,
                      ),

                      SizedBox(
                        width: width,
                        child: Text(
                          'Lupa Kata Sandi?',
                          textAlign: TextAlign.end,
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: buttonColor),
                        ),
                      ),

                      SizedBox(
                        height: height * 0.040,
                      ),

                      Obx(() =>
                          CustomButton(
                              onPressed: (){
                                controller.login();
                              },
                              buttonColor: buttonColor,
                              child: controller.loadinglogin.value
                                  ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                                  :
                              Text(
                                "Login",
                                style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              )
                          ),
                      ),

                      SizedBox(
                        height: height * 0.035,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Belom punya akun?',
                            style: GoogleFonts.poppins(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          GestureDetector(
                            onTap: (){
                              Get.offAllNamed(Routes.REGISTER);
                            },
                            child: Text(
                              'Daftar disini',
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: buttonColor),
                            ),
                          )
                        ],
                      ),

                    ]
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
