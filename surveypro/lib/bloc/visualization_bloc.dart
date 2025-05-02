import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/survey_survices.dart';
import 'visualization_event.dart';
import 'visualization_state.dart';

class VisualizationBloc extends Bloc<VisualizationEvent, VisualizationState> {
  final SurveyService surveyService;

  VisualizationBloc(this.surveyService) : super(VisualizationInitial()) {
    on<FetchVisualizationData>(_onFetchVisualizationData);
  }

  Future<void> _onFetchVisualizationData(
      FetchVisualizationData event, Emitter<VisualizationState> emit) async {
    emit(VisualizationLoading());

    try {
      final data = await surveyService.fetchCsvData();
      int prefSmallCity = data
          .where((survey) =>
              survey.preferredLivingArea.toLowerCase().trim() ==
              "in a small city")
          .length;
      int prefBigCity = data
          .where((survey) =>
              survey.preferredLivingArea.toLowerCase().trim() ==
              "in a big city")
          .length;

      int notMatter = data
          .where((survey) =>
              survey.preferredLivingArea.toLowerCase().trim() ==
              "doesn't matter")
          .length;
      int preRural = data
          .where((survey) =>
              survey.preferredLivingArea.toLowerCase().trim() == "in rural")
          .length;

      int house2_4 = data
          .where((survey) =>
              survey.householdSize.toLowerCase().trim() == "2-4 members")
          .length;

      int alone = data
          .where(
              (survey) => survey.householdSize.toLowerCase().trim() == "alone")
          .length;

      int house5 = data
          .where((survey) =>
              survey.householdSize.toLowerCase().trim() == "5+ members")
          .length;
      int femaleCount = data
          .where((survey) => survey.gender.toLowerCase().trim() == "female")
          .length;

      int maleCount = data
          .where((survey) => survey.gender.toLowerCase().trim() == "male")
          .length;

      int cityLivingCount = data
          .where((survey) =>
              survey.currentLivingAreaType.toLowerCase().trim() ==
              "in a big city")
          .length;

      int ruralLivingCount = data
          .where((survey) =>
              survey.currentLivingAreaType.toLowerCase().trim() ==
              "in a rural area")
          .length;

      int totalCount = cityLivingCount + ruralLivingCount;
      int totalCountOfPre = prefSmallCity + prefBigCity + preRural + notMatter;

      double prefSmallCityPercentage =
          totalCount == 0 ? 0 : (prefSmallCity / totalCountOfPre) * 100;

      double prefBigCityPercentage =
          totalCount == 0 ? 0 : (prefBigCity / totalCountOfPre) * 100;

      double preRuralPercentage =
          totalCount == 0 ? 0 : (preRural / totalCountOfPre) * 100;

      double notMatterPercentage =
          totalCount == 0 ? 0 : (notMatter / totalCountOfPre) * 100;

      double cityLivingPercentage =
          totalCount == 0 ? 0 : (cityLivingCount / totalCount) * 100;
      double ruralLivingPercentage =
          totalCount == 0 ? 0 : (ruralLivingCount / totalCount) * 100;

      emit(VisualizationLoaded(
        cityLiving: cityLivingPercentage,
        ruralLiving: ruralLivingPercentage,
        male: maleCount,
        female: femaleCount,
        house5: house5,
        house2_4: house2_4,
        alone: alone,
        prefBigCity: prefBigCityPercentage,
        prefSmallCity: prefSmallCityPercentage,
        notMatter: notMatterPercentage,
        preRural: preRuralPercentage,
      ));
    } catch (e) {
      emit(VisualizationError("Error fetching data: $e"));
    }
  }
}
