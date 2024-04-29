import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/model/user/response_data_profile.dart';
import '../../../data/provider/api_provider.dart';

class ViewprofileController extends GetxController with StateMixin {

  var detailProfile = Rxn<DataUser>();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController namalengkap = TextEditingController();
  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController bio = TextEditingController();
  final TextEditingController telepon = TextEditingController();


  final loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getDataUser();
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
    change(null, status: RxStatus.loading());

    try {
      final responseDetailBuku = await ApiProvider.instance().get(
          Endpoint.getDataProfile);

      if (responseDetailBuku.statusCode == 200) {
        final ResponseDataProfile responseBuku = ResponseDataProfile.fromJson(
            responseDetailBuku.data);

        if (responseBuku.data == null) {
          change(null, status: RxStatus.empty());
        } else {
          detailProfile(responseBuku.data);
          email.text = detailProfile.value!.email.toString();
          bio.text = detailProfile.value!.bio.toString();
          telepon.text = detailProfile.value!.telepon.toString();
          username.text = detailProfile.value!.username.toString();
          namalengkap.text = detailProfile.value!.namaLengkap.toString();
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

  updateProfilePost() async {
    loading(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      formKey.currentState?.save();
      if (formKey.currentState!.validate()) {
        var response = await ApiProvider.instance().patch(Endpoint.updateProfile,
            data:
            {
              "Username" : username.text.toString(),
              "Bio" : bio.text.toString(),
              "NamaLengkap" : namalengkap.text.toString(),
              "Email" : email.text.toString(),
              "NoTelepon" : telepon.text.toString(),
            }
        );
        if (response.statusCode == 201) {
          String usernameUser = username.text.toString();
          Get.snackbar(
              "Sorry",
              "Update Profile Akun $usernameUser Berhasil",
              backgroundColor: Colors.green,
              colorText: Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
          );
        } else {
          Get.snackbar(
              "Sorry",
              "Update profile gagal, Coba kembali",
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
}
