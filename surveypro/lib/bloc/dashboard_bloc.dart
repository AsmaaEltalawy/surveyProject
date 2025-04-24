import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/stat_card_model.dart';
import '../services/survey_model.dart';
import '../services/survey_survices.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final SurveyService surveyService = SurveyService();

  DashboardBloc() : super(DashboardInitial()) {
    on<LoadDashboardData>(_onLoadDashboardData);
  }

  Future<void> _onLoadDashboardData(
      LoadDashboardData event, Emitter<DashboardState> emit) async {
    emit(DashboardLoading());

    try {
      await Future.delayed(Duration(seconds: 2));

      List<SurveyModel> surveys = await surveyService.fetchCsvData();
      //
      // int cityLivingCount = surveys
      //     .where((survey) => survey.currentLivingAreaType.toLowerCase() == "city")
      //     .length;
      //
      // int ruralLivingCount = surveys
      //     .where((survey) => survey.currentLivingAreaType.toLowerCase() == "rural")
      //     .length;
      //
      // int totalCount = cityLivingCount + ruralLivingCount;
      //
      // double cityLivingPercentage = totalCount == 0 ? 0 : (cityLivingCount / totalCount) * 100;
      // double ruralLivingPercentage = totalCount == 0 ? 0 : (ruralLivingCount / totalCount) * 100;

      if (surveys.isEmpty) {
        emit(DashboardError("No survey data available."));
        return;
      }
      List<StatCardsModel> cards = [
        StatCardsModel(
            description: "Total Responses",
            icon: const Icon(Icons.people, color: Colors.white, size: 30),
            iconColor: Colors.blueAccent,
            result: surveys.length),
        StatCardsModel(
            description: "Completion Rate",
            icon: const Icon(Icons.check_circle, color: Colors.white, size: 30),
            iconColor: Colors.greenAccent,
            result: calculateCompletionRate(surveys)),
        StatCardsModel(
            description: "Avg. Response Time",
            icon: const Icon(Icons.timer, color: Colors.white, size: 30),
            iconColor: Colors.purpleAccent,
            result: calculateAvgResponseTime(surveys)),
        StatCardsModel(
            description: "Engagement Score",
            icon: const Icon(Icons.brightness_auto,
                color: Colors.white, size: 30),
            iconColor: Colors.pinkAccent,
            result: "8.4/10"),

      ];

      emit(DashboardLoaded(
        cards: cards,
      ));
    } catch (e) {
      emit(DashboardError("failed to load data"));
    }
  }

  String calculateAvgResponseTime(List<SurveyModel> surveys) {
    double totalTime = surveys.fold(0.0, (sum, survey) {
      double time = double.tryParse(survey.satisfactionRating) ?? 0.0;
      return sum + time;
    });

    double avgTime = totalTime / surveys.length;
    return "${avgTime.toStringAsFixed(1)} min";
  }

  String calculateCompletionRate(List<SurveyModel> surveys) {
    int completedResponses =
        surveys.where((survey) => survey.satisfactionRating.isNotEmpty).length;
    return '${(completedResponses / surveys.length * 100).toStringAsFixed(2)}%';
  }
}
