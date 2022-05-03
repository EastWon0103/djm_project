import 'package:djm/djm_style.dart';
import 'package:flutter/material.dart';

class ReviewMainWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ReviewMainWidget();
  }
}

class _ReviewMainWidget extends State<ReviewMainWidget> {
  Future<dynamic> _test() async {
    return "string";
  }

  Widget _reviewItem() {
    return Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
              padding: EdgeInsets.all(12),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset("image/test_ramen.jpg",
                      width: 40, height: 40, fit: BoxFit.cover))),
          Padding(
              padding: EdgeInsets.all(12),
              child:
                  Column(children: [Text("test"), Text("test"), Text("test")]))
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("기차순대국", style: TextStyle(fontWeight: FontWeight.bold)),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: DJMstyle().djm_color,
              ),
              onPressed: () => Navigator.of(context).pop()),
        ),
        body: FutureBuilder(
            future: _test(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Text("this is not");
              } else if (snapshot.hasError) {
                return Text("this is error");
              } else {
                return ListView.separated(
                    separatorBuilder: (context, index) => const Divider(
                          color: Colors.grey,
                          height: 4,
                        ),
                    itemCount: 7,
                    itemBuilder: (context, index) => _reviewItem());
              }
            }));
  }
}
