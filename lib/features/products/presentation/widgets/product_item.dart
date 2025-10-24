import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homecenter_flutter/features/products/domain/entities/product.dart';
import 'package:homecenter_flutter/features/products/presentation/bloc/shopping_cart/shopping_cart_bloc.dart';

class ProductItem extends StatelessWidget {
  final Product product; 

  const ProductItem({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            // Img Product
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                product.mediaUrls.first,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 80,
                  height: 80,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.image_not_supported, size: 40, color: Colors.grey),
                ),
              ),
            ),

            const SizedBox(width: 12),

            // displayName and price
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.displayName,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "\$${product.price}",
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Colors.green.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            // Add or remove product from Shopping Cart Button
            BlocBuilder<ShoppingCartBloc, ShoppingCartState>(builder: (context, state){
              if (state.products.any((productState) => productState.productId == product.productId)){
                return IconButton(
                  onPressed: () {
                    // Remove product from shopping cart 
                    context.read<ShoppingCartBloc>().add(
                      RemoveProductFromShoppingCartEvent(product: product),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Producto removido del carrito')),
                    );
                  },
                  icon: const Icon(Icons.remove_shopping_cart_rounded),
                  color: Colors.redAccent,
                  tooltip: 'Remover del carrito',
                );
              }
              return IconButton(
                onPressed: () {
                  // Add product to shopping cart 
                  context.read<ShoppingCartBloc>().add(
                    AddProductToShoppingCartEvent(product: product),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Producto añadido al carrito')),
                  );
                },
                icon: const Icon(Icons.add_shopping_cart_rounded),
                color: Colors.blueAccent,
                tooltip: 'Agregar al carrito',
              );              
            }),
          ],
        ),
      ),
    );
  }
}
