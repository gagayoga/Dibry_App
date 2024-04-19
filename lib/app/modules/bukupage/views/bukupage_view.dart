import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../../components/customTextField.dart';
import '../../../routes/app_pages.dart';
import '../controllers/bukupage_controller.dart';

class BukupageView extends GetView<BukupageController> {
  const BukupageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    // Size
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double appBar = MediaQuery.of(context).padding.top;

    // Color
    const Color backgroundColor = Color(0xFFFFF2EA);


    return Scaffold(
      body: RefreshIndicator(
        color: const Color(0xFFFFCD86),
        backgroundColor: backgroundColor,
        onRefresh: () async{
          controller.getData();
        },
        child: Container(
          margin: EdgeInsets.only(top: appBar),
          width: width,
          height: height,
          color: backgroundColor,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            
                SizedBox(
                  height: height * 0.020,
                ),
            
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Image.asset(
                    'assets/logo/logo_home.png',
                    width: 100,
                    height: 50,
                    fit: BoxFit.fitWidth,
                  ),
                ),
            
                SizedBox(
                  height: height * 0.010,
                ),
            
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CustomTextField(
                    onChanged: (value) => controller.getDataBook(),
                    controller: controller.searchController,
                    hinText: "Pencarian Buku",
                    obsureText:false,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Pleasse input karakter';
                      }
            
                      return null;
                    },
                  ),
                ),
            
                SizedBox(
                  height: height * 0.025,
                ),

                layoutSettings(width, height),
              ],
            ),
          ),
        ),
      )
    );
  }

  Widget layoutSettings(double width, double height){
    const Color primary = Color(0xFFFFCD86);
    return Obx((){
      if(controller.searchController.text == ''){
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Kategori",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),

                  SizedBox(
                    height: height * 0.025,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      kategoriBuku(
                          'assets/kategori/kategori1.svg',
                          'Sains'
                      ),

                      kategoriBuku(
                          'assets/kategori/kategori2.svg',
                          'Komputer'
                      ),

                      kategoriBuku(
                          'assets/kategori/kategori3.svg',
                          'Novel'
                      ),

                      kategoriBuku(
                          'assets/kategori/kategori4.svg',
                          'Math'
                      ),

                      kategoriBuku(
                          'assets/kategori/kategori4.svg',
                          'Math'
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(
              height: height * 0.035,
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "Buku Popular",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),

                SizedBox(
                  height: height * 0.025,
                ),

                controller.popularBooks.isEmpty ? shimmerBukuPopular() : kontenBukuPopular(),
              ],
            ),

            SizedBox(
              height: height * 0.025,
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "Buku Terbaru",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),

                SizedBox(
                  height: height * 0.025,
                ),

                controller.newBooks.isEmpty ? shimmerKontenBukuTerbaru() : kontenBukuTerbaru(),
              ],
            ),

            SizedBox(
              height: height * 0.025,
            ),
          ],
        );
      }else{
        if(controller.isLoading == true){
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
        }else if (controller.dataAllBook.isEmpty){
          return sectionDataKosong(controller.searchController.text.toString());
        }else{
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: sectionSemuaBuku(),
          );
        }
      }
    });
  }

  Widget sectionSemuaBuku() {
    return GridView.builder(
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 4 / 7,
      ),
      itemCount: controller.dataAllBook.length,
      itemBuilder: (context, index) {
        var buku = controller.dataAllBook[index];
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
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white.withOpacity(0.35),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 15,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        buku.coverBuku.toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        buku.judul.toString().toUpperCase(),
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          letterSpacing: -0.2,
                          fontSize: 14.0,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
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
            'Sorry data $text kosong!',
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
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

  // Kategori Buku
  Widget kategoriBuku(String image, String nama){
    return SizedBox(
      width: 65,
      height: 85,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 65,
            height: 65,
            child: SvgPicture.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(
            height: 5,
          ),

          FittedBox(
            child: Text(
              nama,
              style: GoogleFonts.poppins(
                fontSize:10,
                fontWeight: FontWeight.w600,
                color: Colors.black
              ),
            ),
          )
        ],
      ),
    );
  }
}
