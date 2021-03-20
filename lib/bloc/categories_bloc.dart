import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:parawisata_mutakin/model/categories_model.dart';
import 'package:parawisata_mutakin/network/services.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(CategoriesInitial());

  final ApiServices apiServices = ApiServices();

  @override
  Stream<CategoriesState> mapEventToState(
    CategoriesEvent event,
  ) async* {
    if (event is GetCategoriesList) {
      try {
        yield CategoriesLoading();
        final mList = await apiServices.getDataCategories();
        yield CategoriesLoaded(mList);
      } catch (e) {
        yield CategoriesError(e.toString());
      }
    }
  }
}
