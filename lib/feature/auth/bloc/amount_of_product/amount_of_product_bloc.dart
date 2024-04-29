import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'amount_of_product_event.dart';
part 'amount_of_product_state.dart';

class AmountOfProductBloc
    extends Bloc<AmountOfProductEvent, AmountOfProductState> {
  int amount = 1;
  AmountOfProductBloc() : super(AmountOfProductInitial()) {
    on<AmountOfProductEvent>((event, emit) {
      if (event is IncreaseAmountOfProductEvent) {
        amount++;
        emit(ChangeAmountOfProductState());
      } else if (event is DecreaseAmountOfProductEvent) {
        if (amount > 1) {
          amount--;
        }
        emit(ChangeAmountOfProductState());
      }
    });
  }
}
