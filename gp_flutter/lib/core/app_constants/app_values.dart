import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum Category {
  bed,
  chair,
  sofa,
  accessories,
  table,
  dresser,
}

extension MapToString on Category? {
  String mapToString() {
    switch (this) {
      case Category.bed:
        return 'bed';
      case Category.chair:
        return 'chair';
      case Category.sofa:
        return 'sofa';
      case Category.accessories:
        return 'accessories';
      case Category.table:
        return 'table';
      case Category.dresser:
        return 'dresser';
      case null:
        return '';
      default:
        return '';
    }
  }
}

const List<String> searchCategory = [
  "All",
  "bed",
  "chair",
  "sofa",
  'accessories',
  "table",
  "dresser",
];

const double kAppBarHeight = 75;

const String _baseIconUrl = 'assets/icons/';

class AppIcons {
  static const String auctionIcon = '${_baseIconUrl}auction.svg';
}

const String _baseAnimationUrl = 'assets/lottie_animations/';

class AppAnimations {
  static const String lottieHeartAnimation =
      '${_baseAnimationUrl}heart_animation.json';
  static const String lottieManProfileAnimation =
      '${_baseAnimationUrl}man_profile.json';
  static const String lottieFemaleProfileAnimation =
      '${_baseAnimationUrl}female_profile.json';
  static const String lottiePasswordAnimation =
      '${_baseAnimationUrl}password.json';
  static const String lottiePersonalIdAnimation =
      '${_baseAnimationUrl}personal_id.json';
  static const String lottieAccountCreatedAnimation =
      '${_baseAnimationUrl}account_created.json';
}

const String _baseImageUrl = 'assets/images/';
const String _baseBannerUrl = '${_baseImageUrl}banners/';

class AppImages {
  static const List<String> bannerImages = [
    '${_baseBannerUrl}banner_3.jpg',
    '${_baseBannerUrl}banner_4.png',
    '${_baseBannerUrl}banner_3.jpg',
    '${_baseBannerUrl}banner_4.png',
  ];
  static const String profilImage = '${_baseImageUrl}profile_image.png';
  static const String profilBackground =
      '${_baseImageUrl}profile_background.jpg';
}

class AppTextStyles {
  static final TextStyle appBarTextStyle = GoogleFonts.montserrat(
    fontSize: 25,
    fontWeight: FontWeight.w700,
  );
  static final TextStyle headerTextStyle = GoogleFonts.montserrat(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );
  static final TextStyle titileTextStyle = GoogleFonts.montserrat(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );
  static final TextStyle descriptionTextStyle = GoogleFonts.montserrat(
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );
}

SizedBox kSpacing(double space) => SizedBox(
      height: space,
      width: space,
    );
