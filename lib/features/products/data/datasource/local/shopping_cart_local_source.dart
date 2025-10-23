
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:homecenter_flutter/features/products/domain/entities/product_cart.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

import 'package:homecenter_flutter/features/products/data/models/product_cart_db.dart';
import 'package:homecenter_flutter/features/products/domain/entities/product.dart';

part 'shopping_cart_local_source.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'shopping_cart.db'));

    // Make sure sqlite3 is available for Flutter apps
    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [ProductCartItem])
class ShoppingCartLocalDatabase extends _$ShoppingCartLocalDatabase {
  ShoppingCartLocalDatabase() : super(_openConnection());

  ShoppingCartLocalDatabase.memory(): super(NativeDatabase.memory());

  @override
  int get schemaVersion => 1;

  /// Query to get all products from the shopping cart
  Future<List<ProductCart>> getAllProductsOnShoppingCart() async {
    try {
        final query = select(productCartItem);
        final results = await query.get(); 
        return results.map((data) => ProductCart(
          displayName: data.displayName,
          productId: data.productId,
          price: data.price,
          mediaUrls: data.mediaUrls,
          quantity: data.quantity,
          )
          ).toList();
      } catch (e) {
        rethrow;
      }
  }

  /// Query to add a product to the shopping cart
  Future<void> addProductToShoppingCart(Product product) async {
    try {
      await into(productCartItem).insert(
        ProductCartItemCompanion.insert(
          productId: product.productId,
          displayName: product.displayName,
          price: product.price,
          mediaUrls: product.mediaUrls,
          quantity: 1,
        )
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Query to remove a product from the shopping cart
  Future<void> removeProductFromShoppingCart(Product product) async {
    try {
      await (delete(productCartItem)..where(
        (productCartItem) =>
            productCartItem.productId.equals(product.productId),
      )).go();
    } catch (e) {
      rethrow;
    }
  }

  /// Query to clear the shopping cart
  Future<void> clearShoppingCart() async {
    try {
      await delete(productCartItem).go();
    } catch (e) {
      rethrow;
    }
  }

  // 
  Future<void> updateQualityProduct(ProductCart product) async {
    try {
      await (update(productCartItem)..where(
        (productCart) =>
            productCart.productId.equals(product.productId),
      )).write(ProductCartItemCompanion(
        quantity: Value(product.quantity),
      ));
    } catch (e) {
      rethrow;
    }
  }
}