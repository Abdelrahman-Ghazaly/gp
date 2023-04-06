import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum Category {
  bed,
  chair,
  sofa,
  lamp,
  table,
  dresser,
}

const double kAppBarHeight = 75;

const String kLottieHeartAnimation =
    'assets/lottie_animations/heart_animation.json';

//* TextStyles
final TextStyle kAppBarTextStyle = GoogleFonts.montserrat(
  fontSize: 25,
  fontWeight: FontWeight.w500,
);
