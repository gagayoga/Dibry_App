import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final onPressed;
  final Widget child;
  final Color buttonColor;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.buttonColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 50.0,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(100.100))),
            onPressed: onPressed,
            child: child,
            // child: Text(
            //   "Login",
            //   style: GoogleFonts.poppins(
            //       fontSize: 18,
            //       fontWeight: FontWeight.w500,
            //       color: Colors.white),
            // )
        )
    );
  }
}