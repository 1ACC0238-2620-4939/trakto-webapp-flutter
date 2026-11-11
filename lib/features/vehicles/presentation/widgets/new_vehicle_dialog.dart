import 'package:flutter/material.dart';
import 'package:trakto_route_flutter/core/presentation/widgets/editor_dialog.dart';
import 'package:trakto_route_flutter/core/presentation/widgets/field.dart';

class NewVehicleDialog extends StatelessWidget {
  const NewVehicleDialog({super.key});

  @override
  Widget build(BuildContext context) => const EditorDialog(
    title: 'Nuevo camión',
    fields: [
      Field('Placa (ABC-123)'),
      Field(
        'Capacidad',
        keyboardType: TextInputType.numberWithOptions(decimal: true),
      ),
    ],
  );
}
