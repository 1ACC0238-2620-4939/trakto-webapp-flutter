import 'package:flutter/material.dart';
import 'package:trakto_route_flutter/core/presentation/widgets/trakto_page.dart';
import 'package:trakto_route_flutter/core/presentation/widgets/panel.dart';
import 'package:trakto_route_flutter/core/presentation/widgets/secondary_text.dart';
import 'package:trakto_route_flutter/core/presentation/widgets/field.dart';
import 'package:trakto_route_flutter/core/presentation/widgets/primary_button.dart';
import 'package:trakto_route_flutter/features/trips/presentation/widgets/waypoint_panel.dart';

class NewTripScreen extends StatelessWidget {
  const NewTripScreen({
    super.key,
    required this.onManageDrivers,
    required this.onManageVehicles,
  });

  final ValueChanged<BuildContext> onManageDrivers;
  final ValueChanged<BuildContext> onManageVehicles;

  @override
  Widget build(BuildContext context) => TraktoPage(
    'Nuevo viaje',
    'Elige la flota e ingresa el origen, el destino y la fecha.',
    spacing: 14,
    children: [
      Panel(
        'Asignación',
        children: [
          const OutlinedButton(
            onPressed: null,
            child: Text('Conductor activo'),
          ),
          const SecondaryText('Necesitas al menos un conductor activo.'),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: OutlinedButton(
              onPressed: () => onManageDrivers(context),
              child: const Text('Ir a conductores'),
            ),
          ),
          const OutlinedButton(onPressed: null, child: Text('Camión activo')),
          const SecondaryText('Necesitas al menos un camión activo.'),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: OutlinedButton(
              onPressed: () => onManageVehicles(context),
              child: const Text('Ir a camiones'),
            ),
          ),
          const Align(
            alignment: AlignmentDirectional.centerStart,
            child: OutlinedButton(
              onPressed: null,
              child: Text('Actualizar disponibilidad'),
            ),
          ),
        ],
      ),
      const WaypointPanel('Origen'),
      const WaypointPanel('Destino'),
      const Panel(
        'Programación',
        children: [
          Field('Fecha local (AAAA-MM-DD HH:mm)'),
          SecondaryText(
            'La hora se interpreta según la zona horaria de este dispositivo.',
          ),
        ],
      ),
      const PrimaryButton('Programar viaje'),
    ],
  );
}
