import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/visualization_bloc.dart';
import '../bloc/visualization_event.dart';
import '../bloc/visualization_state.dart';

class Visualization extends StatelessWidget {
  static String routeName = "visualization_screen";

  @override
  Widget build(BuildContext context) {
    context.read<VisualizationBloc>().add(FetchVisualizationData());
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.purpleAccent],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
          title: const Text("Visualization"),
        ),
      ),
      body: BlocBuilder<VisualizationBloc, VisualizationState>(
        builder: (context, state) {
          if (state is VisualizationLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is VisualizationLoaded) {
            double cityLiving = state.cityLiving;
            double ruralLiving = state.ruralLiving;

            return SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      "Population Distribution",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 300,
                      child: PieChart(
                        PieChartData(
                          sectionsSpace: 2,
                          centerSpaceRadius: 50,
                          startDegreeOffset: -90,
                          sections: [
                            PieChartSectionData(
                              value: cityLiving,
                              title: '${cityLiving.toStringAsFixed(0)}%',
                              color: Colors.lightBlueAccent,
                              radius: 100,
                              titleStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            PieChartSectionData(
                              value: ruralLiving,
                              title: '${ruralLiving.toStringAsFixed(0)}%',
                              color: Colors.pinkAccent,
                              radius: 100,
                              titleStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        swapAnimationDuration:
                            const Duration(milliseconds: 800),
                        swapAnimationCurve: Curves.easeInOut,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 20,
                      alignment: WrapAlignment.center,
                      children: [
                        _buildLegendItem(Colors.lightBlueAccent, "City Living"),
                        _buildLegendItem(Colors.pinkAccent, "Rural Living"),
                      ],
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            );
          } else if (state is VisualizationError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red, fontSize: 18),
              ),
            );
          }

          return const Center(child: Text("No Data Available"));
        },
      ),
    );
  }

  Widget _buildLegendItem(Color color, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
