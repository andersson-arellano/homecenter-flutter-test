import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:homecenter_flutter/features/products/domain/entities/product.dart';
import 'package:homecenter_flutter/features/products/domain/entities/product_cart.dart';
import 'package:homecenter_flutter/features/products/domain/usecases/add_product_to_shopping_cart.dart';
import 'package:homecenter_flutter/features/products/domain/usecases/clear_shopping_cart.dart';
import 'package:homecenter_flutter/features/products/domain/usecases/get_all_products_on_shopping_cart.dart';
import 'package:homecenter_flutter/features/products/domain/usecases/remove_product_from_shopping_cart.dart';
import 'package:homecenter_flutter/features/products/domain/usecases/update_quality_product_on_shopping_cart.dart';
import 'package:homecenter_flutter/features/products/presentation/bloc/shopping_cart/shopping_cart_bloc.dart';

class MockClearShoppingCart extends Mock implements ClearShoppingCart {}
class MockRemoveProductFromShoppingCart extends Mock implements RemoveProductFromShoppingCart {}
class MockAddProductToShoppingCart extends Mock implements AddProductToShoppingCart {}
class MockGetAllProductsOnShoppingCart extends Mock implements GetAllProductsOnShoppingCart {}
class MockUpdateQualityProductOnShoppingCart extends Mock implements UpdateQualityProductOnShoppingCart {}

void main() {
  late MockClearShoppingCart clearShoppingCart;
  late MockRemoveProductFromShoppingCart removeProductFromShoppingCart;
  late MockAddProductToShoppingCart addProductToShoppingCart;
  late MockGetAllProductsOnShoppingCart getAllProductsOnShoppingCart;
  late MockUpdateQualityProductOnShoppingCart updateQualityProductOnShoppingCart;

  const product = Product(
    productId: 'p1',
    displayName: 'Prod 1',
    price: '100',
    mediaUrls: ['https://example/1.png'],
  );

  const cart1 = ProductCart(
    quantity: 1,
    productId: 'p1',
    displayName: 'Prod 1',
    price: '100',
    mediaUrls: ['https://example/1.png'],
  );

  const cart2 = ProductCart(
    quantity: 2,
    productId: 'p1',
    displayName: 'Prod 1',
    price: '100',
    mediaUrls: ['https://example/1.png'],
  );

  setUp(() {
    clearShoppingCart = MockClearShoppingCart();
    removeProductFromShoppingCart = MockRemoveProductFromShoppingCart();
    addProductToShoppingCart = MockAddProductToShoppingCart();
    getAllProductsOnShoppingCart = MockGetAllProductsOnShoppingCart();
    updateQualityProductOnShoppingCart = MockUpdateQualityProductOnShoppingCart();
  });

  setUpAll(() {
    registerFallbackValue(cart1);
  });

  ShoppingCartBloc buildBloc() => ShoppingCartBloc(
        clearShoppingCart: clearShoppingCart,
        removeProductFromShoppingCart: removeProductFromShoppingCart,
        addProductToShoppingCart: addProductToShoppingCart,
        getAllProductsOnShoppingCart: getAllProductsOnShoppingCart,
        updateQualityProductOnShoppingCart: updateQualityProductOnShoppingCart,
      );

  group('ShoppingCartBloc', () {
    test('initial state is ShoppingCartState.initial', () {
      final bloc = buildBloc();
      expect(bloc.state.products, isEmpty);
      expect(bloc.state.error, isNull);
      bloc.close();
    });

    blocTest<ShoppingCartBloc, ShoppingCartState>(
      'GetShoppingCartEvent success emits success with products',
      build: () {
        when(() => getAllProductsOnShoppingCart())
            .thenAnswer((_) async => [cart1]);
        return buildBloc();
      },
      act: (bloc) => bloc.add(GetShoppingCartEvent()),
      expect: () => [
        predicate<ShoppingCartState>((s) => s.error == null && s.products.length == 1 && s.products.first == cart1),
      ],
      verify: (_) {
        verify(() => getAllProductsOnShoppingCart()).called(1);
      },
    );

    blocTest<ShoppingCartBloc, ShoppingCartState>(
      'GetShoppingCartEvent failure emits failure with error',
      build: () {
        when(() => getAllProductsOnShoppingCart())
            .thenThrow(Exception('db error'));
        return buildBloc();
      },
      act: (bloc) => bloc.add(GetShoppingCartEvent()),
      expect: () => [
        predicate<ShoppingCartState>((s) => s.error != null && s.error!.contains('db error')),
      ],
    );

    blocTest<ShoppingCartBloc, ShoppingCartState>(
      'AddProductToShoppingCartEvent success emits success (keeps current list)',
      build: () {
        when(() => addProductToShoppingCart(product))
            .thenAnswer((_) async {});
        return buildBloc();
      },
      act: (bloc) => bloc.add(AddProductToShoppingCartEvent(product: product)),
      expect: () => [
        predicate<ShoppingCartState>((s) => s.error == null && s.products.isEmpty),
      ],
      verify: (_) {
        verify(() => addProductToShoppingCart(product)).called(1);
      },
    );

    blocTest<ShoppingCartBloc, ShoppingCartState>(
      'AddProductToShoppingCartEvent failure emits failure',
      build: () {
        when(() => addProductToShoppingCart(product))
            .thenThrow(Exception('add error'));
        return buildBloc();
      },
      act: (bloc) => bloc.add(AddProductToShoppingCartEvent(product: product)),
      expect: () => [
        predicate<ShoppingCartState>((s) => s.error != null && s.error!.contains('add error')),
      ],
    );

    blocTest<ShoppingCartBloc, ShoppingCartState>(
      'RemoveProductFromShoppingCartEvent success removes and refreshes list',
      build: () {
        when(() => removeProductFromShoppingCart(product))
            .thenAnswer((_) async {});
        when(() => getAllProductsOnShoppingCart())
            .thenAnswer((_) async => <ProductCart>[]);
        return buildBloc();
      },
      act: (bloc) => bloc.add(RemoveProductFromShoppingCartEvent(product: product)),
      expect: () => [
        predicate<ShoppingCartState>((s) => s.error == null && s.products.isEmpty),
      ],
      verify: (_) {
        verify(() => removeProductFromShoppingCart(product)).called(1);
        verify(() => getAllProductsOnShoppingCart()).called(1);
      },
    );

    blocTest<ShoppingCartBloc, ShoppingCartState>(
      'RemoveProductFromShoppingCartEvent failure emits failure',
      build: () {
        when(() => removeProductFromShoppingCart(product))
            .thenThrow(Exception('remove error'));
        return buildBloc();
      },
      act: (bloc) => bloc.add(RemoveProductFromShoppingCartEvent(product: product)),
      expect: () => [
        predicate<ShoppingCartState>((s) => s.error != null && s.error!.contains('remove error')),
      ],
    );

    blocTest<ShoppingCartBloc, ShoppingCartState>(
      'ClearShoppingCartEvent success emits empty list',
      build: () {
        when(() => clearShoppingCart()).thenAnswer((_) async {});
        return buildBloc();
      },
      act: (bloc) => bloc.add(ClearShoppingCartEvent()),
      expect: () => [
        predicate<ShoppingCartState>((s) => s.error == null && s.products.isEmpty),
      ],
      verify: (_) {
        verify(() => clearShoppingCart()).called(1);
      },
    );

    blocTest<ShoppingCartBloc, ShoppingCartState>(
      'ClearShoppingCartEvent failure emits failure',
      build: () {
        when(() => clearShoppingCart()).thenThrow(Exception('clear error'));
        return buildBloc();
      },
      act: (bloc) => bloc.add(ClearShoppingCartEvent()),
      expect: () => [
        predicate<ShoppingCartState>((s) => s.error != null && s.error!.contains('clear error')),
      ],
    );

    blocTest<ShoppingCartBloc, ShoppingCartState>(
      'IncrementQualityProductOnShoppingCartEvent success updates quantity and refreshes list',
      build: () {
        when(() => updateQualityProductOnShoppingCart(cart2))
            .thenAnswer((_) async {});
        when(() => getAllProductsOnShoppingCart())
            .thenAnswer((_) async => [cart2]);
        return buildBloc();
      },
      act: (bloc) => bloc.add(IncrementQualityProductOnShoppingCartEvent(product: cart1)),
      expect: () => [
        predicate<ShoppingCartState>((s) => s.error == null && s.products.length == 1 && s.products.first.quantity == 2),
      ],
      verify: (_) {
        verify(() => updateQualityProductOnShoppingCart(cart2)).called(1);
        verify(() => getAllProductsOnShoppingCart()).called(1);
      },
    );

    blocTest<ShoppingCartBloc, ShoppingCartState>(
      'DecrementQualityProductOnShoppingCartEvent success updates quantity and refreshes list',
      build: () {
        when(() => updateQualityProductOnShoppingCart(cart1))
            .thenAnswer((_) async {});
        when(() => getAllProductsOnShoppingCart())
            .thenAnswer((_) async => [cart1]);
        return buildBloc();
      },
      act: (bloc) => bloc.add(DecrementQualityProductOnShoppingCartEvent(product: cart2)),
      expect: () => [
        predicate<ShoppingCartState>((s) => s.error == null && s.products.length == 1 && s.products.first.quantity == 1),
      ],
      verify: (_) {
        verify(() => updateQualityProductOnShoppingCart(cart1)).called(1);
        verify(() => getAllProductsOnShoppingCart()).called(1);
      },
    );

  });
}
