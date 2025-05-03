import 'package:flutter/material.dart';
import 'package:surveypro/bloc/dashboard_bloc.dart';
import 'package:surveypro/modules/all_data_screen.dart';
import 'package:surveypro/modules/visualization.dart';

import 'dash_board_metric_card_view.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "home_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.purple],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
          title: SingleChildScrollView(
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Visualization.routeName);
                  },
                  icon: const Icon(Icons.pie_chart, color: Colors.white),
                ),
                const SizedBox(width: 8),
                const Text("SurveyPro"),
              ],
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, AllDataScreen.routesName);
                }, icon: const Icon(Icons.data_exploration,color: Colors.white,)),

          ],
        ),
      ),
      body: Column(
        children: [
          DashboardMetricsCards(),
        ],
      ),

    );
  }
}
