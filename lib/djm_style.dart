import 'package:flutter/material.dart';

/*
  대존맛 스타일 클래스
  Singletone 패턴
*/

class DJMstyle {
  static final DJMstyle _djmStyle = DJMstyle._internal();
  static const Color _djm_color = Color(0xffff7a00);
  static const Color _djm_black_color = Color(0xff303030);
  static const Color _djm_gray_color = Color(0x66303030);
  static const TextStyle _info_title =
      TextStyle(fontSize: 12, color: Color(0xff4A4A4A));
  static const TextStyle _info_info =
      TextStyle(fontSize: 12, color: Color(0xff949494));

  static const double _perWidth = 0.88;
  static const double _perMarginLeft = 0.06;

  factory DJMstyle() {
    return _djmStyle;
  }

  DJMstyle._internal() {
    print("first signletone");
  }

  Color get djm_color => _djm_color;
  Color get djm_black_color => _djm_black_color;
  Color get djm_gray_color => _djm_gray_color;
  TextStyle get info_title => _info_title;
  TextStyle get info_info => _info_info;

  double get perWidth => _perWidth;
  double get perMarginLeft => _perMarginLeft;
}
