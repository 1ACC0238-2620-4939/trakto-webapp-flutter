import 'package:flutter/material.dart';
import 'package:trakto_route_flutter/core/presentation/widgets/trakto_page.dart';
import 'package:trakto_route_flutter/core/presentation/widgets/empty_panel.dart';
import 'package:trakto_route_flutter/core/presentation/widgets/primary_button.dart';
import 'package:trakto_route_flutter/features/drivers/presentation/widgets/new_driver_dialog.dart';

class DriversScreen extends StatelessWidget {
  const DriversScreen({super.key});

  @override
  Widget build(BuildContext context) => TraktoPage(
    'Conductores',
    'Registra licencias y elige quién está disponible para viajar.',
    children: [
      PrimaryButton(
        'Nuevo conductor',
        onPressed: () => showDialog<void>(
          context: context,
          builder: (context) => const NewDriverDialog(),
        ),
      ),
      const OutlinedButton(
        onPressed: null,
        child: Text('Actualizar conductores'),
      ),
      const EmptyPanel(
        'Sin conductores',
        'Crea un conductor a partir de un perfil existente.',
      ),
    ],
  );
}
