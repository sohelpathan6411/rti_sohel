import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SectionTitle extends StatelessWidget {
  final String? title;
  final Color? color;
  const SectionTitle({Key? key, this.title, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          title!,
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
              color: color!,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
