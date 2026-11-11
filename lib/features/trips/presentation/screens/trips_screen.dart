import 'package:flutter/material.dart';
import 'package:trakto_route_flutter/core/presentation/widgets/trakto_page.dart';
import 'package:trakto_route_flutter/core/presentation/widgets/empty_panel.dart';
import 'package:trakto_route_flutter/core/presentation/widgets/primary_button.dart';

class TripsScreen extends StatefulWidget {
  const TripsScreen({super.key, required this.onNewTrip});
  final VoidCallback onNewTrip;
  @override
  State<TripsScreen> createState() => _TripsScreenState();
}

class _TripsScreenState extends State<TripsScreen> {
  static const filters = [
    'Todos los estados',
    'Programado',
    'En curso · Activo',
    'Completado',
    'Cancelado',
  ];
  var filter = filters.first;

  @override
  Widget build(BuildContext context) => TraktoPage(
    'Viajes',
    'Programa los recorridos y consulta qué viajes están en curso.',
    children: [
      PrimaryButton('Nuevo viaje', onPressed: widget.onNewTrip),
      const OutlinedButton(onPressed: null, child: Text('Actualizar viajes')),
      MenuAnchor(
        menuChildren: [
          for (final option in filters)
            MenuItemButton(
              onPressed: () => setState(() => filter = option),
              child: Text(option),
            ),
        ],
        builder: (context, controller, child) => OutlinedButton(
          onPressed: () =>
              controller.isOpen ? controller.close() : controller.open(),
          child: Text(filter),
        ),
      ),
      if (filter == filters.first)
        const EmptyPanel(
          'Sin viajes',
          'Asigna un conductor y un camión activos para programar un viaje.',
        )
      else
        const EmptyPanel(
          'Sin viajes en este estado',
          'Cambia el filtro para ver otros viajes.',
        ),
    ],
  );
}
