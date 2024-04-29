import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/customTextFieldProfile.dart';
import '../../../data/constant/endpoint.dart';
import '../../../data/model/user/response_data_profile.dart';
import '../../../data/provider/api_provider.dart';
import '../../../data/provider/storage_provider.dart';
import '../../../routes/app_pages.dart';

class ProfileController extends GetxController with StateMixin{

  var detailProfile = Rxn<DataUser>();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController passwordlamaController = TextEditingController();
  final TextEditingController passwordbaruController = TextEditingController();

  var isPasswordHidden = true.obs;
  var isPasswordHidden2 = true.obs;

  final loading = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getDataUser() async {
    detailProfile.value = null;
    change(null, status: RxStatus.loading());

    try {
      final responseDetailBuku = await ApiProvider.instance().get(Endpoint.getDataProfile);

      if (responseDetailBuku.statusCode == 200) {
        final ResponseDataProfile responseBuku = ResponseDataProfile.fromJson(responseDetailBuku.data);

        if (responseBuku.data == null) {
          change(null, status: RxStatus.empty());
        } else {
          detailProfile(responseBuku.data);
          change(null, status: RxStatus.success());
        }
      } else {
        change(null, status: RxStatus.error("Gagal Memanggil Data"));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final responseData = e.response?.data;
        if (responseData != null) {
          final errorMessage = responseData['message'] ?? "Unknown error";
          change(null, status: RxStatus.error(errorMessage));
        }
      } else {
        change(null, status: RxStatus.error(e.message));
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  logout() async {
    loading(true);
    try {
      FocusScope.of(Get.context!).unfocus();

      var response = await ApiProvider.instance().post(
          Endpoint.logout
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: 'Logout berhasil',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: const Color(0xFFFFCD86).withOpacity(0.8),
          textColor: Colors.black,
          fontSize: 16.0,
        );
        StorageProvider.clearAll();
        Get.offAllNamed(Routes.LOGIN);
      } else {
        Get.snackbar(
            "Sorry",
            "Logout gagal, Coba kembali",
            backgroundColor: Colors.red,
            colorText: Colors.white,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
        );
      }
      loading(false);
    } on DioException catch (e) {
      loading(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          Get.snackbar("Sorry", "${e.response?.data['Message']}",
              backgroundColor: Colors.red, colorText: Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
          );
        }
      } else {
        Get.snackbar("Sorry", e.message ?? "", backgroundColor: Colors.red,
            colorText: Colors.white,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
        );
      }
    } catch (e) {
      loading(false);
      Get.snackbar(
          "Error", e.toString(),
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
      );
    }
  }

  updateProfilePassword() async {
    loading(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      formKey.currentState?.save();
      if (formKey.currentState!.validate()) {
        var response = await ApiProvider.instance().patch(Endpoint.updatePassword,
            data:
            {
              "PasswordLama" : passwordlamaController.text.toString(),
              "PasswordBaru" : passwordbaruController.text.toString(),
            }
        );
        if (response.statusCode == 200) {
          passwordlamaController.text = '';
          passwordbaruController.text = '';
          Get.snackbar(
              "Sorry",
              "Update password berhasil",
              backgroundColor: Colors.green,
              colorText: Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
          );
          Navigator.pop(Get.context!, 'OK');

        } else {
          Get.snackbar(
              "Sorry",
              "Update password gagal, Coba kembali",
              backgroundColor: Colors.red,
              colorText: Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
          );
        }
      }
      loading(false);
    } on DioException catch (e) {
      loading(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          Get.snackbar("Sorry", "${e.response?.data['Message']}",
              backgroundColor: Colors.red, colorText: Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
          );
        }
      } else {
        Get.snackbar("Sorry", e.message ?? "", backgroundColor: Colors.red,
            colorText: Colors.white,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
        );
      }
    } catch (e) {
      loading(false);
      Get.snackbar(
          "Error", e.toString(),
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
      );
    }
  }

  Future<void> showConfirmPeminjaman() async {
    const Color background = Color(0xFF03010E);
    return showDialog<void>(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          titleTextStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w800,
            fontSize: 20.0,
            color: Colors.black,
          ),
          backgroundColor: const Color(0xFFF5F5F5),
          title: Text(
            'Konfirmasi Update Password',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w800,
              fontSize: 20.0,
              color: Colors.black,
            ),
          ),

          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: SizedBox(
                width: MediaQuery.of(Get.context!).size.width,
                child: ListBody(
                  children: <Widget>[

                    const SizedBox(
                      height: 20,
                    ),

                    Text(
                      "Password Lama",
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black
                      ),
                    ),

                    Obx(() => CustomTextFieldProfile(
                      controller: passwordlamaController,
                      hinText: 'Password Lama',
                      obsureText: isPasswordHidden.value,
                      surficeIcon: InkWell(
                        child: Icon(
                          isPasswordHidden.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          size: 20,
                          color: background,
                        ),
                        onTap: () {
                          isPasswordHidden.value =
                          !isPasswordHidden.value;
                        },
                      ),
                      preficIcon: const Icon(Icons.lock),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Pleasse input telepon';
                        }

                        return null;
                      },
                    )),

                    const SizedBox(
                      height: 10,
                    ),

                    Text(
                      "Password Baru",
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black
                      ),
                    ),

                    Obx(() => CustomTextFieldProfile(
                      controller: passwordbaruController,
                      hinText: 'Password Baru',
                      obsureText: isPasswordHidden2.value,
                      surficeIcon: InkWell(
                        child: Icon(
                          isPasswordHidden2.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          size: 20,
                          color: background,
                        ),
                        onTap: () {
                          isPasswordHidden2.value =
                          !isPasswordHidden2.value;
                        },
                      ),
                      preficIcon: const Icon(Icons.lock),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Pleasse input telepon';
                        }

                        return null;
                      },
                    )),
                  ],
                ),
              ),
            ),
          ),
          actions: <Widget>[
            SizedBox(
              width: MediaQuery.of(Get.context!).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: SizedBox(
                        width: MediaQuery.of(Get.context!).size.width,
                        height: 45,
                        child: TextButton(
                          autofocus: true,
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.grey,
                            animationDuration: const Duration(milliseconds: 300),
                          ),
                          onPressed: (){
                            Navigator.pop(Get.context!, 'OK');
                          },
                          child: Text(
                            'Batal',
                            style: GoogleFonts.poppins(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    width: 10,
                  ),

                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: SizedBox(
                        width: MediaQuery.of(Get.context!).size.width,
                        height: 45,
                        child: TextButton(
                          autofocus: true,
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0xFFFFCD86),
                            animationDuration: const Duration(milliseconds: 300),
                          ),
                          onPressed: (){
                            Navigator.pop(Get.context!, 'OK');
                            updateProfilePassword();
                          },
                          child: Text(
                            "Update",
                            style: GoogleFonts.poppins(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
