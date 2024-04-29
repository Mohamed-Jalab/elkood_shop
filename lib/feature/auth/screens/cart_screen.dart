import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/constants.dart';
import 'package:shop_app/feature/auth/bloc/cart_bloc/cart_bloc.dart';
import 'package:toast/toast.dart';

import '../widgets/custom_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint(cartProducts.toString());
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: BlocProvider<CartBloc>(
          create: (context) => CartBloc()..add(AddProductsCartEvent()),
          child: BlocConsumer<CartBloc, CartState>(listener: (context, state) {
            if (state is CartFailureState) {
              ToastContext().init(context);
              Toast.show(state.message);
            }
          }, builder: (context, state) {
            CartBloc bloc = BlocProvider.of(context);
            if (state is CartSuccessState) {
              return cartProductsDetails.isEmpty
                  ? const Center(child: Text('There is no products'))
                  : Stack(
                      children: [
                        
                        ListView.separated(
                            itemCount: cartProducts.length,
                            separatorBuilder: (context, index) => const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 2),
                                  child: Divider(),
                                ),
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: SizedBox(
                                    width: width * 0.15,
                                    child: Image(
                                        image: NetworkImage(
                                            cartProductsDetails[index]
                                                ['image']))),
                                title:
                                    Text(cartProductsDetails[index]['title']),
                                trailing: Text(cartProductsDetails[index]
                                        ['quantity']
                                    .toString()),
                              );
                            }),
                        Positioned(
                            bottom: 20,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: CustomButton(
                                currentWidth: width * 0.95,
                                backColor: primaryColor,
                                foreColor: Colors.white,
                                onTap: () {
                                  cartProducts.clear();
                                  cartProductsDetails.clear();
                                  bloc.add(AddProductsCartEvent());
                                },
                                title: 'Delete Cart',
                              ),
                            )),
                      ],
                    );
            } else if (state is CartLoadingState) {
              return const Center(
                  child: CircularProgressIndicator(color: primaryColor));
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
                        BlocProvider.of<CartBloc>(context)
                            .add(AddProductsCartEvent());
                      },
                    ),
                  ),
                ],
              ));
            }
          }),
        ),
      ),
    );
  }
}
