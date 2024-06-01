// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '/db/database_helper.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List<Marker> markers = [];
  List<LatLng> routeCoordinates = [];

  @override
  void initState() {
    super.initState();
    loadMarkers();
    loadRouteCoordinates();
  }

  Future<void> loadMarkers() async {
    final dbMarkers = await DatabaseHelper.instance.getCoordinates();
    List<Marker> loadedMarkers = dbMarkers.map((record) {
      return Marker(
        point: LatLng(record['latitude'], record['longitude']),
        width: 80,
        height: 80,
        child: const Icon(
          Icons.location_pin,
          size: 60,
          color: Colors.red,
        ),
      );
    }).toList();
    setState(() {
      markers = loadedMarkers;
    });
  }

  void loadRouteCoordinates() {
    routeCoordinates = [
      const LatLng(40.407621980242745, -3.517071770311644),
      const LatLng(40.409566291824795, -3.516234921159887),
      const LatLng(40.41031785940011, -3.5146041381974897),
      const LatLng(40.412784902661286, -3.513574170010713),
      const LatLng(40.414189933233956, -3.512866066882304),
      const LatLng(40.41686921259544, -3.511127995489052),
      const LatLng(40.41997312229808, -3.5090251437743816),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Map View')),
      body: content(),
    );
  }

  Widget content() {
    return FlutterMap(
      options: const MapOptions(
        center: LatLng(40.407621980242745, -3.517071770311644),
        zoom: 15,
        interactiveFlags: InteractiveFlag.all,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'dev.fleaflet.flutter_map.example',
        ),
        MarkerLayer(markers: markers),
        PolylineLayer(
          polylines: [
            Polyline(
              points: routeCoordinates,
              color: Colors.pink,
              strokeWidth: 8.0,
            ),
          ],
        ),
      ],
    );
  }
}
