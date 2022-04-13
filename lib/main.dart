import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test1/models/cart.dart';
import 'package:test1/models/catalog.dart';
import 'package:test1/screens/cart.dart';
import 'package:test1/screens/catalog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => CatalogModel()),
        ChangeNotifierProxyProvider<CatalogModel, CartModel>(
            create: (context) => CartModel(),
            update: (context, catalog, cart){
              if(cart == null) throw ArgumentError.notNull('cart');
              cart.catalog = catalog;
              return cart;
            })
      ],
      child: MaterialApp(
        title: 'Provider Demo',
        initialRoute: '/',
        routes: {
          '/': (context) => const MyCatalog(),
          '/cart': (context) => const MyCart(),
        },
      ),
    );
  }
}
