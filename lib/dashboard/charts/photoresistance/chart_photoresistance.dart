import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

var snapshot = FirebaseFirestore.instance;

class PhotoResistanceChart extends StatefulWidget {
  const PhotoResistanceChart({Key? key}) : super(key: key);

  @override
  _PhotoResistanceChartState createState() => _PhotoResistanceChartState();
}

class _PhotoResistanceChartState extends State<PhotoResistanceChart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: snapshot
              .collection('photoresistance')
              .orderBy('date')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var test = snapshot.data!.docs.toList();
              List<PhotoResistance> result = [];
              for (var test1 in test) {
                result.add(PhotoResistance(
                    value: test1.get('value'),
                    date: (test1.get('date').toDate())));
              }
              return SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                tooltipBehavior: TooltipBehavior(enable: true),
                title: ChartTitle(text: " courbe de PhotoResistance "),
                legend: Legend(isVisible: true),
                series: <ChartSeries<PhotoResistance, String>>[
                  LineSeries<PhotoResistance, String>(
                      dataSource: result,
                      xValueMapper: (PhotoResistance photoResistance, _) =>
                          photoResistance.date.toString().split(" ")[0],
                      yValueMapper: (PhotoResistance photoResistance, _) =>
                          photoResistance.value,
                      name: "Valeur de Photoresistance",
                      animationDelay: 50,
                      dataLabelSettings: DataLabelSettings(isVisible: true)),
                ],
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}

class PhotoResistance {
  final double value;
  final DateTime date;
  PhotoResistance({required this.value, required this.date});
}
