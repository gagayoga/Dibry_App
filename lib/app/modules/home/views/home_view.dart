import 'package:dibry_app/app/components/customImageCarousel.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../../data/model/buku/response_search_buku.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    // Size
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double heightBar = MediaQuery.of(context).padding.top;

    // Color
    const Color backgroundColor = Color(0xFFFFF2EA);

    return Scaffold(
      body: RefreshIndicator(
        color: const Color(0xFFFFCD86),
        backgroundColor: backgroundColor,
        onRefresh: () async{
          controller.getDataBook();
        },
        child: Container(
          margin: EdgeInsets.only(top: heightBar),
          width: width,
          height: height,
          color: backgroundColor,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [

                  SizedBox(
                    height: height * 0.020,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/logo/logo_home.png',
                        width: 80,
                        fit: BoxFit.cover,
                      ),

                      const Icon(
                        Icons.notifications_rounded,
                        color: Colors.black,
                        size: 30,
                      )
                    ],
                  ),

                  SizedBox(
                    height: height * 0.030,
                  ),

                  // InkWell(
                  //   onTap: (){
                  //     Get.toNamed(Routes.BUKUPAGE);
                  //   },
                  //   child: SizedBox(
                  //     width: width,
                  //     height: 200,
                  //     child: ClipRRect(
                  //       borderRadius: BorderRadius.circular(10),
                  //       child: Image.asset(
                  //         'assets/images/konten_home.png',
                  //         fit: BoxFit.cover,
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  CustomImageCarousel(),

                  SizedBox(
                    height: height * 0.025,
                  ),

                  kontenDataBook(),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }

  // Konten Buku Popular
  Widget kontenBukuPopular(){
    return SizedBox(
      height: 205,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.popularBooks.length,
              itemBuilder: (context, index) {
                var buku = controller.popularBooks[index];
                return InkWell(
                  onTap: () {
                    Get.toNamed(Routes.DETAILBOOK,
                      parameters: {
                        'id': (buku.bukuID ?? 0).toString(),
                        'judul': (buku.judul!).toString()
                      },
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      left: index == 0 ? 15 : 0,
                      right: 10
                    ),
                    width: 140,
                    child: SizedBox(
                      width: 140,
                      height: 175,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          buku.coverBuku.toString(),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

            InkWell(
              onTap: () {
              },
              child: Container(
                margin: const EdgeInsets.only(right: 15),
                width: 140,
                height: 205,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.white
                      ),
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Lihat Semuanya",
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget shimmerBukuPopular() {
    int itemCount = 4; // Atur jumlah item palsu

    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade50,
      child: SizedBox(
        height: 205,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: itemCount,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                width: 140,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: 135,
                    height: 175,
                    color: Colors.grey, // Warna placeholder
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
  // End Konten Buku Popular

  // Konten Buku Terbaru
  Widget kontenBukuTerbaru(){
    return SizedBox(
      height: 205,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.newBooks.length,
              itemBuilder: (context, index) {
                var buku = controller.newBooks[index];
                return InkWell(
                  onTap: () {
                    Get.toNamed(Routes.DETAILBOOK,
                      parameters: {
                        'id': (buku.bukuID ?? 0).toString(),
                        'judul': (buku.judulBuku!).toString()
                      },
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        left: index == 0 ? 15 : 0,
                        right: 10
                    ),
                    width: 140,
                    child: SizedBox(
                      width: 140,
                      height: 175,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          buku.coverBuku.toString(),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

            InkWell(
              onTap: () {
              },
              child: Container(
                margin: const EdgeInsets.only(right: 15),
                width: 140,
                height: 205,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.white
                      ),
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Lihat Semuanya",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget shimmerKontenBukuTerbaru() {
    int itemCount = 4; // Atur jumlah item palsu

    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade50,
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: SizedBox(
          height: 205,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: itemCount,
            itemBuilder: (context, index) {
              return SizedBox(
                width: 135,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: 135,
                      height: 175,
                      color: Colors.grey, // Warna placeholder
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
  // End Konten Buku Popular

  // Konten Semua Buku
  Widget kontenDataBook(){
    const Color primary = Color(0xFFFFCD86);
    return Obx((){
        if (controller.allBook.isEmpty) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child:  Center(
              child: CircularProgressIndicator(
                color: Colors.black,
                backgroundColor: Colors.grey,
                valueColor: AlwaysStoppedAnimation<Color>(primary),
              ),
            ),
          );
        }else{
          return ListView.builder(
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.allBook.length,
            itemBuilder: (context, index){
              var kategori = controller.allBook[index].kategoriBuku;
              var bukuList = controller.allBook[index].dataBuku;
              if (bukuList == null || bukuList.isEmpty) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        kategori!,
                        style: GoogleFonts.poppins(
                          fontSize: 18.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFCD86),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'Buku tidak ditemukan di kategori ini',
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.1,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        kategori!,
                        style: GoogleFonts.poppins(
                            fontSize: 18.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w700
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: SizedBox(
                      height: 215,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: bukuList.length,
                        itemBuilder: (context, index) {
                          DataBuku buku = bukuList[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: InkWell(
                              onTap: (){
                                Get.toNamed(Routes.DETAILBOOK,
                                  parameters: {
                                    'id': (buku.bukuID ?? 0).toString(),
                                    'judul': (buku.judul!).toString()
                                  },
                                );
                              },
                              child: SizedBox(
                                width: 135,
                                height: 215,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 135,
                                      height: 180,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: AspectRatio(
                                          aspectRatio: 4 / 5,
                                          child: Image.network(
                                            buku.coverBuku.toString(),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: 5),

                                    Expanded(
                                      child: Text(
                                        buku.judul!.toUpperCase(),
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black,
                                            letterSpacing: -0.3,
                                            fontSize: 12.0
                                        ),
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }
    });
  }

  Widget sectionDataKosong(String text) {
    const Color background = Color(0xFFFFCD86);
    return Center(
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            'Sorry Data $text Empty!',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }


}


