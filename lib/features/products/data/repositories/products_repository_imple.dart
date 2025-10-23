import 'package:homecenter_flutter/features/products/data/datasource/remote/products_remote_source.dart';
import 'package:homecenter_flutter/features/products/domain/entities/product.dart';
import 'package:homecenter_flutter/features/products/domain/repositories/index.dart';

class ProductsRepositoryImple implements ProductsRepository{
  const ProductsRepositoryImple(this.remoteSource);

  final ProductsRemoteSource remoteSource;

  @override
  Future<List<Product>> getProducts({ required int page, required String q}){
    return remoteSource.getProducts(page: page.toString(), q: q); 
  }
}