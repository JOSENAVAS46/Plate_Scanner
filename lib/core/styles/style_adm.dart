import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StyleApp {
  final double _size;
  //
  StyleApp(this._size);

  static Color appColorPrimary = const Color(0xFF013565);
  static Color appColorNegro = const Color(0xFF000000);
  static Color appColorAzul = const Color(0xFF1D04FA);
  static Color appColorCeleste = const Color(0xFF00A3FF);
  static Color appColorAmarillo = const Color(0xFFECD500);
  static Color appColorBlanco = const Color(0xFFFFFFFF);
  static Color appColorNaranja = const Color(0xFFF85B00);
  static Color appColorosado = const Color(0xFFD300F8);
  static Color appColorVerde = const Color(0xFF09DB37);
  static Color appColorTrue = const Color(0xFF49FF70);
  static Color appColorFalse = const Color(0xFFFF7A7A);
  static Color appColorPlomo = const Color(0xffa6a9b2);
  static Color appColormediblanco = const Color(0xF0FFFFFF);
  static Color appColormeditransparente = const Color(0xB0FFFFFF);
  static Color appColorPlanificado = const Color(0xFFFFC654);
  static Color appColorEnCurso = const Color(0xFF6FF234);
  static Color appColorFinalizado = const Color(0xFF858080);

  static TextStyle bigTitleStyle = GoogleFonts.roboto(
    color: appColorNegro,
    fontSize: 25,
    fontWeight: FontWeight.bold,
    letterSpacing: 2,
  );

  static TextStyle bigTitleStyleBlanco = GoogleFonts.roboto(
    color: appColorBlanco,
    fontSize: 25,
    fontWeight: FontWeight.bold,
    letterSpacing: 2,
  );

  static TextStyle mediumTitleStyle = GoogleFonts.poppins(
    fontSize: 20,
    color: appColorNegro,
    letterSpacing: 2,
  );

  static TextStyle mediumTitleStyleBlanco = GoogleFonts.poppins(
    fontSize: 20,
    color: appColorBlanco,
    letterSpacing: 2,
  );

  static TextStyle mediumTitleStyleBold = GoogleFonts.poppins(
      fontSize: 20,
      color: appColorNegro,
      letterSpacing: 2,
      fontWeight: FontWeight.bold);

  static TextStyle mediumTitleStyleBlancoBold = GoogleFonts.poppins(
      fontSize: 20,
      color: appColorBlanco,
      letterSpacing: 2,
      fontWeight: FontWeight.bold);

  static TextStyle regularTxtStyle = GoogleFonts.poppins(
    fontSize: 15,
    color: appColorNegro,
  );

  static TextStyle regularTxtStyleBlanco = GoogleFonts.poppins(
    fontSize: 15,
    color: appColorBlanco,
  );

  static TextStyle regularTxtStyleBold = GoogleFonts.poppins(
      fontSize: 15, color: appColorNegro, fontWeight: FontWeight.bold);

  static TextStyle regularTxtStyleBoldBlanco = GoogleFonts.poppins(
      fontSize: 15, color: appColorBlanco, fontWeight: FontWeight.bold);

  static TextStyle smallTxtStyle = GoogleFonts.poppins(
    fontSize: 13,
    color: appColorNegro,
  );

  static TextStyle smallTxtStyleBlanco = GoogleFonts.poppins(
    fontSize: 13,
    color: appColorBlanco,
  );

  static TextStyle smallTxtStyleBold = GoogleFonts.poppins(
      fontSize: 13, color: appColorNegro, fontWeight: FontWeight.bold);

  static TextStyle smallTxtStyleBlancoBold = GoogleFonts.poppins(
      fontSize: 13, color: appColorBlanco, fontWeight: FontWeight.bold);

  static TextStyle appBarStyle =
      GoogleFonts.poppins(fontSize: 18, color: appColorNegro, letterSpacing: 2);

  static TextStyle appBarStyleBlanco = GoogleFonts.poppins(
      fontSize: 18, color: appColorBlanco, letterSpacing: 2);

  static TextStyle appBarStyleBold = GoogleFonts.poppins(
      fontSize: 18,
      color: appColorNegro,
      letterSpacing: 2,
      fontWeight: FontWeight.bold);

  static TextStyle appBarStyleBlancoBold = GoogleFonts.poppins(
      fontSize: 18,
      color: appColorBlanco,
      letterSpacing: 2,
      fontWeight: FontWeight.bold);

  static TextStyle listCardTittle = GoogleFonts.poppins(
    fontSize: 13,
    fontWeight: FontWeight.bold,
  );

  static TextStyle listCardSubtitle = GoogleFonts.poppins(
    fontSize: 13,
  );

  static TextStyle detailTextTitle = GoogleFonts.poppins(
    fontSize: 15,
    color: appColorPlomo,
    fontWeight: FontWeight.bold,
  );

  static TextStyle detailTextValue = GoogleFonts.poppins(
    fontSize: 15,
    color: appColorNegro,
    fontWeight: FontWeight.bold,
  );
}
