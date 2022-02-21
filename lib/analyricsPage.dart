import 'package:agritech/topBar.dart';
import 'package:ant_icons/ant_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import 'charts/gas_co/chart_gas_co.dart';
import 'charts/humidity/chart_humidity.dart';
import 'charts/photoresistance/chart_photoresistance.dart';
import 'charts/temperature/chart_temperature.dart';

class AnalyticsPage extends StatelessWidget {
  final commandsSnapshots = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    var currentWidth = MediaQuery.of(context).size.width;
    var extraLargeScreenGrid = currentWidth > 1536;
    var largeScreenGrid = currentWidth > 1366;
    var smallScreenGrid = currentWidth > 1201;
    var tabScreenGrid = currentWidth > 769;
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.topLeft,
      color: Colors.black12.withOpacity(0.03),
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          ListView(
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: 25.0, top: 90.0, right: 25.0, bottom: 12.5),
                child: new GridView.count(
                  crossAxisCount: extraLargeScreenGrid
                      ? 4
                      : tabScreenGrid
                          ? 2
                          : 1,
                  childAspectRatio: 3.5,
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 20.0,
                  padding: EdgeInsets.all(02.0),
                  shrinkWrap: true,
                  children: [
                    Container(
                        child: StreamBuilder<QuerySnapshot>(
                      stream: commandsSnapshots
                          .collection('commands')
                          .where('state', isEqualTo: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        return Container(
                          decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(20)),
                          height: 120.0,
                          padding: EdgeInsets.all(0.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(left: 15.0),
                                          child: Text(
                                            'Commande validés',
                                            style: TextStyle(
                                              fontSize: size.width * 0.02,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(left: 15.0),
                                          child: Text(
                                            snapshot.hasData
                                                ? '${snapshot.data!.size}'
                                                : '0',
                                            style: TextStyle(
                                              fontSize: 30.0,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 120.0,
                                height: 120.0,
                                child: Icon(
                                  AntIcons.dollar,
                                  size: 50.0,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )),
                    Container(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: commandsSnapshots
                            .collection('commands')
                            .where('state', isEqualTo: false)
                            .snapshots(),
                        builder: (context, snapshot) {
                          return Container(
                            decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(20)),
                            height: 120.0,
                            padding: EdgeInsets.all(0.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding:
                                                EdgeInsets.only(left: 15.0),
                                            child: Text(
                                              'Commandes non validés',
                                              style: TextStyle(
                                                fontSize: size.width * 0.02,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding:
                                                EdgeInsets.only(left: 15.0),
                                            child: Text(
                                              snapshot.hasData
                                                  ? '${snapshot.data!.size}'
                                                  : '0',
                                              style: TextStyle(
                                                fontSize: 30.0,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 120.0,
                                  height: 120.0,
                                  child: Icon(
                                    Ionicons.alert_circle,
                                    size: 50.0,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                        child: StreamBuilder<QuerySnapshot>(
                      stream:
                          commandsSnapshots.collection('products').snapshots(),
                      builder: (context, snapshot) {
                        return Container(
                          decoration: BoxDecoration(
                              color: Colors.pinkAccent.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(20)),
                          height: 120.0,
                          padding: EdgeInsets.all(0.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(left: 15.0),
                                          child: Text(
                                            'Mes produits',
                                            style: TextStyle(
                                              fontSize: 40.0,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(left: 15.0),
                                          child: Text(
                                            snapshot.hasData
                                                ? '${snapshot.data!.size}'
                                                : '0',
                                            style: TextStyle(
                                              fontSize: 30.0,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 120.0,
                                height: 120.0,
                                child: Icon(
                                  Ionicons.cube_outline,
                                  size: 50.0,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )),
                    Container(
                        child: StreamBuilder<QuerySnapshot>(
                      stream:
                          commandsSnapshots.collection('commands').snapshots(),
                      builder: (context, snapshot) {
                        return Container(
                          decoration: BoxDecoration(
                              color: Colors.blueAccent.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(20)),
                          height: 120.0,
                          padding: EdgeInsets.all(0.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(left: 15.0),
                                          child: Text(
                                            'Commandes',
                                            style: TextStyle(
                                              fontSize: 40.0,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(left: 15.0),
                                          child: Text(
                                            snapshot.hasData
                                                ? '${snapshot.data!.size}'
                                                : '0',
                                            style: TextStyle(
                                              fontSize: 30.0,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 120.0,
                                height: 120.0,
                                child: Icon(
                                  FeatherIcons.tag,
                                  size: 50.0,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: 25.0, top: 12.5, right: 25.0, bottom: 12.5),
                child: new GridView.count(
                  crossAxisCount: largeScreenGrid ? 2 : 1,
                  childAspectRatio: 1.8,
                  padding: const EdgeInsets.all(02.0),
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 20.0,
                  semanticChildCount: 2,
                  shrinkWrap: true,
                  children: [
                    Container(
                      child: Material(
                        elevation: 02.0,
                        borderRadius: BorderRadius.circular(03.0),
                        child: Container(
                          padding: EdgeInsets.all(25.0),
                          child: HumidityChart(),
                        ),
                      ),
                    ),
                    Container(
                      child: Material(
                        elevation: 02.0,
                        borderRadius: BorderRadius.circular(03.0),
                        child: Container(
                          padding: EdgeInsets.all(25.0),
                          child: GasCoChart(),
                        ),
                      ),
                    ),
                    Container(
                      child: Material(
                        elevation: 02.0,
                        borderRadius: BorderRadius.circular(03.0),
                        child: Container(
                          padding: EdgeInsets.all(25.0),
                          child: PhotoResistanceChart(),
                        ),
                      ),
                    ),
                    Container(
                      child: Material(
                        elevation: 02.0,
                        borderRadius: BorderRadius.circular(03.0),
                        child: Container(
                          padding: EdgeInsets.all(25.0),
                          child: TemperatureChart(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            height: 65.0,
            color: Colors.white,
            child: Material(
              elevation: 2.0,
              child: TopBar(),
            ),
          ),
        ],
      ),
    );
  }
}
