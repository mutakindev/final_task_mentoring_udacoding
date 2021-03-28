import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:parawisata_mutakin/model/plant_categories.dart';
import 'package:parawisata_mutakin/network/services.dart';

part 'plant_categories_event.dart';
part 'plant_categories_state.dart';

class PlantCategoriesBloc
    extends Bloc<PlantCategoriesEvent, PlantCategoriesState> {
  PlantCategoriesBloc() : super(PlantCategoriesInitial());

  final ApiServices apiServices = ApiServices();

  @override
  Stream<PlantCategoriesState> mapEventToState(
    PlantCategoriesEvent event,
  ) async* {
    if (event is GetPlantCategoriesList) {
      try {
        yield PlantCategoriesLoading();
        final mList = await apiServices.getPlacementCategories();
        yield PlantCategoriesLoaded(mList);
      } catch (e) {
        yield PlantCategoriesError(e.toString());
      }
    }
  }
}
