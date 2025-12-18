import 'package:flutter/material.dart';

class CategoryFilter extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onChanged;

  const CategoryFilter({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final categories = const [
    'All',
    'Pain Relief',
    'Antibiotic',
    'Supplement',
    'Allergy',
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: categories.map((cat) {
        final isActive = cat == selected;
        return ChoiceChip(
          selectedColor: Colors.green,
          labelStyle: TextStyle(color: isActive ? Colors.white : Colors.black),

          showCheckmark: false,
          label: Text(cat),
          selected: isActive,
          onSelected: (_) => onChanged(cat),
        );
      }).toList(),
    );
  }
}
