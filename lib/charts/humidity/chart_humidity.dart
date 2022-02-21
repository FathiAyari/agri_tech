import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

var snapshot = FirebaseFirestore.instance;

class HumidityChart extends StatefulWidget {
  const HumidityChart({Key? key}) : super(key: key);

  @override
  _ReusableComponentState createState() => _ReusableComponentState();
}

class _ReusableComponentState extends State<HumidityChart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: snapshot.collection('humidity').orderBy('date').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var test = snapshot.data!.docs.toList();
              List<Humidity> result = [];
              for (var test1 in test) {
                result.add(Humidity(
                    pourcentage: test1.get('pourcentage'),
                    date: (test1.get('date').toDate())));
              }
              return SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                tooltipBehavior: TooltipBehavior(enable: true),
                title: ChartTitle(text: " Courbe de l'humidité "),
                legend: Legend(isVisible: true),
                series: <ChartSeries<Humidity, String>>[
                  LineSeries<Humidity, String>(
                      dataSource: result,
                      xValueMapper: (Humidity humidity, _) =>
                          humidity.date.toString().split(" ")[0],
                      yValueMapper: (Humidity humidity, _) =>
                          humidity.pourcentage,
                      name: " Pourcentage de l'humidité",
                      dataLabelSettings: DataLabelSettings(isVisible: true)),
                ],
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}

class Humidity {
  final double pourcentage;
  final DateTime date;
  Humidity({required this.pourcentage, required this.date});
}
