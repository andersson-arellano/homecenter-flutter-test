import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:homecenter_flutter/features/products/domain/entities/product.dart';
import 'package:homecenter_flutter/features/products/domain/repositories/shopping_cart_repository.dart';
import 'package:homecenter_flutter/features/products/domain/usecases/remove_product_from_shopping_cart.dart';

class _MockShoppingCartRepository extends Mock implements ShoppingCartRepository {}

void main() {
  late _MockShoppingCartRepository repo;
  late RemoveProductFromShoppingCart usecase;

  const product = Product(
    productId: 'p1',
    displayName: 'Prod 1',
    price: '10',
    mediaUrls: ['u1'],
  );

  setUp(() {
    repo = _MockShoppingCartRepository();
    usecase = RemoveProductFromShoppingCart(repository: repo);
  });

  test('calls repository.removeProductFromShoppingCart with product', () async {
    when(() => repo.removeProductFromShoppingCart(product)).thenAnswer((_) async {});

    await usecase(product);

    verify(() => repo.removeProductFromShoppingCart(product)).called(1);
    verifyNoMoreInteractions(repo);
  });
}
