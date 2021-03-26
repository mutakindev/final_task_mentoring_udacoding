part of 'plants_bloc.dart';

abstract class PlantsState extends Equatable {
  const PlantsState();

  @override
  List<Object> get props => [];
}

class PlantsInitial extends PlantsState {
  const PlantsInitial();

  @override
  List<Object> get props => [];
}

class PlantsLoading extends PlantsState {
  const PlantsLoading();

  @override
  List<Object> get props => [];
}

class PlantsLoaded extends PlantsState {
  final List<PlantsResponse> listPlants;
  const PlantsLoaded(this.listPlants);

  @override
  List<Object> get props => [listPlants];
}

class PlantsError extends PlantsState {
  const PlantsError(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
