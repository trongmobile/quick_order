import 'package:quick_order/data/products.dart';

final List<Product> products = [
  Product(
    id: 1,
    name: 'Paracetamol 500mg',
    price: 15000,
    category: 'Pain Relief',
    isPrescription: false,
  ),
  Product(
    id: 2,
    name: 'Amoxicillin 500mg',
    price: 45000,
    category: 'Antibiotic',
    isPrescription: true,
  ),
  Product(
    id: 3,
    name: 'Vitamin C 1000mg',
    price: 30000,
    category: 'Supplement',
    isPrescription: false,
  ),
  Product(
    id: 4,
    name: 'Cetirizine 10mg',
    price: 20000,
    category: 'Allergy',
    isPrescription: false,
  ),
];
