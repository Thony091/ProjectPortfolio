import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class AppTheme{

  static final List<Color> goldGradientColors = [
    const Color(0xFFF2CB6E),
    const Color(0xFFC9A554),
    const Color(0xFFB4883E),
    const Color(0xFFF2CB6E),
    const Color(0xFF8C6423),
  ];

  static final List<double> goldGradientStops = [
    0.0,
    0.3,
    0.5,
    0.7,
    1.0,
  ];

  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    colorScheme:  const ColorScheme.light(
      primary: Color.fromARGB(234, 242, 169, 11),
      secondary: Color.fromARGB(255, 254, 249, 224),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
    ),
    listTileTheme: const ListTileThemeData(),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        color: Colors.white, 
        fontSize: 20, 
        fontWeight: FontWeight.bold,
        shadows: [
          Shadow(
            offset: Offset(1.0, 3.0),
            blurRadius: 3.0,
            color: Colors.black54
          )
        ]
      ),
      labelLarge:  TextStyle(
        color: Colors.black54,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w600,
        fontSize: 18
      )
    ),

    // textTheme: TextTheme(
    //   titleLarge: GoogleFonts.montserrat(
    //     fontSize: 24,
    //     fontWeight: FontWeight.w600,
    //     color: Colors.black,
    //   ),
    //   titleMedium: GoogleFonts.russoOne(
    //     fontSize: 20,
    //     fontWeight: FontWeight.w600,
    //     color: Colors.black,
    //   ),
    // ),
  );
}