import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homecenter_flutter/features/products/presentation/bloc/shopping_cart/shopping_cart_bloc.dart';
import 'package:homecenter_flutter/features/products/presentation/widgets/product_cart_item.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({super.key});

  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {

  @override
  void initState() {
    super.initState();
    Future.microtask(()=>
      context.read<ShoppingCartBloc>().add(GetShoppingCartEvent())
    );
  }

  @override
  Widget build(BuildContext context) {
    // Ejemplo de datos simulados (debes reemplazar por los del Bloc)
    final cartItems = [
      {'title': 'Smart Watch', 'price': 59.99, 'quantity': 1, 'image': 'https://via.placeholder.com/100'},
      {'title': 'Wireless Headphones', 'price': 89.50, 'quantity': 2, 'image': 'https://via.placeholder.com/100'},
    ];

    final total = cartItems.fold<double>(
      0,
      (sum, item) => sum + (item['price'] as double) * (item['quantity'] as int),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        actions: [
          IconButton(
            onPressed: () {
              // Clear shopping cart
              context.read<ShoppingCartBloc>().add(ClearShoppingCartEvent());
            },
            icon: const Icon(Icons.delete_forever_rounded),
            tooltip: 'Vaciar carrito',
          ),
        ],
      ),
      body: BlocBuilder<ShoppingCartBloc, ShoppingCartState>(
        builder: (context, state){
          return state.products.isEmpty
          ? const Center(
              child: Text(
                'Tu carrito está vacío 🛒',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: state.products.length,
                    itemBuilder: (context, index) => ProductCartItem(product: state.products[index]), 
                  ),
                ),

                // Total y botón de checkout
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    border: const Border(top: BorderSide(color: Colors.grey, width: 0.2)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total:',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "\$${total.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton.icon(
                        onPressed: () {
                          // TODO: Implementar proceso de compra
                          // context.read<CartBloc>().add(Checkout());
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        icon: const Icon(Icons.payment),
                        label: const Text('Proceder al pago'),
                      ),
                    ],
                  ),
                ),
              ],
            );
        }),
    );
  }
}
