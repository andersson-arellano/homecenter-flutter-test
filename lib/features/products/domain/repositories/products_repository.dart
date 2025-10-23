import 'package:homecenter_flutter/features/products/domain/entities/product.dart';

abstract class ProductsRepository {
  Future<List<Product>> getProducts({required String q, required int page});
}