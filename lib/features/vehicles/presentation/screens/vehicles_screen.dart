import 'package:flutter/material.dart';
import 'package:trakto_route_flutter/core/presentation/widgets/trakto_page.dart';
import 'package:trakto_route_flutter/core/presentation/widgets/empty_panel.dart';
import 'package:trakto_route_flutter/core/presentation/widgets/primary_button.dart';
import 'package:trakto_route_flutter/features/vehicles/presentation/widgets/new_vehicle_dialog.dart';

class VehiclesScreen extends StatelessWidget {
  const VehiclesScreen({super.key});

  @override
  Widget build(BuildContext context) => TraktoPage(
    'Camiones',
    'Administra placas, capacidades y disponibilidad de la flota.',
    children: [
      PrimaryButton(
        'Nuevo camión',
        onPressed: () => showDialog<void>(
          context: context,
          builder: (context) => const NewVehicleDialog(),
        ),
      ),
      const OutlinedButton(onPressed: null, child: Text('Actualizar camiones')),
      const EmptyPanel(
        'Sin camiones',
        'Registra un camión para poder asignarlo a un viaje.',
      ),
    ],
  );
}
