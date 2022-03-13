import 'package:djm/shopinfo/imageWithInfo.dart';
import 'package:flutter/material.dart';
import 'package:djm/shopinfo/menList.dart';
import 'package:djm/shopinfo/review.dart';

class ShopInfoWidget extends StatelessWidget {
  late String index;

  ShopInfoWidget(int index) {
    this.index = index.toString();
  }

  @override
  Widget build(BuildContext context) {
    Widget _stackSection = ImageWithInfo(this.index);
    Widget _menuSection = MenuList();
    Widget _reviewSection = Review();
    return Scaffold(
        body: ListView(
            scrollDirection: Axis.vertical,
            children: [_stackSection, _menuSection, _reviewSection]));
  }
}
