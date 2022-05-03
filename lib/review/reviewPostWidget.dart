import 'package:djm/djm_style.dart';
import 'package:flutter/material.dart';

class ReviewPostWidget extends StatefulWidget {
  late String _shopId;
  late String _shopName;

  ReviewPostWidget(String shopId, String shopName) {
    _shopId = shopId;
    _shopName = shopName;
  }

  @override
  State<StatefulWidget> createState() {
    return _ReviewPostWidget(_shopId, _shopName);
  }
}

class _ReviewPostWidget extends State<ReviewPostWidget> {
  late String _shopId;
  late String _shopName;

  _ReviewPostWidget(String shopId, String shopName) {
    _shopId = shopId;
    _shopName = shopName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: DJMstyle().djm_color,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: Colors.white,
            title: Text("${_shopName}-리뷰작성",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold))),
        body: SingleChildScrollView());
  }
}
