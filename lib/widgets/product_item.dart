import 'package:flutter/material.dart';
import 'package:quick_order/data/products.dart';
import 'package:quick_order/utils/currency_formatter.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const ProductItem({
    super.key,
    required this.product,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: ListTile(
        title: Row(
          children: [
            Text(product.name),
            if (product.isPrescription)
              Container(
                margin: const EdgeInsets.only(left: 8),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'Rx',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
          ],
        ),
        subtitle: Text(
          '${product.category} • ${CurrencyFormatter.formatVnd(product.price)}',
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: quantity > 0 ? onRemove : null,
            ),
            Text(quantity.toString()),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: quantity < 99 ? onAdd : null,
            ),
          ],
        ),
      ),
    );
  }
}
