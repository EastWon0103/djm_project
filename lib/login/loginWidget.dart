import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:djm/djm_style.dart';
import 'package:djm/mainGrid/mainGrid.dart';
import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _LoginWidget();
  }
}

class _LoginWidget extends State<LoginWidget> {
  late bool _passwordVisible;
  late var _loginMaintain;

  void initState() {
    _passwordVisible = false;
    _loginMaintain = false;
  }

  void _kakaoLogin() {
    print("kakaotalk");
  }

  void _facebookLogin() {
    print("facebook");
  }

  Future<void> _googleLogin() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    GoogleSignIn googleSignIn = GoogleSignIn();

    GoogleSignInAccount? account = await googleSignIn.signIn();
    GoogleSignInAuthentication? authentication = await account?.authentication;
  }

  void _appleLogin() {
    print("apple");
  }

  void _login(BuildContext context) {
    Navigator.of(context).pushReplacementNamed('/second');
    // Navigator.push(
    //     context, MaterialPageRoute(builder: ((context) => MainGridView())));
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
        onTap: () => _googleLogin(),
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
                                onPressed: () => print("user enroll"),
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
