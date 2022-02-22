import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

var snapshot = FirebaseFirestore.instance;

class GasCoChart extends StatefulWidget {
  const GasCoChart({Key? key}) : super(key: key);

  @override
  _GasCoChartState createState() => _GasCoChartState();
}

class _GasCoChartState extends State<GasCoChart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream:
              snapshot.collection('Carbonmonoxide').orderBy('date').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var test = snapshot.data!.docs.toList();
              List<Gas_Co> result = [];
              for (var test1 in test) {
                result.add(Gas_Co(
                    pourcentage: test1.get('pourcentage'),
                    date: (test1.get('date').toDate())));
              }
              return SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                tooltipBehavior: TooltipBehavior(enable: true),
                title: ChartTitle(text: " courbe de Monoxyde de carbone (CO) "),
                legend: Legend(isVisible: true),
                series: <ChartSeries<Gas_Co, String>>[
                  LineSeries<Gas_Co, String>(
                      dataSource: result,
                      xValueMapper: (Gas_Co gas_co, _) =>
                          gas_co.date.toString().split(" ")[0],
                      yValueMapper: (Gas_Co gas_co, _) => gas_co.pourcentage,
                      name: "Valeur de Co",
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

class Gas_Co {
  final double pourcentage;
  final DateTime date;
  Gas_Co({required this.pourcentage, required this.date});
}
