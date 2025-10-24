import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:homecenter_flutter/features/products/domain/entities/product.dart';
import 'package:homecenter_flutter/features/products/domain/repositories/products_repository.dart';
import 'package:homecenter_flutter/features/products/domain/usecases/get_products.dart';

class _MockProductsRepository extends Mock implements ProductsRepository {}

void main() {
  late _MockProductsRepository repo;
  late GetProducts usecase;

  setUp(() {
    repo = _MockProductsRepository();
    usecase = GetProducts(repository: repo);
  });

  test('calls repository and returns products', () async {
    const products = [
      Product(
        productId: '1',
        displayName: 'Prod 1',
        price: '10',
        mediaUrls: ['u1'],
      ),
    ];

    when(() => repo.getProducts(q: 'q', page: 1)).thenAnswer((_) async => products);

    final result = await usecase(q: 'q', page: 1);

    expect(result, products);
    verify(() => repo.getProducts(q: 'q', page: 1)).called(1);
    verifyNoMoreInteractions(repo);
  });
}
