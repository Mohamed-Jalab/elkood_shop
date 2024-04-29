part of 'products_bloc.dart';

abstract class ProductsState {}

class ProductsInitialState extends ProductsState {}

class ProductsLoadingState extends ProductsState {}

class ProductsSuccessState extends ProductsState {
  final List<dynamic> products;

  ProductsSuccessState({required this.products});
}

class ProductsFailureState extends ProductsState {
  final String message;

  ProductsFailureState({required this.message});
}
