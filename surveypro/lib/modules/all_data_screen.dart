import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surveypro/services/survey_survices.dart';

import '../bloc/survey_bloc.dart';
import '../bloc/survey_event.dart';
import '../bloc/survey_state.dart';

class AllDataScreen extends StatelessWidget {
  static String routesName = "AllData";

  const AllDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Survey Data'),
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
      ),
      body: BlocProvider(
        create: (context) =>
            SurveyBloc(SurveyService())..add(FetchSurveyDataEvent()),
        child: const SurveyDataView(),
      ),
    );
  }
}

class SurveyDataView extends StatelessWidget {
  const SurveyDataView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SurveyBloc, SurveyState>(
      builder: (context, state) {
        if (state is SurveyLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SurveyErrorState) {
          return Center(child: Text(state.errorMessage));
        } else if (state is SurveyLoadedState) {
          final surveyData = state.surveyData;

          if (surveyData.isEmpty) {
            return const Center(child: Text("No Data Available"));
          }

          return Container(
            color: Colors.grey[100],
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: Colors.deepPurple, width: 2),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.all(12),
                      child: DataTable(
                        columnSpacing: 16,
                        headingRowColor: WidgetStateColor.resolveWith(
                            (states) => Colors.deepPurple.shade200),
                        headingTextStyle: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        columns: const [
                          DataColumn(label: Text('Gender')),
                          DataColumn(label: Text('Current Living Area')),
                          DataColumn(label: Text('Household Size')),
                          DataColumn(label: Text('Main Reason')),
                          DataColumn(label: Text('Cost of Living')),
                          DataColumn(label: Text('Lifestyle Change')),
                          DataColumn(label: Text('Reason Not to Move')),
                          DataColumn(label: Text('Preferred Area')),
                          DataColumn(label: Text('Pref Reason 1')),
                          DataColumn(label: Text('Pref Reason 2')),
                          DataColumn(label: Text('Social Connections')),
                          DataColumn(label: Text('Feeling')),
                          DataColumn(label: Text('Safety')),
                          DataColumn(label: Text('Basic Services')),
                          DataColumn(label: Text('Service Quality')),
                          DataColumn(label: Text('Accessibility')),
                          DataColumn(label: Text('Healthcare Access')),
                          DataColumn(label: Text('Healthcare Reliability')),
                          DataColumn(label: Text('Healthcare Availability')),
                          DataColumn(label: Text('Last Moved')),
                          DataColumn(label: Text('Considering Move')),
                          DataColumn(label: Text('Move Reason')),
                          DataColumn(label: Text('Expected Change')),
                          DataColumn(label: Text('What Moved You')),
                          DataColumn(label: Text('Post Move Difficulties')),
                          DataColumn(label: Text('Social Life')),
                          DataColumn(label: Text('Local Conditions')),
                          DataColumn(label: Text('Future Location')),
                          DataColumn(label: Text('Stay Improvements')),
                          DataColumn(label: Text('Quality of Life')),
                          DataColumn(label: Text('Advantage 1')),
                          DataColumn(label: Text('Advantage 2')),
                          DataColumn(label: Text('Advantage 3')),
                          DataColumn(label: Text('Satisfaction')),
                          DataColumn(label: Text('Comments')),
                        ],
                        rows: surveyData.asMap().entries.map((entry) {
                          int index = entry.key;
                          final dataModel = entry.value;

                          return DataRow(
                            color: WidgetStateColor.resolveWith(
                                (Set<WidgetState> states) => index % 2 == 0
                                    ? Colors.grey.shade200
                                    : Colors.white),
                            cells: [
                              DataCell(Text(dataModel.gender)),
                              DataCell(Text(dataModel.currentLivingAreaType)),
                              DataCell(Text(dataModel.householdSize)),
                              DataCell(Text(dataModel.mainReasonForLiving)),
                              DataCell(Text(dataModel.costOfLivingChange)),
                              DataCell(Text(dataModel.lifestyleChange)),
                              DataCell(Text(dataModel.reasonNotToMove)),
                              DataCell(Text(dataModel.preferredLivingArea)),
                              DataCell(Text(dataModel.reasonForPreference1)),
                              DataCell(Text(dataModel.reasonForPreference2)),
                              DataCell(
                                  Text(dataModel.numberOfSocialConnections)),
                              DataCell(Text(dataModel.generalFeeling)),
                              DataCell(Text(dataModel.safetyFeeling)),
                              DataCell(Text(dataModel.accessToBasicServices)),
                              DataCell(Text(dataModel.basicServiceQuality)),
                              DataCell(Text(dataModel.serviceAccessibility)),
                              DataCell(Text(dataModel.accessToHealthcare)),
                              DataCell(Text(dataModel.healthcareReliability)),
                              DataCell(Text(dataModel.healthcareAvailability)),
                              DataCell(Text(dataModel.lastMoved)),
                              DataCell(Text(dataModel.consideringMoving)),
                              DataCell(Text(dataModel.reasonForMoving)),
                              DataCell(Text(dataModel.expectedChangeIfMoved)),
                              DataCell(Text(dataModel.whatMadeYouMove)),
                              DataCell(Text(dataModel.difficultiesAfterMoving)),
                              DataCell(Text(dataModel.socialLifeChange)),
                              DataCell(Text(dataModel.localConditionsChange)),
                              DataCell(Text(dataModel.preferredFutureLocation)),
                              DataCell(
                                  Text(dataModel.stayLongTermImprovements)),
                              DataCell(
                                  Text(dataModel.qualityOfLifeImprovement)),
                              DataCell(Text(dataModel.biggestAdvantage1)),
                              DataCell(Text(dataModel.biggestAdvantage2)),
                              DataCell(Text(dataModel.biggestAdvantage3)),
                              DataCell(Text(dataModel.satisfactionRating)),
                              DataCell(Text(dataModel.otherComments)),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
