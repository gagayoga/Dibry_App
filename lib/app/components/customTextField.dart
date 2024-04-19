import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final controller;
  final String hinText;
  final bool obsureText;
  final Widget? preficIcon;
  final Widget? surficeIcon;
  final void Function(String) onChanged;
  final FormFieldValidator<String>? validator;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hinText,
    required this.obsureText,
    required this.onChanged,
    this.preficIcon,
    this.surficeIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {

    // Color
    const Color borderColor = Color(0xFF000000);

    return TextFormField(
      onChanged: onChanged,
      controller: controller,
      obscureText: obsureText,
      style: GoogleFonts.poppins(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        letterSpacing: -0.3,
      ),
      decoration: InputDecoration(
          filled: true,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor.withOpacity(0.28),
              ),
              borderRadius: BorderRadius.circular(50.50)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor.withOpacity(0.28),
              ),
              borderRadius: BorderRadius.circular(50.50)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor.withOpacity(0.28),
              ),
              borderRadius: BorderRadius.circular(50.50)),
          border: OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor.withOpacity(0.28),
              ),
              borderRadius: BorderRadius.circular(50.50)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          suffixIcon: surficeIcon,
          hintText: hinText,
          hintStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          )
      ),
      validator: validator,
    );
  }
}
