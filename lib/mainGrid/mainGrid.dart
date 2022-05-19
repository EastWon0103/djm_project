import 'dart:isolate';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:djm/djm_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:djm/shopinfo/shopInfoWidget.dart';
import 'package:transition/transition.dart';

class MainGridView extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _MainGridView();
  }
}

class _MainGridView extends State<MainGridView> with TickerProviderStateMixin {
  // Animation
  late AnimationController _colorAnimationController;
  late Animation _colorTween;
  final double _animationSpeed = 430;
  final double _expandedHeight = 480;

  String _university = "";
  String _university_img = "";
  String _univ_list = "";

  GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    _colorAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 0));
    _colorTween = ColorTween(begin: Colors.white, end: Colors.black)
        .animate(_colorAnimationController);
  }

  @override
  void dispose() {
    _colorAnimationController.dispose();
    super.dispose();
  }

  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      print("signout");
      Navigator.of(context).pushReplacementNamed('/login');
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> _getData() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    String univ = "";
    String univImg = "";
    String list_name = "kookmin_list";
    var referenceUser = FirebaseFirestore.instance.collection("user").doc(uid);
    await referenceUser.get().then(
          (value) => {univ = value["university"]},
        );
    var referenceUniv = FirebaseFirestore.instance.collection("University");
    await referenceUniv.get().then(
      (value) {
        value.docs.forEach((element) {
          if (univ == element["name"]) {
            univImg = element["image"];
            list_name = element["collection"];
          }
        });
      },
    );
    setState(() {
      _university = univ;
      _university_img = univImg;
      _univ_list = list_name;
    });
    return "string";
  }

  bool _scrollListner(ScrollNotification scrollState) {
    if (scrollState.metrics.axis == Axis.vertical) {
      _colorAnimationController
          .animateTo(scrollState.metrics.pixels / _animationSpeed);
      return true;
    }
    return false;
  }

  Widget build(BuildContext context) {
    double _marginLeft = MediaQuery.of(context).size.width * 0.03;
    double _gridSize = MediaQuery.of(context).size.width * 0.4;
    return Scaffold(
        key: _key,
        endDrawer: Drawer(
            child: SafeArea(
          child: Column(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                  "${FirebaseAuth.instance.currentUser?.photoURL}"),
            ),
            Text("${FirebaseAuth.instance.currentUser?.email}"),
            OutlinedButton(onPressed: () => _signOut(), child: Text("로그아웃"))
          ]),
        )),
        backgroundColor: Colors.white,
        body: FutureBuilder(
            future: _getData(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("this is error");
              } else if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                return NotificationListener<ScrollNotification>(
                    onNotification: _scrollListner,
                    child: CustomScrollView(
                      slivers: <Widget>[
                        AnimatedBuilder(
                            animation: _colorTween,
                            builder: (context, build) {
                              return SliverAppBar(
                                centerTitle: true,
                                backgroundColor: Colors.white,
                                pinned: true,
                                floating: false,
                                snap: false,
                                expandedHeight: _expandedHeight,
                                leadingWidth: 78,
                                leading: Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: InkWell(
                                        onTap: () => print("leading click"),
                                        child: Row(children: [
                                          Text(_university,
                                              style: TextStyle(
                                                  color: _colorTween.value)),
                                          Icon(Icons.arrow_drop_down_rounded,
                                              color: _colorTween.value)
                                        ]))),
                                actions: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.search,
                                      color: _colorTween.value,
                                    ),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.menu,
                                      color: _colorTween.value,
                                    ),
                                    onPressed: () {
                                      _key.currentState?.openEndDrawer();
                                    },
                                  )
                                ],
                                title: Text("대존맛",
                                    style: TextStyle(
                                        fontFamily: 'KotraHands',
                                        fontSize: 20,
                                        color: _colorTween.value)),
                                flexibleSpace: FlexibleSpaceBar(
                                    background: Container(
                                        height: _expandedHeight,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(80)),
                                          image: DecorationImage(
                                              image:
                                                  NetworkImage(_university_img),
                                              fit: BoxFit.fitHeight,
                                              colorFilter: ColorFilter.mode(
                                                  Colors.black54,
                                                  BlendMode.darken)),
                                        ),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 176),
                                                  child: Text(
                                                      "${_university}학교는...",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color:
                                                              Colors.white))),
                                              Text("알콜사랑꾼",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 50)),
                                              Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 50),
                                                  child: Text("평균맛학점은...",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20))),
                                              Text("4.3",
                                                  style: TextStyle(
                                                      color:
                                                          DJMstyle().djm_color,
                                                      fontSize: 55)),
                                            ]))),
                              );
                            }),
                        SliverToBoxAdapter(
                            child: Container(
                                margin: EdgeInsets.only(
                                    bottom: 8, top: 20, left: _marginLeft * 2),
                                child: Row(
                                  children: [
                                    Text(
                                      "대표",
                                      style: TextStyle(
                                          fontSize: 24,
                                          //fontWeight: FontWeight.bold,
                                          color: DJMstyle().djm_black_color),
                                    ),
                                    Padding(padding: EdgeInsets.all(2)),
                                    Text("맛집",
                                        style: TextStyle(
                                            fontSize: 24,
                                            //fontWeight: FontWeight.bold,
                                            color: DJMstyle().djm_color))
                                  ],
                                ))),
                        StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection(_univ_list)
                                .orderBy("grade")
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return SliverToBoxAdapter(
                                    child: Center(child: Text("is error")));
                              } else if (!snapshot.hasData) {
                                return SliverToBoxAdapter(
                                    child: CircularProgressIndicator());
                              } else {
                                return SliverPadding(
                                  padding: EdgeInsets.all(_marginLeft),
                                  sliver: SliverGrid(
                                    gridDelegate:
                                        const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 250.0,
                                      mainAxisExtent: 200.0,
                                      mainAxisSpacing: 5.0,
                                      crossAxisSpacing: 5.0,
                                    ),
                                    delegate: SliverChildBuilderDelegate(
                                      (BuildContext context, int index) {
                                        return GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: ((context) =>
                                                          ShopInfoWidget(
                                                              snapshot,
                                                              index,
                                                              _univ_list))));
                                            },
                                            child: Center(
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                  Container(
                                                      height: _gridSize,
                                                      width: _gridSize,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color:
                                                                    Colors.grey,
                                                                offset: Offset(
                                                                    4.0, 4.0),
                                                                blurRadius: 4.0,
                                                                spreadRadius: 0)
                                                          ]),
                                                      alignment:
                                                          Alignment.center,
                                                      child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20)),
                                                          child: Image.network(
                                                            snapshot.data?.docs[
                                                                    index]
                                                                ["shop_img"],
                                                            fit: BoxFit.cover,
                                                            width: _gridSize,
                                                            height: _gridSize,
                                                          ))),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 4),
                                                      child: Text(
                                                          "${snapshot.data?.docs[index]["tag"]}",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: DJMstyle()
                                                                  .djm_gray_color))),
                                                  Container(
                                                      width: _gridSize,
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                                "${snapshot.data?.docs[index]["name"]}"),
                                                            Text(
                                                                "${snapshot.data?.docs[index]["grade"]}",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: DJMstyle()
                                                                        .djm_color))
                                                          ]))
                                                ])));
                                      },
                                      childCount: snapshot.data?.docs.length,
                                    ),
                                  ),
                                );
                              }
                            })
                      ],
                    ));
              }
            }));
  }
}
