import 'package:flutter/material.dart';

ThemeData kLightThemeData() => ThemeData.light().copyWith(
      useMaterial3: true,
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          iconSize: 25,
        ),
      ),
      iconTheme: const IconThemeData(
        size: 25,
      ),
    );
