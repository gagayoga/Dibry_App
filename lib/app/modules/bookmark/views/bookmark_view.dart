import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/app_pages.dart';
import '../controllers/bookmark_controller.dart';

class BookmarkView extends GetView<BookmarkController> {
  const BookmarkView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // Color
    // const Color backgroundColor = Color(0xFFFFE5D6);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          titleSpacing: 0,
          title: SizedBox(
            width: width,
            child: Text(
              'Koleksi Buku',
              style: GoogleFonts.poppins(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          leading: SizedBox(
            width: 25,
            height: 25,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Image.asset(
                "assets/logo/icon_back.png",
                width: 20,
                height: 20,
              ),
            ),
          ),
          actions: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: InkWell(
                  onTap: (){
                    controller.getData();
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
      body: RefreshIndicator(
        onRefresh: () async{
          controller.getData();
        },
        child: Container(
          width: width,
          height: height,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Obx(()=> controller.koleksiBook.isEmpty ? sectionDataKosong("Koleksi Buku") : sectionSemuaBuku()),
            ),
          ),
        ),
      ),
    );
  }

  Widget sectionSemuaBuku() {
    return Obx((){
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
        itemCount: controller.koleksiBook.length,
        itemBuilder: (context, index) {
          var buku = controller.koleksiBook[index];
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
                color: const Color(0xFFFFE5D6),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 15,
                      child: Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            buku.coverBuku.toString(),
                            fit: BoxFit.cover,
                          ),
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
}
