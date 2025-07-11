import 'package:flutter/material.dart';

class LogoCompany extends StatelessWidget {
  final double width;
  final double height;
  LogoCompany({this.width = 200, this.height = 200});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        'assets/logo/logo.png',
        width: width,
        height: height,
      ),
    );
  }
}
