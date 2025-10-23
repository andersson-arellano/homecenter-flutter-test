import 'package:homecenter_flutter/features/products/data/datasource/local/shopping_cart_local_source.dart';
import 'package:homecenter_flutter/features/products/domain/entities/product.dart';
import 'package:homecenter_flutter/features/products/domain/entities/product_cart.dart';
import 'package:homecenter_flutter/features/products/domain/repositories/index.dart';

class ShoppingCartRepositoryImple implements ShoppingCartRepository{
  const ShoppingCartRepositoryImple(this.localSource);

  final ShoppingCartLocalDatabase localSource;

  @override
  /// Gets all products on the shopping cart
  Future<List<ProductCart>> getAllProductsOnShoppingCart() {
    return localSource.getAllProductsOnShoppingCart();
  }

  @override
  /// Adds a product to the shopping cart
  /// [product] The product to add to the shopping cart
  Future<void> addProductToShoppingCart(Product product) {
    return localSource.addProductToShoppingCart(product);
  }

  @override
  /// Removes a product from the shopping cart
  /// [product] The product to remove from the shopping cart
  Future<void> removeProductFromShoppingCart(Product product) {
    return localSource.removeProductFromShoppingCart(product);
  }

  @override
  /// Clears the shopping cart
  Future<void> clearShoppingCart() {
    return localSource.clearShoppingCart();
  }

  @override
  Future<void> updateQualityProduct(ProductCart product) {
    return localSource.updateQualityProduct(product);
  }
}