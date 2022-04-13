import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test1/models/cart.dart';

class MyCart extends StatelessWidget {
  const MyCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(child: _CartList()),
            _CartTotal(),
          ],
        ),
      ),
    );
  }
}

class _CartList extends StatelessWidget {
  const _CartList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<CartModel>();

    return ListView.builder(
        itemCount: cart.items.length,
        itemBuilder: (context, index) => ListTile(
              leading: Icon(Icons.done),
              trailing: IconButton(
                icon: Icon(Icons.remove_circle_outline),
                onPressed: () {
                  cart.remove(cart.items[index]);
                },
              ),
              title: Text(
                cart.items[index].name,
              ),
            ));
  }
}

class _CartTotal extends StatelessWidget {
  const _CartTotal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Consumer<CartModel>(
            builder: (context, cart, child) => Text('\$${cart.totalPrice}'),
          ),
          TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Buying not supported yet')));
              },
              child: Text('BUY'))
        ],
      ),
    );
  }
}
