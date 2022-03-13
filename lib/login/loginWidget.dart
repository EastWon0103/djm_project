import 'dart:io';

import 'package:djm/djm_style.dart';
import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _LoginWidget();
  }
}

class _LoginWidget extends State<LoginWidget> {
  late bool _passwordVisible;

  void initState() {
    _passwordVisible = false;
  }

  void _kakaoLogin() {
    print("kakaotalk");
  }

  void _facebookLogin() {
    print("facebook");
  }

  void _googleLogin() {
    print("google");
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
                        Expanded(child: Container(child: Text(""))),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.85,
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
                            width: MediaQuery.of(context).size.width * 0.85,
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
                        Padding(
                            padding: EdgeInsets.only(top: 32, bottom: 32),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    padding: EdgeInsets.zero,
                                    minimumSize: Size(_widgetWidth - 4, 40)),
                                onPressed: () {
                                  print("hi");
                                },
                                child: Text("로그인",
                                    style: TextStyle(color: Colors.white)))),
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
