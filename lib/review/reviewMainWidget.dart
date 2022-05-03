import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:djm/djm_style.dart';
import 'package:djm/review/reviewPostWidget.dart';
import 'package:flutter/material.dart';

class ReviewMainWidget extends StatelessWidget {
  String _shopId = "";
  String _shopName = "";

  ReviewMainWidget(String shopId, String shopName) {
    _shopId = shopId;
    _shopName = shopName;
  }

  Widget _reviewItem(Map<String, dynamic> review) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        constraints: BoxConstraints(minHeight: 150),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          StreamBuilder<DocumentSnapshot<Object?>>(
              stream: FirebaseFirestore.instance
                  .collection("user")
                  .doc(review["user_key"])
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Container(child: Text("error"));
                } else if (!snapshot.hasData) {
                  return Container(child: Text("null"));
                } else {
                  Map<String, dynamic> _userInfo =
                      snapshot.data?.data() as Map<String, dynamic>;
                  return Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(_userInfo["photo"],
                                width: 40, height: 40, fit: BoxFit.cover)),
                        Container(
                            margin: EdgeInsets.only(top: 4),
                            child: Text(
                              _userInfo["name"],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ))
                      ]));
                }
              }),
          Padding(
              padding: EdgeInsets.all(12),
              child: Container(
                  width: 300,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(review["date"],
                                  style: TextStyle(
                                      color: DJMstyle().djm_gray_color,
                                      fontSize: 12)),
                              Text(review["grade"],
                                  style: TextStyle(
                                      color: DJMstyle().djm_color,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))
                            ]),
                        Container(
                            child: RichText(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 7,
                          text: TextSpan(
                              text: review["msg"],
                              style: TextStyle(color: Colors.black)),
                        )),
                        Container(
                            margin: EdgeInsets.only(top: 12, bottom: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                review["img1"] != ""
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(review["img1"],
                                            width: 88,
                                            height: 88,
                                            fit: BoxFit.cover))
                                    : Container(),
                                review["img2"] != ""
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(review["img2"],
                                            width: 88,
                                            height: 88,
                                            fit: BoxFit.cover))
                                    : Container(),
                                review["img3"] != ""
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(review["img3"],
                                            width: 88,
                                            height: 88,
                                            fit: BoxFit.cover))
                                    : Container(),
                              ],
                            ))
                      ])))
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(_shopName, style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: DJMstyle().djm_color,
            ),
            onPressed: () => Navigator.of(context).pop()),
      ),
      body: StreamBuilder<DocumentSnapshot<Object?>>(
          stream: FirebaseFirestore.instance
              .collection("review")
              .doc(_shopId)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("this is error"));
            } else if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              Map<String, dynamic> _reviewDoc =
                  snapshot.data?.data() as Map<String, dynamic>;
              List<dynamic> _reviewList = _reviewDoc["reviews"];
              return ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                        color: Colors.grey,
                        height: 4,
                      ),
                  itemCount: _reviewList.length,
                  itemBuilder: (context, index) =>
                      _reviewItem(_reviewList[index]));
            }
          }),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) =>
                      ReviewPostWidget(_shopId, _shopName)))),
          child: Icon(
            Icons.edit_note,
            color: Colors.white,
          )),
    );
  }
}
