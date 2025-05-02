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
  final int male;
  final int female;
  final int house5;
  final int house2_4;
  final int alone;
  final double prefBigCity;
  final double prefSmallCity;
  final double notMatter;
  final double preRural;

  VisualizationLoaded({
    required this.prefBigCity,
    required this.prefSmallCity,
    required this.notMatter,
    required this.preRural,
    required this.cityLiving,
    required this.ruralLiving,
    required this.male,
    required this.female,
    required this.house5,
    required this.house2_4,
    required this.alone,
  });

  @override
  List<Object?> get props =>
      [cityLiving, ruralLiving, male, female, house5, house2_4, alone];
}

class VisualizationError extends VisualizationState {
  final String message;

  VisualizationError(this.message);

  @override
  List<Object?> get props => [message];
}
