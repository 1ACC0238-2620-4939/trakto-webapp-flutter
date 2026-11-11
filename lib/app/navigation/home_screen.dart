import 'package:flutter/material.dart';
import 'package:trakto_route_flutter/app/navigation/trakto_navigation.dart';
import 'package:trakto_route_flutter/features/trips/presentation/screens/trips_screen.dart';
import 'package:trakto_route_flutter/features/trips/presentation/screens/new_trip_screen.dart';
import 'package:trakto_route_flutter/features/drivers/presentation/screens/drivers_screen.dart';
import 'package:trakto_route_flutter/features/vehicles/presentation/screens/vehicles_screen.dart';
import 'package:trakto_route_flutter/features/profiles/presentation/screens/profiles_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: traktoBar(context),
    body: IndexedStack(
      index: selectedIndex,
      sizing: StackFit.expand,
      children: [
        TripsScreen(
          onNewTrip: () => openScreen(
            context,
            NewTripScreen(
              onManageDrivers: (context) =>
                  openScreen(context, const DriversScreen()),
              onManageVehicles: (context) =>
                  openScreen(context, const VehiclesScreen()),
            ),
          ),
        ),
        const DriversScreen(),
        const VehiclesScreen(),
        const ProfilesScreen(),
      ],
    ),
    bottomNavigationBar: NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: (index) {
        setState(() => selectedIndex = index);
      },
      destinations: const [
        NavigationDestination(icon: Icon(Icons.route), label: 'Viajes'),
        NavigationDestination(
          icon: Icon(Icons.person_outline),
          label: 'Conductores',
        ),
        NavigationDestination(
          icon: Icon(Icons.local_shipping_outlined),
          label: 'Camiones',
        ),
        NavigationDestination(
          icon: Icon(Icons.badge_outlined),
          label: 'Perfiles',
        ),
      ],
    ),
  );
}
