import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:surveypro/widget/cards_style.dart';
import '../bloc/dashboard_bloc.dart';
import '../bloc/dashboard_state.dart';

class DashboardMetricsCards extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DashboardLoaded) {
            return GridView.builder(
              padding: EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 30,
                crossAxisSpacing: 20,
                childAspectRatio: 9 / 11,
              ),
              itemBuilder: (context, index) => CardsStyle(state.cards[index]),
              itemCount: state.cards.length,
            );
          } else if (state is DashboardError) {
            return Center(child: Text(state.message, style: const TextStyle(color: Colors.red, fontSize: 18)));
          }
          return const Center(child: Text("No Data Available"));
        },
      ),
    );
  }
}
