import '../models/stat_card_model.dart';

abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}
class DashboardLoaded extends DashboardState {
  final List<StatCardsModel> cards;

  DashboardLoaded({
    required this.cards,
  });
}




class DashboardError extends DashboardState {
  final String message;
  DashboardError(this.message);
}