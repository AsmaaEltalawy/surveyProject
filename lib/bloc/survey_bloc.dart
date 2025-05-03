// survey_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:surveypro/bloc/survey_event.dart';
import 'package:surveypro/bloc/survey_state.dart';
import 'package:surveypro/services/survey_model.dart';
import 'package:surveypro/services/survey_survices.dart';

class SurveyBloc extends Bloc<SurveyEvent, SurveyState> {
  final SurveyService _surveyService;

  SurveyBloc(this._surveyService) : super(SurveyLoadingState()) {
    on<FetchSurveyDataEvent>(_onFetchSurveyData);
  }

  Future<void> _onFetchSurveyData(FetchSurveyDataEvent event, Emitter<SurveyState> emit) async {
    try {
      final surveyData = await _surveyService.fetchCsvData();
      emit(SurveyLoadedState(surveyData));
    } catch (e) {
      emit(SurveyErrorState(e.toString()));
    }
  }
}
