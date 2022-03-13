import 'package:flutter/material.dart';

class DJMstyle {
  final Color _djm_color = Color(0xffff7a00);
  final Color _djm_black_color = Color(0xff303030);
  final Color _djm_gray_color = Color(0x66303030);
  final TextStyle _info_title =
      TextStyle(fontSize: 12, color: Color(0xff4A4A4A));
  final TextStyle _info_info =
      TextStyle(fontSize: 12, color: Color(0xff949494));

  final double _perWidth = 0.88;
  final double _perMarginLeft = 0.06;

  Color get djm_color => _djm_color;
  Color get djm_black_color => _djm_black_color;
  Color get djm_gray_color => _djm_gray_color;
  TextStyle get info_title => _info_title;
  TextStyle get info_info => _info_info;

  double get perWidth => _perWidth;
  double get perMarginLeft => _perMarginLeft;
}
