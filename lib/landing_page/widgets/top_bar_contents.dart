import 'package:agritech/dashboard/Services/check_login.dart';
import 'package:agritech/dashboard/home_page/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import 'auth_dialog.dart';

class TopBarContents extends StatefulWidget {
  final double opacity;

  TopBarContents(this.opacity);

  @override
  _TopBarContentsState createState() => _TopBarContentsState();
}

class _TopBarContentsState extends State<TopBarContents> {
  final List _isHovering = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  final PrefService _prefService = PrefService();
  bool looged = false;
  void getToken() async {
    await _prefService.readCache("name").then((value) {
      if (value != null) {
        setState(() {
          looged = true;
        });
      } else {}
    });
  }

  @override
  void initState() {
    getToken();
    super.initState();
  }

  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return PreferredSize(
      preferredSize: Size(screenSize.width, 1000),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white70, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Agri Tech',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 3,
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    Get.toNamed("/products_screen");
                  },
                  child: Text(
                    "Produits",
                    style: TextStyle(color: Colors.white),
                  )),
              looged == true
                  ? ElevatedButton(
                      onPressed: () {
                        Get.to(() => MyHomePage());
                      },
                      child: Text(
                        "Acceder a votre tableau ",
                        style: TextStyle(color: Colors.white),
                      ))
                  : ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AuthDialog(),
                        );
                      },
                      child: Text(
                        "Connecter",
                        style: TextStyle(color: Colors.white),
                      )),
            ],
          ),
        ),
      ),
    );
  }
}
