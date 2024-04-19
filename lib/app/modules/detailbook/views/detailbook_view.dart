import 'package:dibry_app/app/data/model/buku/response_detail_buku.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/detailbook_controller.dart';

class DetailbookView extends GetView<DetailbookController> {
  const DetailbookView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    // Size
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    // Color
    const Color backgroundColor = Color(0xFFFFF2EA);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        toolbarHeight: 55,
        titleSpacing: -5,
        title: Text(
          Get.parameters['judul'].toString(),
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.2
          ),
        ),
        actions: [

          Obx(() {
            var dataBuku = controller.detailBuku.value?.buku;
            return SizedBox(
              width: 50,
              height: 50,
              child: IconButton(
                icon: Icon(
                  dataBuku?.status == 'Tersimpan'
                      ? CupertinoIcons.bookmark_fill
                      : CupertinoIcons.bookmark,
                  color: dataBuku?.status == 'Tersimpan'
                      ? const Color(0xFFFFCD86)
                      : Colors.black,
                  size: 24,
                ),
                onPressed: () {
                  if (dataBuku?.status == 'Tersimpan') {
                    controller.deleteKoleksiBook();
                  } else {
                    controller.addKoleksiBuku();
                  }
                },
              ),
            );
          })
        ],
        iconTheme: const IconThemeData(color: Color(0xFFFF9800)),
      ),
      body: RefreshIndicator(
        color: const Color(0xFFFFCD86),
        backgroundColor: backgroundColor,
        onRefresh: ()async{
          await Future.delayed(
            const Duration(milliseconds: 10000),
          );
          controller.getDataDetailBuku();
        },
        child: Container(
          width: width,
          height: height,
          color: backgroundColor,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: kontenDataDetailBuku(context),
            ),
          ),
        ),
      )
    );
  }

  Widget kontenDataDetailBuku(BuildContext context) {

    // Size
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    // Color
    const Color primary = Color(0xFFFFCD86);
    const Color colorText = Color(0xFFFFAE7A);

    return Obx(
          () {
        if (controller.detailBuku.value == null) {
          return Padding(
            padding: EdgeInsets.only(top: height * 0.40),
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
                backgroundColor: Colors.grey,
                valueColor: AlwaysStoppedAnimation<Color>(primary),
              ),
            ),
          );
        } else {
          var dataBuku = controller.detailBuku.value?.buku;
          var dataKategori = controller.detailBuku.value?.kategori;
          var dataUlasan = controller.detailBuku.value?.ulasan;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.030,
                ),

                Center(
                  child: SizedBox(
                    width: 155,
                    height: 210,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        dataBuku!.coverBuku.toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: height * 0.020,
                ),

                Text(
                  dataBuku.judul!.toUpperCase().toString(),
                  maxLines: 2,

                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    fontSize: 26.0,
                    letterSpacing: -0.3
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(
                  height: height * 0.010,
                ),

                // Menampilkan rating di bawah teks penulis
                RatingBarIndicator(
                  rating: dataBuku.rating!,
                  direction: Axis.horizontal,
                  itemCount: 5,
                  itemSize: 30,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: primary,
                  ),
                ),

                SizedBox(
                  height: height * 0.030,
                ),

                SizedBox(
                  width: width,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                    ),
                    onPressed: (){
                      if (dataBuku.statusPeminjaman == 'Belum dipinjam') {
                        controller.addPeminjamanBuku();
                      }else if(dataBuku.statusPeminjaman == 'Dipinjam'){
                        return;
                      }
                    },
                    child: Text(
                      dataBuku.statusPeminjaman == 'Belum dipinjam'
                          ? 'Pinjam Buku' : 'Dipinjam',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: height * 0.040,
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Deskripsi Buku:",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        color: colorText,
                        fontSize: 16.0,
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Text(
                      dataBuku.deskripsi!,
                      maxLines: 15,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(0.80),
                        fontSize: 14.0,
                        letterSpacing: -0.3
                      ),
                      textAlign: TextAlign.justify,
                    ),

                    SizedBox(
                      height: height * 0.025,
                    ),

                    Text(
                      "Detail Buku:",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        color: colorText,
                        fontSize: 16.0,
                      ),
                    ),

                    SizedBox(
                      height: height * 0.015,
                    ),


                    Wrap(
                      children: dataKategori!.map((kategori) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: TextButton(
                            onPressed: () {
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.white.withOpacity(0.25),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100)
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                kategori,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  letterSpacing: -0.2,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    FittedBox(
                      child: Text(
                        "Penerbit: ${dataBuku.penerbit!}",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 16.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    SizedBox(
                      height: height * 0.005,
                    ),
                    FittedBox(
                      child: Text(
                        "Jumlah Halaman: ${dataBuku.jumlahHalaman!}",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 16.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    SizedBox(
                      height: height * 0.005,
                    ),
                    FittedBox(
                      child: Text(
                        "Tahun: ${dataBuku.tahunTerbit!}",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 16.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    SizedBox(
                      height: height * 0.005,
                    ),

                    FittedBox(
                      child: Text(
                        "Jumlah Peminjam: ${dataBuku.jumlahPeminjam!}",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 16.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    SizedBox(
                      height: height * 0.035,
                    ),

                    Text(
                      "Ulasan Buku",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    buildUlasanList(dataUlasan),

                    TextButton(
                      onPressed: (){
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context){
                              return moreUlasanBuku(dataUlasan, dataBuku.judul.toString());
                            }
                        );
                      },
                      child: Text(
                        "Baca selengkapnya",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 16.0,
                        ),
                      ),
                    ),

                    SizedBox(
                      height: height * 0.030,
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget buildUlasanList(List<Ulasan>? ulasanList) {
    final width = MediaQuery.of(Get.context!).size.width;

    return ulasanList != null && ulasanList.isNotEmpty
        ? ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: ulasanList.length > 5 ? 5 : ulasanList.length,
      itemBuilder: (context, index) {
        Ulasan ulasan = ulasanList[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.02),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color(0xFF424242).withOpacity(0.005),
                  width: 0.1,
                )),
            width: width,
            child: Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            SizedBox(
                              width: 35,
                              height: 35,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.asset(
                                  'assets/images/profile.jpg',
                                ),
                              ),
                            ),

                            const SizedBox(
                              width: 5,
                            ),

                            Text(
                              '@${ulasan.users?.username}',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ),

                      RatingBarIndicator(
                        direction: Axis.horizontal,
                        rating: ulasan.rating!.toDouble(),
                        itemCount: 5,
                        itemSize: 10,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Text(
                    ulasan.ulasan ?? '',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 12.0),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    )
        : Container(
      width: width,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color:Colors.grey.withOpacity(0.25),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF424242).withOpacity(0.30),
          width: 0.5,
        ),
      ),
      child: Text(
        'Belum ada ulasan buku',
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          color: Colors.black,
          fontSize: 14.0,
        ),
      ),
    );
  }

  Widget buttonDetailBuku() {
    const Color buttonColor = Color(0xFF008A93);
    const Color borderColor = Color(0xFF424242);

    return SizedBox(
      width: double.infinity,
      height: 50.0,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          side: BorderSide(
            color: borderColor.withOpacity(0.30),
            width: 1.3,
          ),
        ),
        onPressed: () {
          // Logika ketika tombol ditekan
        },
        child: Text(
          'Pinjam Buku',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget moreUlasanBuku(List<Ulasan>? ulasanList, String buku) {
    final width = MediaQuery.of(Get.context!).size.width;
    final height = MediaQuery.of(Get.context!).size.height;

    return ulasanList != null && ulasanList.isNotEmpty
        ? Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(
        color: Color(0xFFFFF2EA),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius : BorderRadius.circular(50),
                  child: Container(
                    width: width * 0.50,
                    height: 3,
                    color: Colors.white,
                  )
                ),

                const SizedBox(
                  height: 15,
                ),

                Text(
                  "Ulasan Buku $buku",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: ulasanList.length,
                    itemBuilder: (context, index) {
                      Ulasan ulasan = ulasanList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.02),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color(0xFF424242).withOpacity(0.005),
                              width: 0.1,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 10,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 35,
                                      height: 35,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(100),
                                        child: Image.asset(
                                          'assets/images/profile.jpg',
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Expanded(
                                      child: Text(
                                        '@${ulasan.users?.username}',
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    RatingBarIndicator(
                                      direction: Axis.horizontal,
                                      rating: ulasan.rating!.toDouble(),
                                      itemCount: 5,
                                      itemSize: 10,
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  ulasan.ulasan ?? '',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    )
    : Container(
      width: width,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color:Colors.grey.withOpacity(0.25),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF424242).withOpacity(0.30),
          width: 0.5,
        ),
      ),
      child: Text(
        'Belum ada ulasan buku',
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          color: Colors.black,
          fontSize: 14.0,
        ),
      ),
    );
  }
}
