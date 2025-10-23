import 'package:homecenter_flutter/features/products/domain/entities/product.dart';
import 'package:homecenter_flutter/features/products/domain/repositories/index.dart';

class GetProducts {
  const GetProducts({
    required ProductsRepository repository,
  }) : _repository = repository;

  final ProductsRepository _repository;

  Future<List<Product>> call({required String q, required int page}) {
    return _repository.getProducts(q: q, page: page);
  }
}
