part of 'plant_categories_bloc.dart';

abstract class PlantCategoriesState extends Equatable {
  const PlantCategoriesState();

  @override
  List<Object> get props => [];
}

class PlantCategoriesInitial extends PlantCategoriesState {
  const PlantCategoriesInitial();

  @override
  List<Object> get props => [];
}

class PlantCategoriesLoading extends PlantCategoriesState {
  const PlantCategoriesLoading();

  @override
  List<Object> get props => [];
}

class PlantCategoriesLoaded extends PlantCategoriesState {
  final List<PlantCategoryResponse> listCategories;
  const PlantCategoriesLoaded(this.listCategories);

  @override
  List<Object> get props => [listCategories];
}

class PlantCategoriesError extends PlantCategoriesState {
  const PlantCategoriesError(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
