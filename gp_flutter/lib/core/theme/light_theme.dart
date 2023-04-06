import 'package:flutter/material.dart';

ThemeData kLightThemeData() => ThemeData.light().copyWith(
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          iconSize: 25,
        ),
      ),
      iconTheme: IconThemeData(
        size: 25,
      ),
    );
