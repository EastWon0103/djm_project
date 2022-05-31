import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:djm/djm_style.dart';
import 'package:djm/review/reviewMainWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Review extends StatelessWidget {
  late String _docId = "";
  late String _univList;

  Review(String id, String univ_list) {
    _docId = id;
    _univList = univ_list;
  }

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

    Widget _userProfile(String user_key) {
      return StreamBuilder<DocumentSnapshot<Object?>>(
          stream: FirebaseFirestore.instance
              .collection("user")
              .doc(user_key)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Map<String, dynamic> userSnap =
                  snapshot.data?.data() as Map<String, dynamic>;

              return ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(userSnap["photo"],
                      width: 40, height: 40, fit: BoxFit.cover));
            } else {
              return ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                      "https://firebasestorage.googleapis.com/v0/b/djm-project-a2f8b.appspot.com/o/userprofile.png?alt=media&token=d964722c-0b67-4453-a701-fd7985164e85",
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover));
            }
          });
    }

    Widget _userReview(String msg) {
      return Container(
          padding: EdgeInsets.only(left: 12),
          width: _widgetWidth * 7 / 10,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("2022-01-04",
                    style: TextStyle(color: Color(0xffa9a9a9), fontSize: 10)),
                Text(msg.length < 25 ? msg : msg.substring(0, 24) + "...",
                    style: TextStyle(color: Color(0xff212121), fontSize: 12))
              ]));
    }

    Widget _userGrade(String grade) {
      return Text(grade,
          textAlign: TextAlign.end,
          style: TextStyle(
              color: djm_style.djm_color,
              fontSize: 18,
              fontWeight: FontWeight.bold));
    }

    Widget _preview(Map<String, dynamic> review) {
      return Container(
          width: _widgetWidth,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _userProfile(review["user_key"]),
                Flexible(
                    flex: 7,
                    fit: FlexFit.tight,
                    child: _userReview(review["msg"])),
                Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: _userGrade(review["grade"]))
              ]));
    }

    Widget _reviewButton(String shopId, String shopName) {
      return Container(
          margin: EdgeInsets.only(top: 12),
          width: _widgetWidth,
          child: OutlinedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) =>
                            ReviewMainWidget(shopId, shopName, _univList))));
              },
              style: ButtonStyle(),
              child: Text("리뷰 더보기",
                  style: TextStyle(color: djm_style.djm_color, fontSize: 12))));
    }

    Widget _reviewSection = StreamBuilder<DocumentSnapshot<Object?>>(
        stream: FirebaseFirestore.instance
            .collection("review")
            .doc(_docId)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text("this is error");
          } else if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            List<dynamic> _reviewList = snapshot.data.data()["reviews"];
            String _shopName = snapshot.data.data()["shop_name"];

            return Container(
                height: 200,
                child: Column(
                  children: <Widget>[
                    _reviewDivider,
                    _reviewTitle,
                    _preview(_reviewList[0]),
                    _reviewButton(snapshot.data.id, _shopName)
                  ],
                ));
          }
        });

    return _reviewSection;
  }
}
