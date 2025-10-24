import 'package:flutter_test/flutter_test.dart';
import 'package:homecenter_flutter/features/products/data/datasource/local/shopping_cart_local_source.dart';
import 'package:homecenter_flutter/features/products/domain/entities/product.dart';
import 'package:homecenter_flutter/features/products/domain/entities/product_cart.dart';

void main() {
  late ShoppingCartLocalDatabase db;

  setUp(() {
    db = ShoppingCartLocalDatabase.memory();
  });

  tearDown(() async {
    await db.close();
  });

  Product buildProduct({
    String id = 'p1',
    String name = 'Prod 1',
    String price = '1000',
    List<String> media = const ['url1'],
  }) {
    return Product(
      productId: id,
      displayName: name,
      price: price,
      mediaUrls: media,
    );
  }

  ProductCart buildProductCart({
    String id = 'p1',
    String name = 'Prod 1',
    String price = '1000',
    List<String> media = const ['url1'],
    int quantity = 2,
  }) {
    return ProductCart(
      productId: id,
      displayName: name,
      price: price,
      mediaUrls: media,
      quantity: quantity,
    );
  }

  group('ShoppingCartLocalDatabase', () {
    test('getAllProductsOnShoppingCart returns empty initially', () async {
      final all = await db.getAllProductsOnShoppingCart();
      expect(all, isEmpty);
    });

    test('addProductToShoppingCart inserts with default quantity=1', () async {
      final product = buildProduct();
      await db.addProductToShoppingCart(product);

      final all = await db.getAllProductsOnShoppingCart();
      expect(all.length, 1);
      final item = all.first;
      expect(item.productId, product.productId);
      expect(item.displayName, product.displayName);
      expect(item.price, product.price);
      expect(item.mediaUrls, product.mediaUrls);
      expect(item.quantity, 1);
    });

    test('removeProductFromShoppingCart deletes the item', () async {
      final p1 = buildProduct(id: 'p1');
      final p2 = buildProduct(id: 'p2', name: 'Prod 2');
      await db.addProductToShoppingCart(p1);
      await db.addProductToShoppingCart(p2);

      await db.removeProductFromShoppingCart(p1);

      final all = await db.getAllProductsOnShoppingCart();
      expect(all.length, 1);
      expect(all.first.productId, 'p2');
    });

    test('clearShoppingCart removes all items', () async {
      await db.addProductToShoppingCart(buildProduct(id: 'p1'));
      await db.addProductToShoppingCart(buildProduct(id: 'p2'));

      await db.clearShoppingCart();

      final all = await db.getAllProductsOnShoppingCart();
      expect(all, isEmpty);
    });

    test('updateQualityProduct updates quantity for existing product', () async {
      final product = buildProduct(id: 'p3');
      await db.addProductToShoppingCart(product);

      final target = buildProductCart(id: 'p3', quantity: 5);
      await db.updateQualityProduct(target);

      final all = await db.getAllProductsOnShoppingCart();
      expect(all.length, 1);
      expect(all.first.quantity, 5);
    });
  });
}

