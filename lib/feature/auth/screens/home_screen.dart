import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';

import '../../../core/constants.dart';
import '../bloc/products_bloc/products_bloc.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/products_list_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) =>
          ProductsBloc()..add(ProductsGetAllEvent(isSearch: false)),
      child: Scaffold(
        body: BlocConsumer<ProductsBloc, ProductsState>(
          listener: (context, state) {
            if (state is ProductsFailureState) {
              ToastContext().init(context);
              Toast.show(state.message);
            }
          },
          builder: (context, state) {
            debugPrint("==============builder==============");
            ProductsBloc bloc = BlocProvider.of<ProductsBloc>(context);
            if (state is ProductsSuccessState ||
                state is ProductsLoadingState) {
              return Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                    child: CustomTextField(
                      onChanged: (value) async {
                        bloc.add(ProductsGetAllEvent(
                            isSearch: true,
                            search: bloc.searchController.text));
                        debugPrint('onChanged: $value');
                      },
                      prefix: const Icon(Icons.search, color: Colors.grey),
                      keyboardType: TextInputType.name,
                      hintText: 'Search',
                      controller: bloc.searchController,
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  state is ProductsLoadingState
                      ? (const Padding(
                          padding: EdgeInsets.only(bottom: 16.0),
                          child:
                              CircularProgressIndicator(color: primaryColor)))
                      : ((state as ProductsSuccessState).products.isEmpty
                          ? const Expanded(
                              child: Padding(
                              padding: EdgeInsets.only(bottom: 16.0),
                              child: Center(child: Text('Not Found')),
                            ))
                          :
                          // SizedBox()
                          Expanded(
                              child: ProductsList(prodcuts: state.products))),
                ],
              );
            } else {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Failed, please try again'),
                  SizedBox(height: height * 0.02),
                  SizedBox(
                    width: 170,
                    child: CustomButton(
                      foreColor: Colors.white,
                      backColor: primaryColor,
                      title: 'Try again',
                      onTap: () {
                        BlocProvider.of<ProductsBloc>(context)
                            .add(ProductsGetAllEvent(isSearch: false));
                      },
                    ),
                  ),
                ],
              ));
            }
          },
        ),
      ),
    );
  }
}
