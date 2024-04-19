import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/model/buku/response_all_book.dart';
import '../../../data/model/response_book_new.dart';
import '../../../data/model/response_popular_book.dart';
import '../../../data/provider/api_provider.dart';

class BukupageController extends GetxController with StateMixin {

  final TextEditingController searchController = TextEditingController();

  var isLoading = RxBool(true);

  var dataAllBook = RxList<DataBook>();
  var newBooks = RxList<DataBookNew>();
  var popularBooks = RxList<DataPopularBook>();

  @override
  void onInit() {
    super.onInit();
    getDataPopular();
    getDataNewBooks();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }


  // Get Data Buku
  Future<void> getDataBook() async{
    isLoading.value = true;
    change(null, status: RxStatus.loading());

    try {

      final keyword = searchController.text.toString();
      final response;

      if(keyword == ''){
        response = await ApiProvider.instance().get('${Endpoint.buku}all/buku/null');
      }else{
        response = await ApiProvider.instance().get('${Endpoint.buku}all/buku/$keyword');
      }

      if (response.statusCode == 200) {
        final ResponseAllBook responseBuku = ResponseAllBook.fromJson(response.data);
        if(responseBuku.data!.isEmpty){
          dataAllBook.clear();
          change(null, status: RxStatus.empty());
        }else{
          dataAllBook.assignAll(responseBuku.data!);
          change(responseBuku.data, status: RxStatus.success());
        }
      } else {
        change(null, status: RxStatus.error("Gagal Memanggil Data"));
      }

    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response?.data != null) {
          change(null, status: RxStatus.error("${e.response?.data['message']}"));
        }
      } else {
        change(null, status: RxStatus.error(e.message ?? ""));
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }finally {
      isLoading.value = false;
    }
  }

  Future<void> getDataNewBooks() async {
    newBooks.clear();
    change(null, status: RxStatus.loading());

    try {
      final responseNew = await ApiProvider.instance().get(Endpoint.bukuNew);

      if (responseNew.statusCode == 200) {
        final ResponseBookNew responseBukuNew = ResponseBookNew.fromJson(responseNew.data);

        if (responseBukuNew.data!.isEmpty) {
          newBooks.clear();
          change(null, status: RxStatus.empty());
        } else {
          newBooks.assignAll(responseBukuNew.data!);

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

  Future<void> getDataPopular() async {
    popularBooks.clear();
    change(null, status: RxStatus.loading());

    try {
      final responsePopular = await ApiProvider.instance().get(Endpoint.bukuPopular);

      if (responsePopular.statusCode == 200) {
        final ResponsePopularBook responseBukuPopular = ResponsePopularBook.fromJson(responsePopular.data);

        if (responseBukuPopular.data!.isEmpty) {
          popularBooks.clear();
          change(null, status: RxStatus.empty());
        } else {
          popularBooks.assignAll(responseBukuPopular.data!);

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

  void getData(){
    getDataPopular();
    getDataNewBooks();
  }
}
