import 'package:flutter/material.dart';
import 'package:trakto_route_flutter/core/presentation/widgets/editor_dialog.dart';
import 'package:trakto_route_flutter/core/presentation/widgets/field.dart';
import 'package:trakto_route_flutter/core/presentation/widgets/secondary_text.dart';

class NewDriverDialog extends StatelessWidget {
  const NewDriverDialog({super.key});

  @override
  Widget build(BuildContext context) => const EditorDialog(
    title: 'Nuevo conductor',
    fields: [
      OutlinedButton(
        onPressed: null,
        child: Text('Selecciona un perfil existente'),
      ),
      SecondaryText(
        'No hay perfiles disponibles sin conductor. El perfil debe existir en el backend.',
      ),
      Field('Licencia (A12345678)'),
    ],
  );
}
