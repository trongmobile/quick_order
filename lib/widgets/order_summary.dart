import 'package:flutter/material.dart';
import 'package:quick_order/data/products.dart';
import 'package:quick_order/utils/currency_formatter.dart';

class OrderSummary extends StatelessWidget {
  final Map<int, int> cart;
  final List<Product> products;

  const OrderSummary({super.key, required this.cart, required this.products});

  @override
  Widget build(BuildContext context) {
    final skus = cart.entries.where((e) => e.value > 0).length;
    final totalQty = cart.values.fold(0, (a, b) => a + b);
    final totalAmount = cart.entries.fold<int>(0, (sum, e) {
      final product = products.firstWhere((p) => p.id == e.key);
      return sum + product.price * e.value;
    });

    return Padding(
      padding: EdgeInsets.only(bottom: 16.0),
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          color: Colors.green.shade100,
          // border: const Border(top: BorderSide(color: Colors.grey)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('SKUs: $skus'),
            Text('Total Quantity: $totalQty'),
            Text(
              'Total Amount: ${CurrencyFormatter.formatVnd(totalAmount)} ₫',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
