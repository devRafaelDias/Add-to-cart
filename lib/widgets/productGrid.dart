// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/widgets/product_grid_item.dart';

// ignore: must_be_immutable
class ProductGrid extends StatelessWidget {
  bool showFavoriteOnly;
  ProductGrid(this.showFavoriteOnly, {super.key});
  @override
  Widget build(BuildContext context) {

    
    final provider = Provider.of<ProductList>(context);
    final List<Product> loadedProducts = showFavoriteOnly ? provider.favoriteItems: provider.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: loadedProducts.length,
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: loadedProducts[index],
        child: const ProductGridItem(),
      ),
    );
  }
}
