import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:parawisata_mutakin/model/plant_model.dart';
import 'package:parawisata_mutakin/network/services.dart';

part 'plants_event.dart';
part 'plants_state.dart';

class PlantsBloc extends Bloc<PlantsEvent, PlantsState> {
  PlantsBloc() : super(PlantsInitial());
  final ApiServices apiServices = ApiServices();

  @override
  Stream<PlantsState> mapEventToState(
    PlantsEvent event,
  ) async* {
    if (event is GetPlantsList) {
      try {
        yield PlantsLoading();
        final mList = await apiServices.getDataPlants();
        yield PlantsLoaded(mList);
      } catch (e) {
        yield PlantsError(e.toString());
      }
    }
  }
}
