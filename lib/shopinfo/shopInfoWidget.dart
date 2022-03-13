import 'package:djm/djm_style.dart';
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
        appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text("대존맛",
                style: TextStyle(
                    fontFamily: 'KotraHands',
                    fontSize: 20,
                    color: DJMstyle().djm_black_color)),
            leading: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.arrow_back_ios_new,
                    color: DJMstyle().djm_color))),
        body: ListView(
            scrollDirection: Axis.vertical,
            children: [_stackSection, _menuSection, _reviewSection]));
  }
}
