import 'package:djm/djm_style.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  final List<String> _GRADE = [
    "A+",
    "A0",
    "B+",
    "B0",
    "C+",
    "C0",
    "D+",
    "D0",
    "F"
  ];
  String _dropValue = "A+";

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
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(children: [
                  Row(children: [
                    Container(
                        margin: EdgeInsets.only(right: 20),
                        child: Text("맛학점",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20))),
                    DropdownButton(
                        value: _dropValue,
                        items: _GRADE
                            .map((e) =>
                                DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (value) => setState(() {
                              _dropValue = value.toString();
                              print(_dropValue);
                            }))
                  ]),
                  ElevatedButton(
                      onPressed: () async {
                        var picker = ImagePicker();
                        final List<XFile>? images =
                            await picker.pickMultiImage();
                      },
                      child: Text("사진 불러오기"))
                ]))));
  }
}
