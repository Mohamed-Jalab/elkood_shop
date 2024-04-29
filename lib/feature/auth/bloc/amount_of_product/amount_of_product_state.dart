part of 'amount_of_product_bloc.dart';

@immutable
sealed class AmountOfProductState {}

final class AmountOfProductInitial extends AmountOfProductState {}

class ChangeAmountOfProductState extends AmountOfProductState {}