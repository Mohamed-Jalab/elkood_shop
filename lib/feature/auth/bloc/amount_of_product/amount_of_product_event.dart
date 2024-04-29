part of 'amount_of_product_bloc.dart';

@immutable
sealed class AmountOfProductEvent {}

class IncreaseAmountOfProductEvent extends AmountOfProductEvent {}

class DecreaseAmountOfProductEvent extends AmountOfProductEvent {}
