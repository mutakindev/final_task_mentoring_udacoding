part of 'categories_bloc.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object> get props => [];
}

class CategoriesInitial extends CategoriesState {
  const CategoriesInitial();

  @override
  List<Object> get props => [];
}

class CategoriesLoading extends CategoriesState {
  const CategoriesLoading();

  @override
  List<Object> get props => [];
}

class CategoriesLoaded extends CategoriesState {
  final List<CategoryResponse> listCategories;
  const CategoriesLoaded(this.listCategories);

  @override
  List<Object> get props => [listCategories];
}

class CategoriesError extends CategoriesState {
  const CategoriesError(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
