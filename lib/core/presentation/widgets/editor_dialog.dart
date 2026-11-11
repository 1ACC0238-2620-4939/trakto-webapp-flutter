import 'package:flutter/material.dart';

class EditorDialog extends StatelessWidget {
  const EditorDialog({super.key, required this.title, required this.fields});

  final String title;
  final List<Widget> fields;

  @override
  Widget build(BuildContext context) => AlertDialog(
    scrollable: true,
    title: Text(title),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 8,
      children: fields,
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: const Text('Cerrar'),
      ),
      const TextButton(onPressed: null, child: Text('Guardar')),
    ],
  );
}
