import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:djm/mainGrid.dart/mainGrid.dart';
import 'package:djm/shopinfo/shopInfoWidget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

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
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainGridView());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Center(
      child: OutlinedButton(
          onPressed: () async {
            final f = FirebaseFirestore.instance;
            await f.collection('PROFILE').doc('abc').set({'thisid': 'test'});
            print("ok");
          },
          child: Text("보내기", style: TextStyle(color: Colors.black))),
    )));
  }
}
