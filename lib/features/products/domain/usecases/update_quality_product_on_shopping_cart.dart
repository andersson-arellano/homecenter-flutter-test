import 'package:homecenter_flutter/features/products/domain/entities/product_cart.dart';
import 'package:homecenter_flutter/features/products/domain/repositories/index.dart';

class UpdateQualityProductOnShoppingCart {
  final ShoppingCartRepository _repository;

  UpdateQualityProductOnShoppingCart({ required ShoppingCartRepository repository,
  }) : _repository = repository;

  Future<void> call(ProductCart product) async {
    return _repository.updateQualityProduct(product);
  }
}