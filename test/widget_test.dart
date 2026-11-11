import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trakto_route_flutter/app/trakto_app.dart';

void main() {
  testWidgets('Navegación y formularios con listas vacías', (tester) async {
    await tester.pumpWidget(const TraktoApp());
    expect(find.text('Sin viajes'), findsOneWidget);
    await tester.tap(find.text('Todos los estados'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Programado'));
    await tester.pumpAndSettle();
    expect(find.text('Sin viajes en este estado'), findsOneWidget);

    await tester.tap(find.text('Nuevo viaje'));
    await tester.pumpAndSettle();
    expect(find.byType(NavigationBar), findsNothing);
    await tester.tap(find.text('Ir a conductores'));
    await tester.pumpAndSettle();
    expect(find.text('Sin conductores'), findsOneWidget);
    await tester.tap(find.text('Nuevo conductor'));
    await tester.pumpAndSettle();
    expect(find.text('Licencia (A12345678)'), findsOneWidget);
    await tester.tap(find.text('Cerrar'));
    await tester.pumpAndSettle();
    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Ir a camiones'));
    await tester.pumpAndSettle();
    expect(find.text('Sin camiones'), findsOneWidget);
    await tester.tap(find.text('Nuevo camión'));
    await tester.pumpAndSettle();
    expect(find.text('Capacidad'), findsOneWidget);
    await tester.tap(find.text('Cerrar'));
    await tester.pumpAndSettle();
    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Sin viajes en este estado'), findsOneWidget);
    await tester.tap(find.text('Perfiles'));
    await tester.pumpAndSettle();
    expect(find.text('Sin perfiles disponibles'), findsOneWidget);
  });
}
