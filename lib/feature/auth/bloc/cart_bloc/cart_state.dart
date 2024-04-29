part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

class CartLoadingState extends CartState {}

class CartSuccessState extends CartState {
  final Map<String, dynamic> cartProducts;

  CartSuccessState({required this.cartProducts});
}

class CartFailureState extends CartState {
  final String message;

  CartFailureState({required this.message});

}
