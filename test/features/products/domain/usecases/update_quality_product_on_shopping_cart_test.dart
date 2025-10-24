import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:homecenter_flutter/features/products/domain/entities/product_cart.dart';
import 'package:homecenter_flutter/features/products/domain/repositories/shopping_cart_repository.dart';
import 'package:homecenter_flutter/features/products/domain/usecases/update_quality_product_on_shopping_cart.dart';

class _MockShoppingCartRepository extends Mock implements ShoppingCartRepository {}

void main() {
  late _MockShoppingCartRepository repo;
  late UpdateQualityProductOnShoppingCart usecase;

  const cart = ProductCart(
    quantity: 2,
    productId: 'p1',
    displayName: 'Prod 1',
    price: '10',
    mediaUrls: ['u1'],
  );

  setUp(() {
    repo = _MockShoppingCartRepository();
    usecase = UpdateQualityProductOnShoppingCart(repository: repo);
  });

  test('calls repository.updateQualityProduct with product cart', () async {
    when(() => repo.updateQualityProduct(cart)).thenAnswer((_) async {});

    await usecase(cart);

    verify(() => repo.updateQualityProduct(cart)).called(1);
    verifyNoMoreInteractions(repo);
  });
}
