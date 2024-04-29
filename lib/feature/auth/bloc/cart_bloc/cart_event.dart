part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class AddProductsCartEvent extends CartEvent {
}
