import 'package:homecenter_flutter/features/products/domain/entities/product.dart';
import 'package:homecenter_flutter/features/products/domain/repositories/index.dart';

class RemoveProductFromShoppingCart {
  const RemoveProductFromShoppingCart({
    required ShoppingCartRepository repository,
  }) : _repository = repository;

  final ShoppingCartRepository _repository;

  Future<void> call(Product product) {
    return _repository.removeProductFromShoppingCart(product);
  }
}