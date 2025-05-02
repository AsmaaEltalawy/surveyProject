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
    emit(VisualizationLoading()); // لما يبدأ تحميل البيانات

    try {
      final data = await surveyService.fetchCsvData();

      // احسب عدد الناس في المدينة والريف
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


      double cityLivingPercentage =
          totalCount == 0 ? 0 : (cityLivingCount / totalCount) * 100;
      double ruralLivingPercentage =
          totalCount == 0 ? 0 : (ruralLivingCount / totalCount) * 100;


      emit(VisualizationLoaded(
        cityLiving: cityLivingPercentage,
        ruralLiving: ruralLivingPercentage,
      ));
    } catch (e) {
      emit(VisualizationError("Error fetching data: $e"));
    }
  }
}
