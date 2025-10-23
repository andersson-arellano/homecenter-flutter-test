import 'package:dio/dio.dart';
import 'package:homecenter_flutter/core/utils/http_exceptions_handler.dart';
import 'package:homecenter_flutter/features/products/data/datasource/remote/dio_source.dart';
import 'package:homecenter_flutter/features/products/data/models/product_model.dart';

class ProductsRemoteSource extends DioSource{
  ProductsRemoteSource({ required super.dio, required super.baseUrl});

   Future<List<ProductModel>> getProducts({
    required String page,
    String q = '',
  }) async {
    try {
      final response = await this.dio.get<Map<String, dynamic>>(
        '/soco/',
        queryParameters: {
          "priceGroup": "10",
          "currentpage": page,
          "q": q,
        },
        options: buildCacheOptions(
          const Duration(minutes: 2),
        ),
      );

      if (response.data  == null || response.data!["data"]["results"] == null) {
        throw const HTTPException('No data received');
      }

      var results = (response.data!["data"]["results"] as List<dynamic>).map(
        (product) {
          return ProductModel.fromJson(product as Map<String, dynamic>);
        },
      ).toList();

      return results;
    } on DioException catch (e) {
      print(e);
      throw HTTPException.fromDioException(e);
    } catch (e) {
      throw HTTPException('Unexpected error: $e');
    }
  }
}