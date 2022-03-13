//import 'package:flutter/cupertino.dart';
import 'package:djm/djm_style.dart';
import 'package:flutter/material.dart';

class Menu {
  String image_path = "image/train_menu";
  String title = "순대국";
  String price = "8000";

  Menu(this.image_path, this.title, this.price);
}

class MenuWidget extends StatelessWidget {
  MenuWidget(this._menu);
  final Menu _menu;
  static const double _infoSectionWidth = 356;

  @override
  Widget build(BuildContext context) {
    double _menuMarginLeft =
        (MediaQuery.of(context).size.width - _infoSectionWidth) / 2;

    return Padding(
        padding: EdgeInsets.only(right: 12),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(_menu.image_path), fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(4.0, 4.0),
                          blurRadius: 4.0,
                          spreadRadius: 0)
                    ]),
              ),
              Container(
                  margin: EdgeInsets.only(top: 8),
                  child: Text(
                      _menu.title.length < 8
                          ? _menu.title
                          : _menu.title.substring(0, 7) + "...",
                      style:
                          TextStyle(color: Color(0xff303030), fontSize: 14))),
              Text(_menu.price + "원",
                  style: TextStyle(color: Color(0x66303030), fontSize: 12))
            ]));
  }
}

class MenuList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _marginLeft =
        MediaQuery.of(context).size.width * DJMstyle().perMarginLeft;

    Widget _menuTitle = Container(
        margin: EdgeInsets.only(left: _marginLeft, bottom: 8),
        child: Row(
          children: [
            Text(
              "대표 ",
              style: TextStyle(color: Color(0xff303030), fontSize: 18),
            ),
            Text(
              "메뉴",
              style: TextStyle(color: Color(0xffff7a00), fontSize: 18),
            )
          ],
        ));
    Menu _menu1 = Menu("image/train_menu.jpg", "순대국", "8000");

    Widget _menuWidget = MenuWidget(_menu1);

    Widget _menuList = Container(
        height: 180,
        child: ListView.builder(
            padding: EdgeInsets.only(left: _marginLeft),
            scrollDirection: Axis.horizontal,
            itemCount: 7,
            itemBuilder: (context, index) {
              return _menuWidget;
            }));
    return Column(
      children: [_menuTitle, _menuList],
    );
  }
}
