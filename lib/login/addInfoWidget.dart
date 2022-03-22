import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:djm/djm_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddInfoWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddInfoWidget();
  }
}

class _AddInfoWidget extends State<AddInfoWidget> {
  void _tapUniv(String univ) {
    FirebaseFirestore.instance
        .collection("user")
        .doc("${FirebaseAuth.instance.currentUser?.uid}")
        .update({"university": univ});

    Navigator.of(context).pushReplacementNamed('/main');
  }

  Widget _univButton(String univ, String imageUrl) {
    return GestureDetector(
        onTap: () => _tapUniv(univ),
        child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                  colorFilter:
                      ColorFilter.mode(Colors.black54, BlendMode.darken)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
                child: Text("${univ}",
                    style: TextStyle(fontSize: 20, color: Colors.white)))));
  }

  Future<bool> _popEvent(BuildContext context) async {
    Navigator.of(context).pushReplacementNamed('/login');

    try {
      FirebaseFirestore.instance
          .collection("user")
          .doc("${FirebaseAuth.instance.currentUser?.uid}")
          .delete();
      await FirebaseAuth.instance.signOut();
      print("signout");
    } catch (e) {
      print(e.toString());
    }
    return Future.value(true);
  }

  Widget _buildBody(BuildContext context) {
    Widget _addInfo = WillPopScope(
        onWillPop: () => _popEvent(context),
        child: SafeArea(
            child: Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(8, 32, 0, 32),
                  child: Text("자신의 학교를 선택해주세요",
                      style: TextStyle(
                          fontSize: 28, fontWeight: FontWeight.bold))),
              Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text("현재 선택 가능 학교",
                      style: TextStyle(
                          fontSize: 20, color: DJMstyle().djm_color))),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("University")
                      .orderBy("name")
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("리스트 준비중입니다...!");
                    } else if (snapshot.data == null) {
                      return Text("삭제했습니다...!");
                    } else {
                      return Padding(
                          padding: EdgeInsets.all(12),
                          child: GridView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, index) {
                              return _univButton(
                                  "${snapshot.data.docs[index]["name"]}",
                                  "${snapshot.data.docs[index]["image"]}");
                            },
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisSpacing: 12,
                                    crossAxisSpacing: 12,
                                    crossAxisCount: 2,
                                    childAspectRatio: 2),
                          ));
                    }
                  })
            ]))));

    return _addInfo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () => _popEvent(context),
            icon: Icon(Icons.clear_outlined, color: Colors.black),
          ),
          shadowColor: Colors.transparent,
        ),
        body: _buildBody(context));
  }
}
