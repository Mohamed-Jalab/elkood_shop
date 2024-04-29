import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../../core/constants.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  TextEditingController searchController = TextEditingController();
  ProductsBloc() : super(ProductsInitialState()) {
    on<ProductsGetAllEvent>((event, emit) async {
      try {
        emit(ProductsLoadingState());
        http.Response res = await http.get(Uri.parse('$baseUrl$allProducts'));
        if (res.statusCode == 200) {
          String jsonData = res.body;
          List<dynamic> dataList = jsonDecode(jsonData);
          products = dataList;
          if (event.isSearch) {
            List<dynamic> pros = dataList
                .where((element) =>
                    (element['title'] as String).contains((event).search!))
                .toList();
            emit(ProductsSuccessState(products: pros));
            debugPrint(pros.toString());
          } else {
            emit(ProductsSuccessState(products: dataList));
            debugPrint(dataList.toString());
          }
        } else {
          emit(ProductsFailureState(message: 'Bad Request'));
        }
      } catch (e) {
        debugPrint(e.toString());
        emit(ProductsFailureState(message: 'Check your Internet connection'));
      }
    });

    on<ProductsSearchEvent>((event, emit) async {
      emit(ProductsLoadingState());
      List<dynamic> pros = (event)
          .products
          .where((element) =>
              (element['title'] as String).contains((event).search))
          .toList();
      debugPrint(pros.toString());
      debugPrint('=========== pros ===========');
    });
  }
}
