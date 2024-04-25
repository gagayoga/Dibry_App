import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class CustomImageCarousel extends StatelessWidget {
  const CustomImageCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: ImageSlideshow(
        width: double.infinity,
        height: 200,
        initialPage: 0,
        indicatorColor: const Color(0xFFFFCD86),
        indicatorBackgroundColor: Colors.grey,
        onPageChanged: (value) {
        },
        autoPlayInterval: 15000,
        isLoop: true,
        children: [
          Image.asset(
            'assets/images/konten_home.png',
            fit: BoxFit.cover,
          ),
          Image.asset(
            'assets/images/konten_home.png',
            fit: BoxFit.cover,
          ),
          Image.asset(
            'assets/images/konten_home.png',
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
