import 'package:homecenter_flutter/features/products/domain/entities/product.dart';

abstract class ShoppingCartRepository {
  Future<List<Product>> getAllProductsOnShoppingCart();
  Future<void> addProductToShoppingCart(Product product);
  Future<void> removeProductFromShoppingCart(Product product);
  Future<void> clearShoppingCart();
}