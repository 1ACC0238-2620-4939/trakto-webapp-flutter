import 'package:flutter/material.dart';

void main() => runApp(const TraktoApp());

ThemeData traktoTheme(Brightness brightness) {
  final dark = brightness == Brightness.dark;
  final colors =
      ColorScheme.fromSeed(
        seedColor: const Color(0xFF007BDF),
        brightness: brightness,
      ).copyWith(
        primary: const Color(0xFF0073CE),
        onPrimary: Colors.white,
        secondary: const Color(0xFF00265F),
        onSecondary: Colors.white,
        primaryContainer: Color(dark ? 0xFF142F49 : 0xFFE8F3FF),
        onPrimaryContainer: Color(dark ? 0xFF70BFFF : 0xFF0069BD),
        surface: Color(dark ? 0xFF1A2635 : 0xFFFFFFFF),
        surfaceContainerHighest: Color(dark ? 0xFF202F41 : 0xFFFAFAFA),
        onSurface: Color(dark ? 0xFFE7EFFA : 0xFF00265F),
        onSurfaceVariant: Color(dark ? 0xFFB4C1D2 : 0xFF5B6472),
        outline: Color(dark ? 0xFF7489A5 : 0xFF8191A7),
        outlineVariant: Color(dark ? 0xFF3A4B61 : 0xFFDCE2E8),
        error: Color(dark ? 0xFFFFA39B : 0xFFB3261E),
        onError: Color(dark ? 0xFF101925 : 0xFFFFFFFF),
        errorContainer: Color(dark ? 0xFF3C242B : 0xFFFDEEEE),
      );
  final background = Color(dark ? 0xFF101925 : 0xFFFAFAFA);
  return ThemeData(
    colorScheme: colors,
    scaffoldBackgroundColor: background,
    appBarTheme: AppBarTheme(
      backgroundColor: background,
      foregroundColor: colors.onSurface,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(fontSize: 22, color: colors.onSurface),
      toolbarHeight: 64,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: colors.surfaceContainerHighest,
      indicatorColor: colors.primaryContainer,
      iconTheme: WidgetStateProperty.resolveWith(
        (states) => IconThemeData(
          color: states.contains(WidgetState.selected)
              ? colors.onPrimaryContainer
              : colors.onSurfaceVariant,
        ),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
  );
}

class TraktoApp extends StatelessWidget {
  const TraktoApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Trakto Route',
    debugShowCheckedModeBanner: false,
    theme: traktoTheme(Brightness.light),
    darkTheme: traktoTheme(Brightness.dark),
    home: const HomeScreen(),
  );
}

enum Section {
  trips(
    'Viajes',
    Icons.route,
    'Programa los recorridos y consulta qué viajes están en curso.',
  ),
  drivers(
    'Conductores',
    Icons.person_outline,
    'Registra licencias y elige quién está disponible para viajar.',
  ),
  vehicles(
    'Camiones',
    Icons.local_shipping_outlined,
    'Administra placas, capacidades y disponibilidad de la flota.',
  ),
  profiles(
    'Perfiles',
    Icons.badge_outlined,
    'Personas registradas que se pueden asociar a un conductor.',
  );

  const Section(this.title, this.icon, this.subtitle);

  final String title;
  final IconData icon;
  final String subtitle;
}

void openScreen(BuildContext context, Widget body) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (context) => Scaffold(appBar: traktoBar(context), body: body),
    ),
  );
}

AppBar traktoBar(BuildContext context) => AppBar(
  title: const Text('Trakto Route'),
  leading: Navigator.of(context).canPop()
      ? BackButton(onPressed: () => Navigator.of(context).maybePop())
      : null,
);

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var section = Section.trips;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: traktoBar(context),
    body: IndexedStack(
      index: section.index,
      sizing: StackFit.expand,
      children: [for (final tab in Section.values) SectionScreen(section: tab)],
    ),
    bottomNavigationBar: NavigationBar(
      selectedIndex: section.index,
      onDestinationSelected: (index) {
        setState(() => section = Section.values[index]);
      },
      destinations: [
        for (final tab in Section.values)
          NavigationDestination(icon: Icon(tab.icon), label: tab.title),
      ],
    ),
  );
}

class SectionScreen extends StatefulWidget {
  const SectionScreen({super.key, required this.section});

  final Section section;

  @override
  State<SectionScreen> createState() => _SectionScreenState();
}

class _SectionScreenState extends State<SectionScreen> {
  static const filters = [
    'Todos los estados',
    'Programado',
    'En curso · Activo',
    'Completado',
    'Cancelado',
  ];
  var filter = filters.first;

  @override
  Widget build(BuildContext context) {
    final section = widget.section;
    final children = switch (section) {
      Section.trips => <Widget>[
        PrimaryButton(
          'Nuevo viaje',
          onPressed: () => openScreen(context, const NewTripScreen()),
        ),
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
      Section.drivers => <Widget>[
        PrimaryButton(
          'Nuevo conductor',
          onPressed: () => showEditor(context, section),
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
      Section.vehicles => <Widget>[
        PrimaryButton(
          'Nuevo camión',
          onPressed: () => showEditor(context, section),
        ),
        const OutlinedButton(
          onPressed: null,
          child: Text('Actualizar camiones'),
        ),
        const EmptyPanel(
          'Sin camiones',
          'Registra un camión para poder asignarlo a un viaje.',
        ),
      ],
      Section.profiles => <Widget>[
        const OutlinedButton(
          onPressed: null,
          child: Text('Actualizar perfiles'),
        ),
        const EmptyPanel(
          'Sin perfiles disponibles',
          'Los perfiles se consultan desde el backend.',
        ),
      ],
    };
    return TraktoPage(section.title, section.subtitle, children: children);
  }
}

void showEditor(BuildContext context, Section section) {
  final driver = section == Section.drivers;
  showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      scrollable: true,
      title: Text(driver ? 'Nuevo conductor' : 'Nuevo camión'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 8,
        children: [
          if (driver) ...[
            const OutlinedButton(
              onPressed: null,
              child: Text('Selecciona un perfil existente'),
            ),
            const SecondaryText(
              'No hay perfiles disponibles sin conductor. El perfil debe existir en el backend.',
            ),
            const Field('Licencia (A12345678)'),
          ] else ...[
            const Field('Placa (ABC-123)'),
            const Field(
              'Capacidad',
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cerrar'),
        ),
        const TextButton(onPressed: null, child: Text('Guardar')),
      ],
    ),
  );
}

class NewTripScreen extends StatelessWidget {
  const NewTripScreen({super.key});

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
              onPressed: () => openScreen(
                context,
                const SectionScreen(section: Section.drivers),
              ),
              child: const Text('Ir a conductores'),
            ),
          ),
          const OutlinedButton(onPressed: null, child: Text('Camión activo')),
          const SecondaryText('Necesitas al menos un camión activo.'),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: OutlinedButton(
              onPressed: () => openScreen(
                context,
                const SectionScreen(section: Section.vehicles),
              ),
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

class WaypointPanel extends StatelessWidget {
  const WaypointPanel(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    final point = title.toLowerCase();
    const coordinates = TextInputType.numberWithOptions(
      decimal: true,
      signed: true,
    );
    return Panel(
      title,
      children: [
        Field('Dirección de $point'),
        Field('Latitud de $point', keyboardType: coordinates),
        Field('Longitud de $point', keyboardType: coordinates),
      ],
    );
  }
}

class TraktoPage extends StatelessWidget {
  const TraktoPage(
    this.title,
    this.subtitle, {
    super.key,
    required this.children,
    this.spacing = 12,
  });

  final String title;
  final String subtitle;
  final List<Widget> children;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      top: false,
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 680),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            children: [
              Column(
                spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              for (final child in children) ...[
                SizedBox(height: spacing),
                child,
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class Panel extends StatelessWidget {
  const Panel(this.title, {super.key, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Column(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          ...children,
        ],
      ),
    );
  }
}

class EmptyPanel extends StatelessWidget {
  const EmptyPanel(this.title, this.detail, {super.key});

  final String title;
  final String detail;

  @override
  Widget build(BuildContext context) =>
      Panel(title, children: [SecondaryText(detail)]);
}

class SecondaryText extends StatelessWidget {
  const SecondaryText(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      text,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(this.label, {super.key, this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => FilledButton(
    style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(48)),
    onPressed: onPressed,
    child: Text(label),
  );
}

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
