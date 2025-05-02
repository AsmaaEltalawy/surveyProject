import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartStyle extends StatelessWidget{
  double? firstResult;
double? secondResult;

  PieChartStyle({this.firstResult, this.secondResult});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.9,
      height: MediaQuery.of(context).size.height * 0.3,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: PieChart(
        swapAnimationCurve: Curves.easeInOutQuint,
        swapAnimationDuration: const Duration(milliseconds: 750),
        PieChartData(sections: [
          PieChartSectionData(
            value: firstResult,
            color: Colors.blue,
            // title: "20%",
          ),
          PieChartSectionData(
            value: secondResult,
            color: Colors.red,
            // title: "20%",
          ),
        ], sectionsSpace: 4, centerSpaceRadius: 60),
      ),
    );
  }

}