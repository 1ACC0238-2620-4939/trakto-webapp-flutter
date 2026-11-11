import 'package:flutter/material.dart';

class Field extends StatelessWidget {
  const Field(this.label, {super.key, this.keyboardType});

  final String label;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) => TextField(
    keyboardType: keyboardType,
    decoration: InputDecoration(labelText: label),
  );
}
