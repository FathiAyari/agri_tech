import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

var snapshot = FirebaseFirestore.instance;

class TemperatureChart extends StatefulWidget {
  const TemperatureChart({Key? key}) : super(key: key);

  @override
  _TemperatureChartState createState() => _TemperatureChartState();
}

class _TemperatureChartState extends State<TemperatureChart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream:
              snapshot.collection('temperature').orderBy('date').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var test = snapshot.data!.docs.toList();
              List<Temperature> result = [];
              for (var test1 in test) {
                result.add(Temperature(
                    degree: test1.get('degree'),
                    date: (test1.get('date').toDate())));
              }
              return SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                tooltipBehavior: TooltipBehavior(enable: true),
                title: ChartTitle(text: " courbe de température "),
                legend: Legend(isVisible: true),
                series: <ChartSeries<Temperature, String>>[
                  LineSeries<Temperature, String>(
                      dataSource: result,
                      xValueMapper: (Temperature temperature, _) =>
                          temperature.date.toString().split(" ")[0],
                      yValueMapper: (Temperature temperature, _) =>
                          temperature.degree,
                      name: "Température en Celsius",
                      dataLabelSettings: DataLabelSettings(isVisible: true)),
                ],
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}

class Temperature {
  final double degree;
  final DateTime date;
  Temperature({required this.degree, required this.date});
}
