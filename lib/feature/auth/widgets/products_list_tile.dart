import 'package:flutter/material.dart';
import 'package:shop_app/feature/auth/screens/product_screen.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({super.key, required this.prodcuts});
  final List<dynamic> prodcuts;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ListView.separated(
      itemCount: prodcuts.length,
      separatorBuilder: (context, index) => const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 2),
        child: Divider(),
      ),
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProductScreen(
                    id: prodcuts[index]["id"] as int,
                    image: prodcuts[index]["image"],
                    title: prodcuts[index]["title"],
                    description: prodcuts[index]["description"],
                    price: prodcuts[index]["price"].toString())));
          },
          leading: SizedBox(
              width: width * 0.15,
              child: Hero(
                  tag: prodcuts[index]["image"],
                  child: Image(image: NetworkImage(prodcuts[index]["image"])))),
          title: Text(prodcuts[index]["title"]),
          subtitle: Text(prodcuts[index]["description"],
              style: const TextStyle(overflow: TextOverflow.ellipsis)),
          trailing: Text('${prodcuts[index]["price"].toString()} \$'),
        );
      },
    );
  }
}
