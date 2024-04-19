import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/model/buku/response_detail_buku.dart';
import '../../../data/model/peminjaman/response_peminjaman.dart';
import '../../../data/provider/api_provider.dart';
import '../../../data/provider/storage_provider.dart';

class DetailbookController extends GetxController with StateMixin{

  // Post Data
  final loading = false.obs;

  // Get Data
  var detailBuku = Rxn<DataDetailBuku>();
  final id = Get.parameters['id'];

  @override
  void onInit() {
    super.onInit();
    getDataDetailBuku();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getDataDetailBuku() async {
    detailBuku.value = null;
    change(null, status: RxStatus.loading());

    try {
      String id = Get.parameters['id'].toString();
      final responseDetailBuku = await ApiProvider.instance().get(
          '${Endpoint.detailBuku}/$id');

      if (responseDetailBuku.statusCode == 200) {
        final ResponseDetailBuku responseBuku = ResponseDetailBuku.fromJson(responseDetailBuku.data);

        if (responseBuku.data == null) {
          detailBuku.value = null;
          change(null, status: RxStatus.empty());
        } else {
          detailBuku(responseBuku.data);
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

  // Add Koleksi Buku
  addKoleksiBuku() async {
    loading(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      var userID = StorageProvider.read(StorageKey.idUser).toString();
      var bukuID = id.toString();

      var response = await ApiProvider.instance().post(
        Endpoint.koleksiBuku,
        data: {
          "UserID": userID,
          "BukuID": bukuID,
        },
      );

      if (response.statusCode == 201) {
        Fluttertoast.showToast(
          msg: 'Buku berhasil di simpan di koleksi',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: const Color(0xFFFFCD86).withOpacity(0.8),
          textColor: Colors.black,
          fontSize: 16.0,
        );
        getDataDetailBuku();
      } else {

      }
      loading(false);
    } on DioException catch (e) {
      loading(false);
      if (e.response != null) {
        if (e.response?.data != null) {

        }
      } else {

      }
    } catch (e) {
      loading(false);

    }
  }

  // Delete Koleksi Buku
  deleteKoleksiBook() async {
    loading(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      var userID = StorageProvider.read(StorageKey.idUser).toString();
      var bukuID = id.toString();

      var response = await ApiProvider.instance().delete(
          '${Endpoint.deleteKoleksi}$userID/koleksi/$bukuID');

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: 'Buku berhasil di hapus dari koleksi',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: const Color(0xFFFFCD86).withOpacity(0.8),
          textColor: Colors.black,
          fontSize: 16.0,
        );
        getDataDetailBuku();
      } else {

      }
      loading(false);
    } on DioException catch (e) {
      loading(false);
      if (e.response != null) {
        if (e.response?.data != null) {

        }
      } else {

      }
    } catch (e) {
      loading(false);

    }
  }

  // Add Peminjaman Buku
  addPeminjamanBuku() async {
    loading(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      var bukuID = id.toString();

      var responsePostPeminjaman = await ApiProvider.instance().post(Endpoint.pinjamBuku,
        data: {
          "BukuID": bukuID,
        },
      );

      if (responsePostPeminjaman.statusCode == 201) {
        ResponsePeminjaman responsePeminjaman = ResponsePeminjaman.fromJson(responsePostPeminjaman.data!);
        String judulBuku = Get.parameters['judul'].toString();
        String kodePinjam = responsePeminjaman.data!.kodePeminjaman.toString();

        showConfirmPeminjaman(kodePinjam);

        Get.snackbar("Success", "Buku $judulBuku berhasil dipinjam", backgroundColor: Colors.green,
            colorText: Colors.white,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
        );
      } else {
        Get.snackbar(
            "Sorry",
            "Peminjaman Buku Gagal",
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

  Future<void> showConfirmPeminjaman(String kodePeminjaman) async {
    return showDialog<void>(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFFFF5F5),
          titlePadding: const EdgeInsets.only(top: 20),
          title: Text(
            'Nomor Peminjaman Buku',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              letterSpacing: -0.3,
              fontSize: 18.0,
              color: Colors.black,
            ),
          ),

          content: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(Get.context!).size.width,
              child: ListBody(
                children: <Widget>[

                  const SizedBox(
                    height: 10,
                  ),

                  TextFormField(
                    enabled: true,
                    initialValue: kodePeminjaman,
                    obscureText: false,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.black.withOpacity(0.90),
                    ),
                    decoration: InputDecoration(
                        fillColor: const Color(0xFFD9D9D9).withOpacity(0.30),
                        filled: true,
                        suffixIcon: InkWell(
                          onTap: () async{
                            copyToClipboard(kodePeminjaman, Get.context!);
                          },
                          child: const Icon(Icons.copy_rounded, size: 24, color: Colors.black,),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black.withOpacity(0.25),
                            ),
                            borderRadius: BorderRadius.circular(10.10)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black.withOpacity(0.25),
                            ),
                            borderRadius: BorderRadius.circular(10.10)),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black.withOpacity(0.25),
                            ),
                            borderRadius: BorderRadius.circular(10.10)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black.withOpacity(0.25),
                            ),
                            borderRadius: BorderRadius.circular(10.10)),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            SizedBox(
              width: MediaQuery.of(Get.context!).size.width,
              height: 40,
              child: TextButton(
                autofocus: true,
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFFFFCD86),
                  animationDuration: const Duration(milliseconds: 300),
                ),
                onPressed: (){
                  Navigator.pop(Get.context!, 'OK');
                  getDataDetailBuku();
                },
                child: Text(
                  "OK",
                  style: GoogleFonts.poppins(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  void copyToClipboard(String text, BuildContext context) {
    Clipboard.setData(ClipboardData(text: text));
    Fluttertoast.showToast(
      msg: 'Copied to Clipboard',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: const Color(0xFFFFCD86).withOpacity(0.8),
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }
}
