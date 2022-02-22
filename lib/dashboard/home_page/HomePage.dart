import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../analyricsPage.dart';
import '../sidenavbar.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Row(
            children: <Widget>[
              Container(
                child: SideNavBar(),
              ),
              Expanded(
                child: AnalyticsPage(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
