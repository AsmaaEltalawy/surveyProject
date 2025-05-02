import 'package:equatable/equatable.dart';

abstract class VisualizationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class VisualizationInitial extends VisualizationState {}

class VisualizationLoading extends VisualizationState {}

class VisualizationLoaded extends VisualizationState {
  final double cityLiving;
  final double ruralLiving;

  VisualizationLoaded({required this.cityLiving, required this.ruralLiving});

  @override
  List<Object?> get props => [cityLiving, ruralLiving];
}

class VisualizationError extends VisualizationState {
  final String message;

  VisualizationError(this.message);

  @override
  List<Object?> get props => [message];
}
