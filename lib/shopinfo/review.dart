import 'package:djm/djm_style.dart';
import 'package:djm/review/reviewMainWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Review extends StatelessWidget {
  Widget build(BuildContext context) {
    DJMstyle djm_style = new DJMstyle();

    double _widgetWidth =
        MediaQuery.of(context).size.width * djm_style.perWidth;

    double _marginLeft =
        MediaQuery.of(context).size.width * djm_style.perMarginLeft;

    Widget _reviewDivider = Divider(
      height: 10,
      color: Color(0xfff0f0f0),
      thickness: 10,
    );

    Widget _reviewTitle = Container(
        margin: EdgeInsets.only(left: _marginLeft, bottom: 8, top: 34),
        child: Row(
          children: [
            Text(
              "존맛 ",
              style: TextStyle(color: Color(0xff303030), fontSize: 18),
            ),
            Text(
              "리뷰",
              style: TextStyle(color: Color(0xffff7a00), fontSize: 18),
            )
          ],
        ));

    Widget _userProfile = ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset("image/test_ramen.jpg",
            width: 40, height: 40, fit: BoxFit.cover));

    String _review = "우리 아이 술 안주 아빠의 영양 음식";

    Widget _userReview = Container(
        padding: EdgeInsets.only(left: 12),
        width: _widgetWidth * 7 / 10,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          Text("2022-01-04",
              style: TextStyle(color: Color(0xffa9a9a9), fontSize: 10)),
          Text(_review.length < 25 ? _review : _review.substring(0, 24) + "...",
              style: TextStyle(color: Color(0xff212121), fontSize: 12))
        ]));

    Widget _userGrade = Text("A+",
        textAlign: TextAlign.end,
        style: TextStyle(
            color: djm_style.djm_color,
            fontSize: 18,
            fontWeight: FontWeight.bold));

    Widget _preview = Container(
        width: _widgetWidth,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          _userProfile,
          Flexible(flex: 7, fit: FlexFit.tight, child: _userReview),
          Flexible(flex: 1, fit: FlexFit.tight, child: _userGrade)
        ]));

    Widget _reviewButton = Container(
        margin: EdgeInsets.only(top: 12),
        width: _widgetWidth,
        child: OutlinedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => ReviewMainWidget())));
            },
            style: ButtonStyle(),
            child: Text("리뷰 더보기",
                style: TextStyle(color: djm_style.djm_color, fontSize: 12))));
    Widget _reviewSection = Container(
        height: 200,
        child: Column(
          children: <Widget>[
            _reviewDivider,
            _reviewTitle,
            _preview,
            _reviewButton
          ],
        ));
    return _reviewSection;
  }
}
