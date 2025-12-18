import 'package:flutter/material.dart';
import 'package:quick_order/models/product.dart';
import 'widgets/product_item.dart';
import 'widgets/category_filter.dart';
import 'widgets/order_summary.dart';

void main() {
  runApp(const QuickOrderApp());
}

class QuickOrderApp extends StatelessWidget {
  const QuickOrderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const QuickOrderScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class QuickOrderScreen extends StatefulWidget {
  const QuickOrderScreen({super.key});

  @override
  State<QuickOrderScreen> createState() => _QuickOrderScreenState();
}

class _QuickOrderScreenState extends State<QuickOrderScreen> {
  String search = '';
  String category = 'All';
  final Map<int, int> cart = {};

  @override
  Widget build(BuildContext context) {
    final filtered = products.where((p) {
      final matchSearch = p.name.toLowerCase().contains(search.toLowerCase());
      final matchCategory = category == 'All' || p.category == category;
      return matchSearch && matchCategory;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quick Order',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Search: ',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TextField(
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green.shade100),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade100),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  hintText: 'Search product...',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (v) => setState(() => search = v),
              ),
            ),
            Text(
              'Filter: ',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            CategoryFilter(
              selected: category,
              onChanged: (v) => setState(() => category = v),
            ),
            Text(
              'Product List: ',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            Expanded(
              child: filtered.isEmpty
                  ? const Center(child: Text('No products found'))
                  : ListView.separated(
                      itemCount: filtered.length,
                      itemBuilder: (_, i) {
                        final product = filtered[i];
                        final qty = cart[product.id] ?? 0;

                        return ProductItem(
                          product: product,
                          quantity: qty,
                          onAdd: () => updateQty(context, product.id, 40),
                          onRemove: () => updateQty(context, product.id, -1),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: 8);
                      },
                    ),
            ),
            OrderSummary(cart: cart, products: products),
          ],
        ),
      ),
    );
  }

  void updateQty(BuildContext context, int productId, int delta) {
    setState(() {
      final current = cart[productId] ?? 0;
      final next = current + delta;

      if (next > 99) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('The maximum allowed quantity is 99'),
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }

      if (next < 0) return;

      cart[productId] = next;
    });
  }
}
