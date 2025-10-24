import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homecenter_flutter/features/products/presentation/bloc/shopping_cart/shopping_cart_bloc.dart';
import 'package:homecenter_flutter/features/products/presentation/pages/shopping_cart_page.dart';

class ShoppingCartButton extends StatelessWidget {
  const ShoppingCartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShoppingCartBloc, ShoppingCartState>(
        builder: (context, state) {
        final itemCount = state.products.length;
        return Tooltip(
          message: 'Carrito ($itemCount)',
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider.value(
                        value: context.read<ShoppingCartBloc>(),
                        child: ShoppingCartPage(),
                      ),
                    ),
                  );
                },
                child: const Icon(Icons.shopping_cart),
              ),
              if (itemCount > 0)
                Positioned(
                  right: -2,
                  top: -2,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 20,
                      minHeight: 20,
                    ),
                    child: Text(
                      '$itemCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
  