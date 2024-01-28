import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/utils/app_routes.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(
        product.name,
        style: const TextStyle(color: Colors.black),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.PRODUCT_FORM,
                  arguments: product,
                );
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text(
                      'Excluir Produto?',
                      style: TextStyle(color: Colors.black),
                    ),
                    content: const Text('Tem Certeza',
                        style: TextStyle(color: Colors.black)),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Não'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Provider.of<ProductList>(context, listen: false)
                              .removeProduct(product);
                        },
                        child: const Text('Sim'),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.redAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
