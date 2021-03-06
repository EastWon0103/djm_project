import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:djm/login/addInfoWidget.dart';
import 'package:djm/login/enrollEmailWidget.dart';
import 'package:djm/providor/userProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:djm/djm_style.dart';
import 'package:djm/mainGrid/mainGrid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginWidget extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _LoginWidget();
  }
}

class _LoginWidget extends State<LoginWidget> {
  late bool _passwordVisible;
  late var _loginMaintain;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final CollectionReference _firestoreUser =
      FirebaseFirestore.instance.collection('user');

  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  void initState() {
    _passwordVisible = false;
    _loginMaintain = false;
  }

  @override
  void dispose() {
    _idController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  void _login(BuildContext context) async {
    try {
      final UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _idController.text, password: _pwController.text);

      Navigator.of(context).pushReplacementNamed('/main');
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
          msg: "아이디(이메일) 혹은 비밀번호를 확인하세요",
          backgroundColor: Colors.red,
          gravity: ToastGravity.BOTTOM);
      print("login error");
    }
  }

  void _kakaoLogin() {
    print("kakaotalk");
  }

  void _facebookLogin() {
    print("facebook");
  }

  Future<void> _googleLogin(BuildContext context) async {
    final GoogleSignInAccount? account = await googleSignIn.signIn();
    GoogleSignInAuthentication? authentication = await account?.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: authentication?.accessToken,
      idToken: authentication?.idToken,
    );

    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    final User? _user = authResult.user;

    DocumentSnapshot checking = await _firestoreUser.doc("${_user?.uid}").get();
    if (checking.exists) {
      Navigator.of(context).pushReplacementNamed('/main');
    } else {
      _firestoreUser.doc("${_user?.uid}").set({
        "email": _user?.email,
        "sign": "google",
        "uid": _user?.uid,
        "name": "익명",
        "photo": _user?.photoURL,
        "university": "국민대",
        "review": ""
      });

      Navigator.of(context).pushReplacementNamed('/setUniv');
    }
  }

  void _appleLogin() {
    print("apple");
  }

  @override
  Widget build(BuildContext context) {
    double _widgetWidth = MediaQuery.of(context).size.width * 0.85;

    Widget _kakaoButton = GestureDetector(
        onTap: () => _kakaoLogin(),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      offset: Offset(4.0, 4.0),
                      blurRadius: 10.0,
                      spreadRadius: 0)
                ]),
            child: Image.asset("image/kakaotalk_login.png", height: 60)));

    Widget _facebookButton = GestureDetector(
        onTap: () => _facebookLogin(),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      offset: Offset(4.0, 4.0),
                      blurRadius: 10.0,
                      spreadRadius: 0)
                ]),
            child: Image.asset("image/facebook_login.png", height: 60)));

    Widget _googleButton = GestureDetector(
        onTap: () => _googleLogin(context),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      offset: Offset(4.0, 4.0),
                      blurRadius: 10.0,
                      spreadRadius: 0)
                ]),
            child: Image.asset("image/google_login.png", height: 60)));

    Widget _appleButton = GestureDetector(
        onTap: () => _appleLogin(),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      offset: Offset(4.0, 4.0),
                      blurRadius: 10.0,
                      spreadRadius: 0)
                ]),
            child: Image.asset("image/apple_login.png", height: 60)));

    TextStyle textOrange = TextStyle(
        fontWeight: FontWeight.w500, fontSize: 22, color: DJMstyle().djm_color);
    TextStyle textBlack = TextStyle(
        fontWeight: FontWeight.w200,
        fontSize: 20,
        color: DJMstyle().djm_black_color);
    TextStyle textButtonStyle = TextStyle(
      color: DJMstyle().djm_gray_color,
      fontSize: 12,
    );

    Widget baseText = FittedBox(
        child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(children: [
              Text("대", style: textOrange),
              Text("학교 ", style: textBlack),
              Text("존", style: textOrange),
              Text("맛탱 ", style: textBlack),
              Text("맛", style: textOrange),
              Text("집들", style: textBlack)
            ])));

    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                    height: Platform.isAndroid
                        ? MediaQuery.of(context).size.height
                        : MediaQuery.of(context).size.height - 80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                            child: Container(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                              Text("대 존 맛",
                                  style: TextStyle(
                                      fontSize: 48, fontFamily: 'KotraHands')),
                              baseText
                            ]))),
                        Container(
                            width: _widgetWidth,
                            padding: EdgeInsets.all(4),
                            child: TextFormField(
                                controller: _idController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                    labelText: '이메일',
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.orange)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        borderSide: BorderSide(
                                            color: Colors.orange))))),
                        Container(
                            width: _widgetWidth,
                            padding: EdgeInsets.all(4),
                            child: TextFormField(
                                controller: _pwController,
                                obscureText: !_passwordVisible,
                                decoration: InputDecoration(
                                    labelText: '비밀번호',
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                          _passwordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Colors.grey),
                                      onPressed: () {
                                        setState(() {
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      },
                                    ),
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.orange)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        borderSide: BorderSide(
                                            color: Colors.orange))))),
                        Container(
                            width: _widgetWidth,
                            child: Row(children: [
                              SizedBox(
                                  width: 26,
                                  height: 26,
                                  child: Checkbox(
                                    value: _loginMaintain,
                                    onChanged: (value) => setState(() {
                                      _loginMaintain = value;
                                      print(value);
                                    }),
                                  )),
                              Text("  로그인 상태 유지",
                                  style: TextStyle(
                                      color: DJMstyle().djm_gray_color))
                            ])),
                        Padding(
                            padding: EdgeInsets.only(top: 4, bottom: 2),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    padding: EdgeInsets.zero,
                                    minimumSize: Size(_widgetWidth - 4, 40)),
                                onPressed: () {
                                  _login(context);
                                },
                                child: Text("로그인",
                                    style: TextStyle(color: Colors.white)))),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () => print("id finder"),
                                child: Text("아이디 찾기", style: textButtonStyle),
                              ),
                              Container(
                                  height: 20,
                                  child: VerticalDivider(
                                    thickness: 1,
                                  )),
                              TextButton(
                                onPressed: () => print("pw finder"),
                                child: Text("비밀번호 찾기", style: textButtonStyle),
                              ),
                              Container(
                                  height: 20,
                                  child: VerticalDivider(
                                    thickness: 1,
                                  )),
                              TextButton(
                                onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            EnrollEmailWidget()))),
                                child: Text("회원 가입", style: textButtonStyle),
                              )
                            ]),
                        Row(children: [
                          Expanded(
                              child: Divider(
                            thickness: 1,
                            color: DJMstyle().djm_gray_color,
                          )),
                          Padding(
                              padding: EdgeInsets.only(right: 4, left: 4),
                              child: Text("간편 로그인",
                                  style: TextStyle(
                                      color: DJMstyle().djm_gray_color,
                                      fontWeight: FontWeight.bold))),
                          Expanded(
                              child: Divider(
                            thickness: 1,
                            color: DJMstyle().djm_gray_color,
                          ))
                        ]),
                        Container(
                          child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Container(
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                    _kakaoButton,
                                    _facebookButton,
                                    _googleButton,
                                    _appleButton
                                  ]))),
                        )
                      ],
                    )))));
  }
}
