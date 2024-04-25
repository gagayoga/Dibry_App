import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/historypeminjaman_controller.dart';

class HistorypeminjamanView extends GetView<HistorypeminjamanController> {
  const HistorypeminjamanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 50,
        titleSpacing: 0,
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
        title: SizedBox(
          width: width,
          child: Text(
            'History Peminjaman Buku',
            style: GoogleFonts.poppins(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkWell(
                onTap: (){
                  controller.getDataPeminjaman();
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
      body: SingleChildScrollView(
        child: SizedBox(
          width: width,
          height: height,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: kontenHistoryPeminjaman(),
              )
            ],
          ),
        ),
      )
    );
  }

  Widget kontenHistoryPeminjaman() {
    const Color background = Color(0xFFFFCD86);
    const Color borderColor = Color(0xFF424242);

    // size
    final width = MediaQuery.of(Get.context!).size.width;
    return SizedBox(
      child: Obx(
            () {
          if (controller.historyPeminjaman.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                      color: background,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: borderColor.withOpacity(0.30),
                        width: 0.02,
                      )
                  ),
                  child: Center(
                    child: Text(
                      'History Peminjaman empty!',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            );
          } else {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.historyPeminjaman.length,
              itemBuilder: (context, index) {
                var dataHistory = controller.historyPeminjaman[index];
                return Padding(
                  padding: EdgeInsets.only(
                      top: index == 0 ? 10 : 0,
                      bottom: 10),
                  child: InkWell(
                    onTap: () {
                    },
                    child: Container(
                      width: width,
                      height: 225,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF6F8FB),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Kode Peminjaman",
                                      style: GoogleFonts.poppins(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12
                                      ),
                                    ),

                                    const SizedBox(
                                      width: 10,
                                    ),

                                    Text(
                                      dataHistory.kodePeminjaman.toString(),
                                      style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(
                                  height: 30,
                                  child: TextButton(
                                      onPressed: (){

                                      },
                                      style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5)
                                        ),
                                        backgroundColor: dataHistory.status == 'Selesai' ? const Color(0xFFE5FFE7)
                                            : dataHistory.status == 'Dipinjam' ? const Color(0xFFFDFFE5) : const Color(0xFFFFE5E5),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        child: Text(
                                          dataHistory.status.toString(),
                                          style: GoogleFonts.poppins(
                                              color: dataHistory.status == 'Selesai' ? const Color(0xFF52F25F)
                                                  : dataHistory.status == 'Dipinjam' ? const Color(0xFF121212) : const Color(0xFFFF0000),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 10
                                          ),
                                        ),
                                      )
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Expanded(
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.white,
                                border: Border.all(
                                  color: const Color(0xFFE2E2E2),
                                  width: 1
                                )
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      height: double.infinity,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          dataHistory.coverBuku.toString(),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),

                                    const SizedBox(
                                      width: 15,
                                    ),

                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            dataHistory.judulBuku.toString().toUpperCase(),
                                            style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.start,
                                          ),

                                          const SizedBox(
                                            height: 3,
                                          ),

                                          Row(
                                            children: [
                                              Text(
                                                'Kode Buku',
                                                style: GoogleFonts.poppins(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                              ),

                                              const SizedBox(
                                                width: 5,
                                              ),

                                              Text(
                                                dataHistory.peminjamanID.toString(),
                                                style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),

                                          const SizedBox(
                                            height: 2,
                                          ),

                                          Row(
                                            children: [
                                              Text(
                                                'Penulis Buku',
                                                style: GoogleFonts.poppins(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                              ),

                                              const SizedBox(
                                                width: 5,
                                              ),

                                              Text(
                                                dataHistory.penulisBuku.toString(),
                                                style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),

                                          const SizedBox(
                                            height: 2,
                                          ),

                                          Row(
                                            children: [
                                              Text(
                                                'Penerbit Buku',
                                                style: GoogleFonts.poppins(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                              ),

                                              const SizedBox(
                                                width: 5,
                                              ),

                                              Text(
                                                dataHistory.penerbitBuku.toString(),
                                                style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),

                                          const SizedBox(
                                            height: 2,
                                          ),

                                          Row(
                                            children: [
                                              Text(
                                                'Tahun Terbit',
                                                style: GoogleFonts.poppins(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                              ),

                                              const SizedBox(
                                                width: 5,
                                              ),

                                              Text(
                                                dataHistory.tahunBuku.toString(),
                                                style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
