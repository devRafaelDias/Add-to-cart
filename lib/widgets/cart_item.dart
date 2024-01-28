import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  const CartItemWidget({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItem.id),
      onDismissed: (_) {
        Provider.of<Cart>(
          context,
          listen: false,
        ).RemoveItem(cartItem.productId);
      },
      confirmDismiss: (_) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Tem certeza?', style: TextStyle(color: Colors.black),),
            content: const Text('Quer remover o item do carrinho?',  style: TextStyle(color: Colors.black)),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
                child: const Text('Não'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
                child: const Text('Sim'),
              ),
            ],
          ),
        );
      },
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red[500],
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: ListTile(
          leading: CircleAvatar(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: FittedBox(
                child: Text(
                  '${cartItem.price}',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue[900],
                  ),
                ),
              ),
            ),
          ),
          title: Text(cartItem.name),
          subtitle: Text('Total: R\$ ${cartItem.price * cartItem.quantity}'),
          trailing: Text(
            '${cartItem.quantity}x',
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
