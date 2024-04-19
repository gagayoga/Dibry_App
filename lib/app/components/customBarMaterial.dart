import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomBottomBarMaterial extends StatelessWidget {
  final Color colorIcon = const Color(0xFFFFFFFF);
  final Color colorSelect = const Color(0xFFEA1818);
  final Color colorBackground = const Color(0xFF1B1B1D);
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomBarMaterial({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      unselectedItemColor: colorIcon,
      selectedItemColor: colorSelect,
      onTap: onTap,
      currentIndex: currentIndex,
      showSelectedLabels: true,
      type: BottomNavigationBarType.fixed,
      backgroundColor: colorBackground,
      elevation: 0,
      selectedFontSize: 16,
      selectedLabelStyle: GoogleFonts.inriaSans(
        fontWeight: FontWeight.w700,
      ),
      iconSize: 26,
      showUnselectedLabels: false,
      items: [
        _bottomNavigationBarItem(
          icon: Icons.house_rounded,
          label: 'Home',
        ),
        _bottomNavigationBarItem(
          icon: Icons.explore,
          label: 'Explore',
        ),
        _bottomNavigationBarItem(
          icon: null, // Gunakan null untuk ikon agar menjadi bagian tengah dengan latar belakang
          label: 'Activity',
        ),
        _bottomNavigationBarItem(
          icon: Icons.person_2_rounded,
          label: 'Profile',
        ),
      ],
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItem({
    required IconData? icon,
    required String label,
  }) {
    if (icon != null) {
      return BottomNavigationBarItem(
        icon: Icon(icon),
        label: label,
      );
    } else {
      // Custom item for centered icon with background
      return BottomNavigationBarItem(
        icon: Container(
          width: 56, // Lebar ikon
          height: 56, // Tinggi ikon
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue, // Warna latar belakang biru
          ),
          child: Icon(
            Icons.local_activity,
            size: 32, // Ukuran ikon di dalam latar belakang
            color: colorSelect, // Warna ikon aktif
          ),
        ),
        label: label,
      );
    }
  }
}
