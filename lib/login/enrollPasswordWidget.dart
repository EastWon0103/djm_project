import 'package:djm/login/enrollUnivWidget.dart';
import 'package:djm/providor/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../djm_style.dart';

class EnrollPasswordWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EnrollPasswordWidget();
  }
}

class _EnrollPasswordWidget extends State<EnrollPasswordWidget> {
  final _formPasswordKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  bool _passwordVisible = true;
  String _errorMsg = "";
  late UserProvider _userProvider;

  void _check_password() {
    String password = _passwordController.text;
    final validSpecial = RegExp(r'^[a-zA-Z0-9 ]+$');
    if (password.length < 8) {
      setState(() {
        _errorMsg = "비밀번호는 8자리 이상이어야 합니다.";
      });
    } else if (validSpecial.hasMatch(password)) {
      setState(() {
        _errorMsg = "비밀번호는 특수문자를 포함해야 합니다.";
      });
    } else {
      setState(() {
        _errorMsg = "";
      });
      _userProvider.password = password;
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => EnrollUnivWidget()));
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
                key: _formPasswordKey,
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
                            Text("비밀번호",
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: DJMstyle().djm_color)),
                            Text("를 입력하세요",
                                style: TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.bold)),
                          ])),
                      Container(
                          margin: EdgeInsets.only(left: 16, bottom: 160),
                          child: Text("비밀번호는 8자 이상, 특수문자를 포함해야합니다.",
                              style: TextStyle())),
                      Container(
                          margin: EdgeInsets.all(16),
                          child: TextFormField(
                              obscureText: _passwordVisible,
                              keyboardType: TextInputType.visiblePassword,
                              controller: _passwordController,
                              decoration: InputDecoration(
                                label: Text(_errorMsg,
                                    style: TextStyle(color: Colors.red)),
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
                              ))),
                      Align(
                          alignment: Alignment.center,
                          child: Container(
                              width: MediaQuery.of(context).size.width - 32,
                              child: ElevatedButton(
                                  onPressed: () => _check_password(),
                                  child: Text("비밀번호 입력완료",
                                      style: TextStyle(color: Colors.white)))))
                    ])))));
  }
}
