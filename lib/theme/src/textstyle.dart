import 'package:flutter/material.dart';

abstract class AppTextStyles {
  static TextStyle baseText = const TextStyle(
    color: Colors.black,
    fontSize: 12,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w200,
    height: 0,
  );

  static TextStyle bigText = const TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    height: 0,
  );
  static TextStyle smallText = const TextStyle(
    color: Color(0xFF616161),
    fontSize: 14,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    height: 0,
  );

  static TextStyle headerStyle = const TextStyle(
    //название названия
    color: Colors.white,
    fontSize: 24,
    fontFamily: 'Schoolbell',
    fontWeight: FontWeight.w400,
    height: 0,
  );

  static TextStyle headerName = const TextStyle(
    //название помещения
    color: Color(0xFF295F88),
    fontSize: 20,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w600,
    height: 0,
  );

  static TextStyle navBarTextStyle = const TextStyle(
    //base
    color: Colors.white,
    fontSize: 12,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    height: 0,
  );

  static TextStyle nameForGroup = const TextStyle(
    color: Colors.white,
    fontSize: 19,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    height: 0,
  );
}
