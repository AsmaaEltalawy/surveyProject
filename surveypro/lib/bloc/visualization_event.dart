import 'package:equatable/equatable.dart';

abstract class VisualizationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchVisualizationData extends VisualizationEvent {}
