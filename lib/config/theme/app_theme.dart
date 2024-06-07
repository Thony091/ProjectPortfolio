import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class AppTheme{
  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    colorScheme:  const ColorScheme.light(
      primary: Color.fromARGB(234, 242, 169, 11),
      secondary: Color.fromARGB(255, 254, 249, 224),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
    ),
    listTileTheme: const ListTileThemeData(),
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