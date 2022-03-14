import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:djm/djm_style.dart';
import 'package:djm/mainGrid/mainGrid.dart';
import 'package:djm/shopinfo/shopInfoWidget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:djm/login/loginWidget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.orange),
        routes: {
          '/first': (BuildContext context) => LoginWidget(),
          '/second': (BuildContext context) => MainGridView(),
        },
        home: LoginWidget());
  }
}
