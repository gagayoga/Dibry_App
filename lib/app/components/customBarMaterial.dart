import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class CustomBottomBarMaterial extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomBarMaterial({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const Color backgroundColor = Color(0xFFFFFFFF);
    const Color primaryColor = Color(0xFFFFAE7A);

    return BottomNavigationBar(
      unselectedItemColor: Colors.grey,
      selectedItemColor: primaryColor,
      onTap: onTap,
      currentIndex: currentIndex,
      showSelectedLabels: true,
      type: BottomNavigationBarType.fixed,
      backgroundColor: backgroundColor,
      elevation: 0,
      selectedFontSize: 12,
      selectedLabelStyle: GoogleFonts.montserrat(
          fontWeight: FontWeight.w700,
      ),
      iconSize: 28,
      showUnselectedLabels: true,
      items: [
        _bottomNavigationBarItem(
          icon: Iconsax.home5,
          label: 'Home',
        ),
        _bottomNavigationBarItem(
          icon: Iconsax.book4,
          label: 'Bookmarks',
        ),
        _bottomNavigationBarItem(
          icon: null,
          label: '',
        ),
        _bottomNavigationBarItem(
          icon: Iconsax.clock5,
          label: 'History',
        ),
        _bottomNavigationBarItem(
          icon: Iconsax.profile_circle5,
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
      return BottomNavigationBarItem(
        icon: Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFFFAE7A),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SvgPicture.asset(
              'assets/logo/logo.svg',
              width: 30,
              height: 30,
            ),
          ),
        ),
        label: label,
      );
    }
  }
}
