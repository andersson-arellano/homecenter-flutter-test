import 'package:homecenter_flutter/features/products/domain/repositories/index.dart';

class ClearShoppingCart {
  const ClearShoppingCart({
    required ShoppingCartRepository repository,
  }) : _repository = repository;

  final ShoppingCartRepository _repository;

  Future<void> call() {
    return _repository.clearShoppingCart();
  }
}