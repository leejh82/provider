import 'package:flutter/cupertino.dart';
import 'package:test1/models/catalog.dart';

class CartModel extends ChangeNotifier{
  late CatalogModel _catalog;

  CatalogModel get catalog => _catalog;

  final List<int> _itemIds = [];

  set catalog(CatalogModel newCatalog) {
    _catalog = newCatalog;
    notifyListeners();
  }

  List<Item> get items => _itemIds.map((id) => _catalog.getById(id)).toList();

  int get totalPrice =>
      items.fold(0, (total, current) => total + current.price);

  void add(Item item) {
    _itemIds.add(item.id);
    notifyListeners();
  }

  void remove(Item item) {
    _itemIds.remove(item.id);
    notifyListeners();
  }

}