part of 'products_bloc.dart';

abstract class ProductsEvent {}

class ProductsGetAllEvent extends ProductsEvent {
  final bool isSearch;
  final String? search;
  ProductsGetAllEvent({this.search, required this.isSearch});
}

class ProductsSearchEvent extends ProductsEvent {
  final String search;
  final List<dynamic> products;
  ProductsSearchEvent({required this.products, required this.search});
}
