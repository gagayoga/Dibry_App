import 'package:dibry_app/app/data/model/buku/response_search_buku.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/model/response_book_new.dart';
import '../../../data/model/response_popular_book.dart';
import '../../../data/provider/api_provider.dart';

class HomeController extends GetxController with StateMixin {
  var newBooks = RxList<DataBookNew>();
  var allBook = RxList<DataSearch>();
  var popularBooks = RxList<DataPopularBook>();

  @override
  void onInit() {
    super.onInit();
    getDataBook();
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

  // Get Data Buku
  Future<void> getDataBook() async{
    allBook.clear();
    change(null, status: RxStatus.loading());
    try {
      final response = await ApiProvider.instance().get('${Endpoint.searchBook}/null');

      if (response.statusCode == 200) {
        final ResponseSearchBuku responseBuku = ResponseSearchBuku.fromJson(response.data);
        if(responseBuku.data!.isEmpty){
          allBook.clear();
          change(null, status: RxStatus.empty());
        }else{
          allBook.assignAll(responseBuku.data!);
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
    }
  }

  void getData(){
    getDataPopular();
    getDataNewBooks();
  }
}
