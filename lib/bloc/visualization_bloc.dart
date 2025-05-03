import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/survey_survices.dart';
import 'visualization_event.dart';
import 'visualization_state.dart';

class VisualizationBloc extends Bloc<VisualizationEvent, VisualizationState> {
  final SurveyService surveyService;

  VisualizationBloc(this.surveyService) : super(VisualizationInitial()) {
    on<FetchVisualizationData>(_onFetchVisualizationData);
  }

  Future<void> _onFetchVisualizationData(FetchVisualizationData event,
      Emitter<VisualizationState> emit) async {
    emit(VisualizationLoading()); // لما يبدأ تحميل البيانات

    try {
      final data = await surveyService.fetchCsvData();

      // احسب عدد الناس في المدينة والريف
      int male = data
          .where((survey) =>
      survey.gender.toLowerCase().trim() ==
          "male")
          .length;
      int female = data
          .where((survey) =>
      survey.gender.toLowerCase().trim() ==
          "female")
          .length;
      int house2_4 = data
          .where((survey) =>
      survey.householdSize.toLowerCase().trim() ==
          "2-4 members")
          .length;
      int house5 = data
          .where((survey) =>
      survey.householdSize.toLowerCase().trim() ==
          "5+ members")
          .length;
      int alone = data
          .where((survey) =>
      survey.householdSize.toLowerCase().trim() ==
          "alone")
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

      int prefBigCity = data
          .where((survey) =>
      survey.preferredLivingArea.toLowerCase().trim() ==
          "in a big city")
          .length;

      int prefSmallCity = data
          .where((survey) =>
      survey.preferredLivingArea.toLowerCase().trim() ==
          "in a small city")
          .length;
            int notmatter = data
          .where((survey) =>
      survey.preferredLivingArea.toLowerCase().trim() ==
          "it doesn't matter")
          .length;
            int preRural = data
          .where((survey) =>
      survey.preferredLivingArea.toLowerCase().trim() ==
          "in rural")
          .length;




      int totalCount = cityLivingCount + ruralLivingCount;
      int PreferedtotalCount = prefBigCity + prefSmallCity + preRural + notmatter;


      double cityLivingPercentage =
      totalCount == 0 ? 0 : (cityLivingCount / totalCount) * 100;
      double ruralLivingPercentage =
      totalCount == 0 ? 0 : (ruralLivingCount / totalCount) * 100;
      double preferBigCityPercentage =
      totalCount == 0 ? 0 : (prefBigCity / PreferedtotalCount) * 100;
      double preferSmallCityPercentage =
      totalCount == 0 ? 0 : (prefSmallCity / PreferedtotalCount) * 100;
      double notPreferCityPercentage =
      totalCount == 0 ? 0 : (notmatter / PreferedtotalCount) * 100;
      double preferRuralCityPercentage =
      totalCount == 0 ? 0 : (preRural / PreferedtotalCount) * 100;


      emit(VisualizationLoaded(
        cityLiving: cityLivingPercentage,
        ruralLiving: ruralLivingPercentage,
        prefBigCity
        :preferBigCityPercentage,
        prefSmallCity
        :preferSmallCityPercentage ,
        notMatter: notPreferCityPercentage,
        preRural: preferRuralCityPercentage,
        male: male,
        female: female,
        house5: house5,
        house2_4: house2_4,
        alone: alone,
      ));
    } catch (e) {
      emit(VisualizationError("Error fetching data: $e"));
    }
  }
}