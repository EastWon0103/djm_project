import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:djm/djm_style.dart';
import 'package:djm/shopinfo/imageWithInfo.dart';
import 'package:flutter/material.dart';
import 'package:djm/shopinfo/menList.dart';
import 'package:djm/shopinfo/review.dart';

class ShopInfoWidget extends StatelessWidget {
  late int _index;
  late AsyncSnapshot _snapshot;
  late String _univ_list;

  ShopInfoWidget(AsyncSnapshot snapshot, int index, String univ_list) {
    _index = index;
    _snapshot = snapshot;
    _univ_list = univ_list;
  }

  @override
  Widget build(BuildContext context) {
    Widget _stackSection = ImageWithInfo(_snapshot, _index);
    Widget _menuSection = MenuList(_snapshot.data.docs[_index]["menu"]);
    Widget _reviewSection = Review(_snapshot.data.docs[_index].id, _univ_list);
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
