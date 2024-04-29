import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/constants.dart';
import 'package:shop_app/feature/auth/widgets/custom_button.dart';

import '../bloc/amount_of_product/amount_of_product_bloc.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.price,
    required this.id,
  });
  final String image;
  final int id;
  final String title;
  final String description;
  final String price;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: width,
          height: height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.01),
                Hero(
                    tag: image,
                    child: Center(
                      child: Image(
                        image: NetworkImage(image),
                        height: height * 0.4,
                      ),
                    )),
                SizedBox(height: height * 0.02),
                Row(
                  children: [
                    SizedBox(
                      width: width * 0.7,
                      child: Text(title,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600)),
                    ),
                    const Spacer(),
                    Text('$price \$',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700)),
                  ],
                ),
                SizedBox(height: height * 0.02),
                Text(description,
                    style: const TextStyle(fontSize: 12, color: Colors.grey)),
                const Spacer(),
                BlocProvider<AmountOfProductBloc>(
                  create: (context) => AmountOfProductBloc(),
                  child: BlocBuilder<AmountOfProductBloc, AmountOfProductState>(
                      builder: (context, state) {
                    final bloc = BlocProvider.of<AmountOfProductBloc>(context);
                    return Row(
                      children: [
                        CustomButton(
                          currentWidth: width * 0.8,
                          foreColor: Colors.white,
                          backColor: primaryColor,
                          title: 'Add To Cart',
                          onTap: () {
                            cartProducts.add(
                                {'productId': id, 'quantity': bloc.amount});
                            cartProductsDetails.add({
                              'id': id,
                              'quantity': bloc.amount,
                              "title": title,
                              "image": image,
                            });

                            Navigator.of(context).pop();
                            showDialog(
                                context: context,
                                builder: (context) => const AlertDialog(
                                      title: Text('Added Successfully'),
                                    ));
                          },
                        ),
                        SizedBox(width: width * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              child: const Icon(Icons.remove, size: 16),
                              onTap: () {
                                bloc.add(DecreaseAmountOfProductEvent());
                              },
                            ),
                            SizedBox(width: width * 0.01),
                            Text(
                              bloc.amount.toString(),
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            SizedBox(width: width * 0.01),
                            InkWell(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              child: const Icon(Icons.add, size: 16),
                              onTap: () {
                                bloc.add(IncreaseAmountOfProductEvent());
                              },
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
                ),
                SizedBox(height: height * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
