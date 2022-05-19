import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:djm/djm_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math';

class ImageWithInfo extends StatefulWidget {
  late int _index;
  late AsyncSnapshot _snapshot;
  late String _univ_list;

  ImageWithInfo(AsyncSnapshot snapshot, int index, this._univ_list) {
    _index = index;
    _snapshot = snapshot;
  }

  State<StatefulWidget> createState() {
    return _ImageWithInfo(_snapshot, _index);
  }
}

class _ImageWithInfo extends State<ImageWithInfo>
    with SingleTickerProviderStateMixin {
  //Animation
  late AnimationController _animationController;
  late Animation _rotateAnimation;
  late Animation<double> _sizeAnimation;

  bool _button_state = true;

  late int _index;
  late AsyncSnapshot _snapshot;
  _ImageWithInfo(AsyncSnapshot snapshot, int index) {
    _index = index;
    _snapshot = snapshot;
  }

  @override
  void initState() {
    _animationController =
        AnimationController(duration: Duration(milliseconds: 650), vsync: this);

    _rotateAnimation = Tween<double>(begin: 0, end: pi).animate(
        new CurvedAnimation(
            parent: _animationController, curve: Curves.easeInOutBack));

    _sizeAnimation = new CurvedAnimation(
        parent: _animationController, curve: Curves.easeInBack);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  void _info_button_action() {
    if (!_animationController.isCompleted) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    _button_state = !_button_state;
  }

  @override
  Widget build(BuildContext context) {
    //style
    DJMstyle djm_style = new DJMstyle();

    // width
    double _infoSection_width =
        MediaQuery.of(context).size.width * 88 / 100; //위젯 width
    double _menuMarginLeft =
        (MediaQuery.of(context).size.width - _infoSection_width) / 2;

    Widget _infoGrade = StreamBuilder<DocumentSnapshot<Object?>>(
        stream: FirebaseFirestore.instance
            .collection(widget._univ_list)
            .doc(_snapshot.data.docs[_index]["key"])
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error");
          } else if (!snapshot.hasData) {
            return CircularProgressIndicator();
          } else {
            Map<String, dynamic> docJson =
                snapshot.data?.data() as Map<String, dynamic>;

            return Container(
                margin: EdgeInsets.only(top: 20),
                child: Text(docJson["grade"],
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 36,
                        color: djm_style.djm_color)));
          }
        });
    // Container(
    //     margin: EdgeInsets.only(top: 20),
    //     child: Text(_snapshot.data.docs[_index]["grade"],
    //         style: TextStyle(
    //             fontWeight: FontWeight.bold,
    //             fontSize: 36,
    //             color: djm_style.djm_color)));

    Widget _infoShopName = Container(
        margin: EdgeInsets.only(bottom: 4),
        child: Text(_snapshot.data.docs[_index]["name"],
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color(0xff303030))));

    Widget _infoinfo = Container(
        width: _infoSection_width,
        child: SizeTransition(
            axis: Axis.vertical,
            axisAlignment: -1,
            sizeFactor: _sizeAnimation,
            child: Center(
                child: Container(
                    width: 260,
                    child: Table(
                      columnWidths: const <int, TableColumnWidth>{
                        0: FlexColumnWidth(),
                        1: FixedColumnWidth(200)
                      },
                      children: <TableRow>[
                        TableRow(children: <Widget>[
                          TableCell(
                              child: Container(
                            width: 80,
                            child: Text("주소", style: djm_style.info_title),
                          )),
                          TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Container(
                                  width: 160,
                                  child: Container(
                                      margin: EdgeInsets.all(2),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              _snapshot.data.docs[_index]
                                                  ["address_load"],
                                              style: djm_style.info_info),
                                          Text(
                                              _snapshot.data.docs[_index]
                                                  ["address_num"],
                                              style: djm_style.info_info)
                                        ],
                                      ))))
                        ]),
                        TableRow(children: <Widget>[
                          TableCell(
                              child: Container(
                                  child: Text("전화번호",
                                      style: djm_style.info_title))),
                          TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Container(
                                  margin: EdgeInsets.all(2),
                                  child: Text(
                                      _snapshot.data.docs[_index]["call"],
                                      style: djm_style.info_info)))
                        ]),
                        TableRow(children: <Widget>[
                          TableCell(
                              child: Container(
                            width: 80,
                            child: Text("영업시간", style: djm_style.info_title),
                          )),
                          TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Container(
                                  width: 160,
                                  child: Container(
                                      margin: EdgeInsets.all(2),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              _snapshot.data.docs[_index]
                                                  ["time"],
                                              style: djm_style.info_info),
                                        ],
                                      ))))
                        ])
                      ],
                    )))));

    Widget _infoButton = AnimatedBuilder(
        animation: _rotateAnimation,
        builder: (context, widget) {
          return Transform.rotate(
              angle: _rotateAnimation.value,
              child: GestureDetector(
                child: Image.asset("image/info_icon.png"),
                onTap: () {
                  setState(() {
                    _info_button_action();
                  });
                },
              ));
        });

    Widget _infoSection = Container(
        width: _infoSection_width,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  offset: Offset(4.0, 4.0),
                  blurRadius: 15.0,
                  spreadRadius: 1.0)
            ]),
        child: Center(
            child: Column(children: [
          _infoGrade,
          _infoShopName,
          _infoinfo,
          _infoButton
        ])));

    /**
     * _imageSection: 가게 대표 이미지 하나,(stack button click을 위해서 빈 animatedcontainer 설치)
     * _stackSection: 가게 이미지 위에 정보 위젯 겹치게 만들었음
     */
    Widget _imageSection = Column(children: [
      Container(
          height: 240,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40.0),
                      bottomRight: Radius.circular(40.0)),
                  child: Image.network(_snapshot.data.docs[_index]["shop_img"],
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fitWidth))
            ],
          )),
      AnimatedContainer(
          duration: Duration(milliseconds: 600),
          curve: Curves.easeInBack,
          height: _button_state ? 104 : 204)
    ]);

    Widget _stackSection = Container(
      child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: <Widget>[
            _imageSection,
            Positioned(top: 200, child: _infoSection)
          ]),
    );

    return _stackSection;
  }
}
