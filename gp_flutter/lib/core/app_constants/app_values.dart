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

const String _baseAnimationUrl = 'assets/lottie_animations/';
const String _baseIconUrl = 'assets/icons/';

class AppIcons {
  static const String lottieHeartAnimation =
      '${_baseAnimationUrl}heart_animation.json';

  static const String auctionIcon = '${_baseIconUrl}auction.svg';
}

//* TextStyles
final TextStyle kAppBarTextStyle = GoogleFonts.montserrat(
  fontSize: 25,
  fontWeight: FontWeight.w500,
);
