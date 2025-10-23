import 'package:homecenter_flutter/features/products/domain/entities/product.dart';
import 'package:homecenter_flutter/features/products/domain/repositories/index.dart';

class AddProductToShoppingCart {
  const AddProductToShoppingCart({
    required ShoppingCartRepository repository,
  }) : _repository = repository;

  final ShoppingCartRepository _repository;

  Future<void> call(Product product) {
    return _repository.addProductToShoppingCart(product);
  }
}