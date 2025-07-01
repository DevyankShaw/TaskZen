import 'package:flutter/material.dart';

class FilterField extends StatelessWidget {
  const FilterField({super.key, required this.label, required this.values});

  final String label;
  final List<Widget> values;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: textTheme.labelMedium!.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Wrap(spacing: 12, runSpacing: 12, children: values),
      ],
    );
  }
}