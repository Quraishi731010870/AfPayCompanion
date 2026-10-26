import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/widgets/common.dart';
import '../../../l10n/app_localizations.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const _mapsEnabled = bool.fromEnvironment('GOOGLE_MAPS_ENABLED');
  static const _kabul = LatLng(34.5553, 69.2075);
  int selected = 0;
  GoogleMapController? mapController;
  late final Future<List<ConnectivityResult>> connectivity;
  final filters = const ['All', 'ATM', 'POS', 'Banks', 'Agents'];
  final places = const [
    ('ATM', 'Demo ATM — Shahr-e-Naw', '0.8 km', Icons.local_atm_rounded),
    (
      'Bank',
      'Bank directory location',
      '1.2 km',
      Icons.account_balance_rounded,
    ),
    ('POS', 'Demo merchant POS', '1.7 km', Icons.point_of_sale_rounded),
  ];

  @override
  void initState() {
    super.initState();
    connectivity = Connectivity().checkConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final visible = selected == 0
        ? places
        : places
              .where(
                (p) => p.$1.toLowerCase().startsWith(
                  filters[selected].toLowerCase().replaceAll('s', ''),
                ),
              )
              .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(l.map),
        actions: [
          IconButton(
            onPressed: () => context.push('/search'),
            icon: const Icon(Icons.search_rounded),
            tooltip: l.search,
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 48,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (_, i) => ChoiceChip(
                label: Text(filters[i]),
                selected: selected == i,
                onSelected: (_) => setState(() => selected = i),
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: FutureBuilder<List<ConnectivityResult>>(
                    future: connectivity,
                    builder: (_, snapshot) {
                      final online =
                          snapshot.data?.any(
                            (x) => x != ConnectivityResult.none,
                          ) ??
                          false;
                      return _buildMapSurface(online);
                    },
                  ),
                ),
                const Positioned(
                  top: 18,
                  left: 18,
                  right: 18,
                  child: SampleDataBanner(
                    text: 'Demo locations — not live operational information',
                  ),
                ),
                PositionedDirectional(
                  end: 18,
                  bottom: 18,
                  child: FloatingActionButton.small(
                    heroTag: 'location',
                    onPressed: _goToCurrentLocation,
                    child: const Icon(Icons.my_location_rounded),
                  ),
                ),
              ],
            ),
          ),
          Container(
            constraints: const BoxConstraints(maxHeight: 245),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(28),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .1),
                  blurRadius: 28,
                  offset: const Offset(0, -6),
                ),
              ],
            ),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        l.nearbyServices,
                        style: Theme.of(context).textTheme.titleLarge
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                    ),
                    TextButton(
                      onPressed: () => context.push('/search'),
                      child: Text(l.manualSearch),
                    ),
                  ],
                ),
                if (visible.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(l.noResults, textAlign: TextAlign.center),
                  )
                else
                  for (final p in visible)
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary
                              .withValues(alpha: .1),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(
                          p.$4,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      title: Text(
                        p.$2,
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                      subtitle: Text('${p.$1} • ${p.$3}'),
                      trailing: IconButton(
                        onPressed: () => _openDirections(p.$2),
                        icon: const Icon(Icons.directions_outlined),
                      ),
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapSurface(bool online) {
    if (_mapsEnabled && online) {
      const markers = [
        (
          'Demo ATM — Shahr-e-Naw',
          LatLng(34.5377, 69.1717),
          BitmapDescriptor.hueAzure,
        ),
        (
          'Bank directory location',
          LatLng(34.5484, 69.1845),
          BitmapDescriptor.hueGreen,
        ),
        (
          'Demo merchant POS',
          LatLng(34.5206, 69.1792),
          BitmapDescriptor.hueOrange,
        ),
      ];
      return GoogleMap(
        initialCameraPosition: const CameraPosition(target: _kabul, zoom: 12.4),
        onMapCreated: (controller) => mapController = controller,
        myLocationButtonEnabled: false,
        mapToolbarEnabled: false,
        markers: markers.indexed
            .map(
              (entry) => Marker(
                markerId: MarkerId('demo-${entry.$1}'),
                position: entry.$2.$2,
                icon: BitmapDescriptor.defaultMarkerWithHue(entry.$2.$3),
                infoWindow: InfoWindow(
                  title: entry.$2.$1,
                  snippet: 'Demo location — verify before travel',
                ),
              ),
            )
            .toSet(),
      );
    }
    return Stack(
      children: [
        Positioned.fill(
          child: CustomPaint(
            painter: _MapPainter(Theme.of(context).colorScheme),
          ),
        ),
        Positioned(
          top: 120,
          left: 68,
          child: _Pin(
            icon: Icons.local_atm_rounded,
            active: selected == 0 || selected == 1,
          ),
        ),
        Positioned(
          top: 205,
          right: 72,
          child: _Pin(
            icon: Icons.account_balance_rounded,
            active: selected == 0 || selected == 3,
          ),
        ),
        Positioned(
          top: 292,
          left: 135,
          child: _Pin(
            icon: Icons.point_of_sale_rounded,
            active: selected == 0 || selected == 2,
          ),
        ),
        Positioned(
          left: 18,
          right: 18,
          bottom: 18,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface
                  .withValues(alpha: .94),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Icon(
                  online ? Icons.key_off_outlined : Icons.offline_bolt_outlined,
                  size: 20,
                ),
                const SizedBox(width: 9),
                Expanded(
                  child: Text(
                    online
                        ? 'Add a restricted Google Maps API key to enable the live map.'
                        : 'Offline mode — showing cached service records without live map tiles.',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _goToCurrentLocation() async {
    if (!_mapsEnabled || mapController == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Live location is available after Google Maps is configured and online.',
          ),
        ),
      );
      return;
    }
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Location permission denied. You can still search manually.',
            ),
          ),
        );
      }
      return;
    }
    final position = await Geolocator.getCurrentPosition();
    await mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(position.latitude, position.longitude),
        15,
      ),
    );
  }

  Future<void> _openDirections(String label) async {
    final uri = Uri.https('www.google.com', '/maps/search/', {
      'api': '1',
      'query': '$label, Kabul, Afghanistan',
    });
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication) &&
        mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to open Google Maps.')),
      );
    }
  }
}

class _Pin extends StatelessWidget {
  const _Pin({required this.icon, required this.active});
  final IconData icon;
  final bool active;
  @override
  Widget build(BuildContext context) => AnimatedScale(
    scale: active ? 1 : .72,
    duration: const Duration(milliseconds: 220),
    child: AnimatedOpacity(
      opacity: active ? 1 : .25,
      duration: const Duration(milliseconds: 220),
      child: Container(
        padding: const EdgeInsets.all(11),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 3),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .18),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: 22),
      ),
    ),
  );
}

class _MapPainter extends CustomPainter {
  const _MapPainter(this.scheme);
  final ColorScheme scheme;
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawColor(scheme.surfaceContainerLowest, BlendMode.src);
    final block = Paint()..color = scheme.primary.withValues(alpha: .055);
    for (var y = 20.0; y < size.height; y += 88) {
      for (var x = (y ~/ 88).isEven ? 18.0 : 58.0; x < size.width; x += 105) {
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(x, y, 70, 48),
            const Radius.circular(8),
          ),
          block,
        );
      }
    }
    final road = Paint()
      ..color = scheme.surface
      ..strokeWidth = 16
      ..style = PaintingStyle.stroke;
    final path = Path()
      ..moveTo(-20, size.height * .72)
      ..quadraticBezierTo(
        size.width * .35,
        size.height * .38,
        size.width + 20,
        size.height * .5,
      );
    canvas.drawPath(path, road);
    final minor = Paint()
      ..color = scheme.surface
      ..strokeWidth = 9
      ..style = PaintingStyle.stroke;
    canvas.drawLine(
      Offset(size.width * .25, 0),
      Offset(size.width * .58, size.height),
      minor,
    );
  }

  @override
  bool shouldRepaint(covariant _MapPainter oldDelegate) =>
      oldDelegate.scheme != scheme;
}
