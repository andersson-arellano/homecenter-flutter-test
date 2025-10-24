import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:homecenter_flutter/features/products/domain/entities/product_cart.dart';
import 'package:homecenter_flutter/features/products/domain/repositories/shopping_cart_repository.dart';
import 'package:homecenter_flutter/features/products/domain/usecases/get_all_products_on_shopping_cart.dart';

class _MockShoppingCartRepository extends Mock implements ShoppingCartRepository {}

void main() {
  late _MockShoppingCartRepository repo;
  late GetAllProductsOnShoppingCart usecase;

  setUp(() {
    repo = _MockShoppingCartRepository();
    usecase = GetAllProductsOnShoppingCart(repository: repo);
  });

  test('returns products from repository', () async {
    const carts = [
      ProductCart(
        quantity: 1,
        productId: 'p1',
        displayName: 'Prod',
        price: '10',
        mediaUrls: ['u1'],
      ),
    ];

    when(() => repo.getAllProductsOnShoppingCart()).thenAnswer((_) async => carts);

    final result = await usecase();

    expect(result, carts);
    verify(() => repo.getAllProductsOnShoppingCart()).called(1);
    verifyNoMoreInteractions(repo);
  });
}
