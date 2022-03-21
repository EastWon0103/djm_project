import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:djm/djm_style.dart';
import 'package:flutter/material.dart';

class AddInfoWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddInfoWidget();
  }
}

class _AddInfoWidget extends State<AddInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () => print("hi"),
            icon: Icon(Icons.clear_outlined, color: Colors.black),
          ),
          shadowColor: Colors.transparent,
        ),
        body: SafeArea(
            child: Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(8, 32, 0, 20),
                  child: Text("자신의 학교를 선택해주세요",
                      style: TextStyle(
                          fontSize: 28, fontWeight: FontWeight.bold))),
              Text("현재 선택 가능 학교",
                  style: TextStyle(fontSize: 20, color: DJMstyle().djm_color)),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("University")
                      .orderBy("name")
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("리스트 준비중입니다...!");
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          return Text("${snapshot.data.docs[index]["name"]}");
                        },
                      );
                    }
                  })
            ]))));
  }
}
