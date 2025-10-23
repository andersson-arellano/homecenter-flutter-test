import 'package:homecenter_flutter/features/products/domain/entities/product.dart';
import 'package:homecenter_flutter/features/products/domain/entities/product_cart.dart';

abstract class ShoppingCartRepository {
  Future<List<ProductCart>> getAllProductsOnShoppingCart();
  Future<void> addProductToShoppingCart(Product product);
  Future<void> removeProductFromShoppingCart(Product product);
  Future<void> clearShoppingCart();
  Future<void> updateQualityProduct(ProductCart product);
}