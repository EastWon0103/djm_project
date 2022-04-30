import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:djm/djm_style.dart';
import 'package:djm/login/enrollPasswordWidget.dart';
import 'package:djm/providor/userProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EnrollEmailWidget extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _EnrollEmailWidget();
  }
}

class _EnrollEmailWidget extends State<EnrollEmailWidget> {
  final _emailConroller = TextEditingController();
  final _firestore = FirebaseFirestore.instance.collection("user");
  final _formEmailKey = GlobalKey<FormState>();
  String _errorMsg = "";
  late UserProvider _userProvider;

  void _submit() {
    _userProvider.email = _emailConroller.text;
    Navigator.push(context,
        MaterialPageRoute(builder: ((context) => EnrollPasswordWidget())));
  }

  void _checkEmail() async {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);

    bool duplicate = false;
    try {
      var duplicate_email =
          await _firestore.get().then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((doc) {
          print(doc["email"]);
          if (_emailConroller.text == doc["email"]) {
            duplicate = true;
          }
        });
      });
    } catch (e) {
      print(e);
      duplicate = false;
    }
    if (duplicate) {
      setState(() {
        _errorMsg = "이미 이메일이 존재합니다.";
      });
    } else if (!regExp.hasMatch(_emailConroller.text)) {
      setState(() {
        _errorMsg = "올바르게 이메일을 입력하세요";
      });
    } else {
      setState(() {
        _errorMsg = "";
      });
      _userProvider.email = _emailConroller.text;
      _submit();
    }
  }

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          ),
          title: Text("회원가입"),
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
        ),
        body: SafeArea(
            child: Form(
                key: _formEmailKey,
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Container(
                          margin: EdgeInsets.fromLTRB(16, 52, 0, 0),
                          child: Text("대존맛에서 사용할",
                              style: TextStyle(
                                  fontSize: 28, fontWeight: FontWeight.bold))),
                      Container(
                          margin: EdgeInsets.only(left: 16, bottom: 8),
                          child: Row(children: [
                            Text("아이디",
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: DJMstyle().djm_color)),
                            Text("를 입력하세요",
                                style: TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.bold))
                          ])),
                      Container(
                          margin: EdgeInsets.only(left: 16, bottom: 160),
                          child:
                              Text("아이디는 이메일만 입력 가능합니다.", style: TextStyle())),
                      Container(
                          margin: EdgeInsets.all(16),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailConroller,
                            decoration: InputDecoration(
                                label: Text(_errorMsg,
                                    style: TextStyle(color: Colors.red))),
                          )),
                      Align(
                          alignment: Alignment.center,
                          child: Container(
                              width: MediaQuery.of(context).size.width - 32,
                              child: ElevatedButton(
                                  onPressed: () => _checkEmail(),
                                  child: Text("이메일 입력완료",
                                      style: TextStyle(color: Colors.white)))))
                    ])))));
  }
}
