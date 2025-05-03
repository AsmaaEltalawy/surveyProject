// survey_state.dart
import '../services/survey_model.dart';

abstract class SurveyState {}

class SurveyLoadingState extends SurveyState {}

class SurveyLoadedState extends SurveyState {
  final List<SurveyModel> surveyData;

  SurveyLoadedState(this.surveyData);
}

class SurveyErrorState extends SurveyState {
  final String errorMessage;

  SurveyErrorState(this.errorMessage);
}
