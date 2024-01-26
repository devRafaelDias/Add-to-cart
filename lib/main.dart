import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/order_list.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/screens/cart_page.dart';
import 'package:shop/screens/orders_page.dart';
import 'package:shop/screens/product_datail_page.dart';
import 'package:shop/screens/products_overview_page.dart';
import 'package:shop/utils/app_routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductList()),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => OrderList()),
      ],
      child: MaterialApp(
        theme: theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(
            primary: Colors.purple,
            secondary: const Color.fromARGB(255, 208, 82, 82),
          ),
          textTheme: const TextTheme(
              titleSmall: TextStyle(
            fontFamily: 'Lato',
            fontSize: 16,
            color: Colors.white,
          )),
          appBarTheme: AppBarTheme(
              backgroundColor: Theme.of(context).primaryColor,
              titleTextStyle: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              )),
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          AppRoutes.HOME: (context) => const ProductOverViewPage(),
          AppRoutes.PRODUCT_DATAIL: (context) => const ProductDetailPage(),
          AppRoutes.CART: (context) => const CartPage(),
          AppRoutes.ORDERS: (context) => const OrdersPage(),
        },
      ),
    );
  }
}
