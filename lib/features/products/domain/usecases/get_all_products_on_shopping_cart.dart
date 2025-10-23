import 'package:homecenter_flutter/features/products/domain/entities/product_cart.dart';
import 'package:homecenter_flutter/features/products/domain/repositories/index.dart';

class GetAllProductsOnShoppingCart {
  const GetAllProductsOnShoppingCart({
    required ShoppingCartRepository repository,
  }) : _repository = repository;

  final ShoppingCartRepository _repository;

  Future<List<ProductCart>> call() {
    return _repository.getAllProductsOnShoppingCart();
  }
}