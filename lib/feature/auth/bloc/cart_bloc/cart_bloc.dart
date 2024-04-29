import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../core/constants.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<AddProductsCartEvent>((event, emit) async {
      try {
        emit(CartLoadingState());
        String data = jsonEncode({
          "products": cartProducts
              .map((element) => {
                    "productId": element['productId'],
                    "quantity": element["quantity"]
                  })
              .toList()
        });
        debugPrint(data);
        http.Response res = await http.post(Uri.parse('$baseUrl$carts'),
            body:
                data);
        debugPrint(res.body);
        if (res.statusCode == 200) {
          debugPrint(res.body);
          String jsonData = res.body;
          Map<String, dynamic> json = jsonDecode(jsonData);
          debugPrint(jsonData);
          emit(CartSuccessState(cartProducts: json));
          // debugPrint(dataList.toString());
        } else {
          emit(CartFailureState(message: 'Bad Request'));
        }
      } catch (e) {
        debugPrint(e.toString());
        throw Exception(e);
        // emit(CartFailureState(message: 'Check your Internet connection'));
      }
    });
  }
}
