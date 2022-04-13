import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test1/models/cart.dart';
import 'package:test1/models/catalog.dart';

class MyCatalog extends StatelessWidget {
  const MyCatalog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catalog'),
        actions: [
          IconButton(
              onPressed: () => Navigator.pushNamed(context, '/cart'),
              icon: Icon(Icons.shopping_cart))
        ],
      ),
      body:CustomScrollView(
        slivers: [
          SliverList(delegate: SliverChildBuilderDelegate(
              (context, index) => _MyListItem(index))
          )
        ],
      ),
    );
  }
}

class _MyListItem extends StatelessWidget {
  final int index;

  const _MyListItem(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var item = context.select<CatalogModel, Item>(
        (catalog) => catalog.getByPosition(index),
    );

    return LimitedBox(
      maxHeight: 48,
      child: Row(
        children: [
          AspectRatio(aspectRatio: 1, child:Container(
            color: item.color,
          ),),
          Expanded(child: Text(item.name)),
          _AddButton(item: item)
        ],
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final Item item;

  const _AddButton({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isInCart = context.select<CartModel, bool>((cart) => cart.items.contains(item));
    return TextButton(
        onPressed: isInCart
          ? null
          : (){
            var cart = context.read<CartModel>();
            cart.add(item);
            },
        child: isInCart
        ? Icon(Icons.check)
        : Text('ADD'),
    );
  }
}
