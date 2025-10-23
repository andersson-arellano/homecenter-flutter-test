import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homecenter_flutter/features/products/domain/entities/product_cart.dart';
import 'package:homecenter_flutter/features/products/presentation/bloc/shopping_cart/shopping_cart_bloc.dart';

class ProductCartItem extends StatelessWidget{
  const ProductCartItem({super.key, required this.product});

  final ProductCart product;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                product.mediaUrls.first,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.displayName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.price,
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    // Decrease quantity
                    if(product.quantity > 1){
                      context.read<ShoppingCartBloc>().add(DecrementQualityProductOnShoppingCartEvent(product: product));
                    }
                  },
                  icon: const Icon(Icons.remove_circle_outline),
                  color: product.quantity > 1 ? Colors.black : Colors.grey,
                ),
                Text(
                  product.quantity.toString(),
                  style: const TextStyle(fontSize: 16),
                ),
                IconButton(
                  onPressed: () {
                    // Increse quantity
                    context.read<ShoppingCartBloc>().add(IncrementQualityProductOnShoppingCartEvent(product: product));
                  },
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                // Remove Product From Cart
                context.read<ShoppingCartBloc>().add(RemoveProductFromShoppingCartEvent(product: product));
              },
              icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
            ),
          ],
        ),
      ),
    );
  }
}
