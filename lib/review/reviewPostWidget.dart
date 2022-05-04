import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:djm/djm_style.dart';
import 'package:flutter/material.dart';
import 'package:images_picker/images_picker.dart';
import 'package:intl/intl.dart';

class ReviewPostWidget extends StatefulWidget {
  late String _shopId;
  late String _shopName;
  late String _univList;

  ReviewPostWidget(String shopId, String shopName, String univList) {
    _shopId = shopId;
    _shopName = shopName;
    _univList = univList;
  }

  @override
  State<StatefulWidget> createState() {
    return _ReviewPostWidget(_shopId, _shopName, _univList);
  }
}

class _ReviewPostWidget extends State<ReviewPostWidget> {
  late String _shopId;
  late String _shopName;
  late String _univList;
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
  List<File>? _imageFileList;
  late TextEditingController _msgController;

  _ReviewPostWidget(String shopId, String shopName, String univList) {
    _shopId = shopId;
    _shopName = shopName;
    _univList = univList;
  }

  @override
  void initState() {
    super.initState();
    _msgController = TextEditingController();
  }

  @override
  void dispose() {
    _msgController.dispose();
    super.dispose();
  }

  void _getImage() async {
    List<Media>? res =
        await ImagesPicker.pick(count: 3, pickType: PickType.image);
    if (res != null) {
      setState(() {
        _imageFileList = [];
        for (int i = 0; i < res.length; i++) {
          _imageFileList!.add(File(res[i].path));
        }
      });
    }
  }

  Widget _showImage() {
    if (_imageFileList == null) {
      return Container();
    } else if (_imageFileList?.length == 0) {
      return Container();
    } else if (_imageFileList?.length == 1) {
      return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Image.file(_imageFileList![0],
            width: 100, height: 100, fit: BoxFit.cover)
      ]);
    } else if (_imageFileList?.length == 2) {
      return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Image.file(_imageFileList![0],
            width: 100, height: 100, fit: BoxFit.cover),
        Image.file(_imageFileList![1],
            width: 100, height: 100, fit: BoxFit.cover)
      ]);
      ;
    } else {
      return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Image.file(_imageFileList![0],
            width: 100, height: 100, fit: BoxFit.cover),
        Image.file(_imageFileList![1],
            width: 100, height: 100, fit: BoxFit.cover),
        Image.file(_imageFileList![2],
            width: 100, height: 100, fit: BoxFit.cover)
      ]);
    }
  }

  Future<String> _uploadPhoto(File image) async {
    final ref = FirebaseStorage.instance
        .ref()
        .child("review")
        .child("${DateTime.now().microsecond}.png");
    final _task = ref.putFile(image);
    await _task.whenComplete(() => null);
    final String _url = await ref.getDownloadURL();

    return _url;
  }

  String _getAvg(List<String> gradeList) {
    double total = 0;
    gradeList.forEach((grade) {
      if (grade == "A+") {
        total += 4.5;
      } else if (grade == "A0") {
        total += 4.0;
      } else if (grade == "B+") {
        total += 3.5;
      } else if (grade == "B0") {
        total += 3.0;
      } else if (grade == "C+") {
        total += 2.5;
      } else if (grade == "C0") {
        total += 2.0;
      } else if (grade == "D+") {
        total += 1.5;
      } else if (grade == "D0") {
        total += 1.0;
      }
    });

    double avg = total / gradeList.length;

    if (avg > 4.3) {
      return "A+";
    } else if (avg > 3.8) {
      return "A0";
    } else if (avg > 3.3) {
      return "B+";
    } else if (avg > 2.8) {
      return "B0";
    } else if (avg > 2.3) {
      return "C+";
    } else if (avg > 1.8) {
      return "C0";
    } else if (avg > 1.3) {
      return "D+";
    } else if (avg > 0.8) {
      return "D0";
    } else {
      return "F";
    }
  }

  void _reviewFinish() async {
    var _review = await FirebaseFirestore.instance
        .collection("review")
        .doc(_shopId)
        .get();

    List<Future<String>> _urlList = [];
    if (_imageFileList != null && _imageFileList!.isNotEmpty) {
      _imageFileList!.forEach((element) {
        _urlList.add(_uploadPhoto(element));
      });
    }

    DateFormat dateFormat = DateFormat("yyyy-MM-dd");

    String _msg = _msgController.text;
    String _grade = _dropValue;
    String _date = dateFormat.format(DateTime.now());
    String _img1 = "";
    String _img2 = "";
    String _img3 = "";
    String _user = await FirebaseAuth.instance.currentUser!.uid;

    if (_urlList != null && _urlList.length > 0) {
      if (_urlList.length == 1) {
        _img1 = await _urlList[0];
      } else if (_urlList.length == 1) {
        _img1 = await _urlList[0];
        _img2 = await _urlList[1];
      } else {
        _img1 = await _urlList[0];
        _img2 = await _urlList[1];
        _img1 = await _urlList[2];
      }
    }

    final _userReview = {
      "date": _date,
      "grade": _grade,
      "img1": _img1,
      "img2": _img2,
      "img3": _img3,
      "msg": _msg,
      "user_key": _user
    };

    //가져오고 세팅하기
    List<dynamic> _oldReviewList = _review.data()!["reviews"];

    List<dynamic> _newReviewList = [];
    _newReviewList.add(_userReview);
    _newReviewList.addAll(_oldReviewList);
    await FirebaseFirestore.instance
        .collection("review")
        .doc(_shopId)
        .update({"reviews": _newReviewList});

    // 자동 평균 내기 해야됨
    List<String> _gradeList = [];
    _newReviewList.forEach((element) {
      _gradeList.add(element["grade"]);
    });

    String _avgGrade = _getAvg(_gradeList);
    FirebaseFirestore.instance
        .collection(_univList)
        .doc(_shopId)
        .update({"grade": _avgGrade});

    Navigator.of(context).pop();
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
        body: CustomScrollView(slivers: [
          SliverFillRemaining(
              hasScrollBody: false,
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
                    _showImage(),
                    ElevatedButton(
                        onPressed: () => _getImage(),
                        child: Text("사진 불러오기",
                            style: TextStyle(color: Colors.white))),
                    TextFormField(
                      controller: _msgController,
                      keyboardType: TextInputType.multiline,
                      minLines: 10,
                      maxLines: 20,
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: ElevatedButton(
                          onPressed: () => _reviewFinish(),
                          child: Text(
                            "리뷰 작성 완료",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                              fixedSize:
                                  Size(MediaQuery.of(context).size.width, 40))),
                    )
                  ])))
        ]));
  }
}
