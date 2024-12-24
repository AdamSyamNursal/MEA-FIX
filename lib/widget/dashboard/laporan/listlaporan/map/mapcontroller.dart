import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapController extends StatefulWidget {
  final Function(LatLng)? onLocationChanged;

  MapController({this.onLocationChanged});

  @override
  _MapControllerState createState() => _MapControllerState();
}

class _MapControllerState extends State<MapController> {
  LatLng? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.requestPermission();
      return;
    }

    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      await Geolocator.requestPermission();
      return;
    }

    final position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
    );

    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
    });

    // Callback lokasi diperbarui
    if (widget.onLocationChanged != null && _currentPosition != null) {
      widget.onLocationChanged!(_currentPosition!);
    }

    // Popup pemberitahuan
    if (mounted) {
      _showLocationSnackbar(context);
    }
  }

void _showLocationSnackbar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: const Text("Lokasi berhasil diperbarui."),
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.green,
    ),
  );
}


  void _openFullScreenMap() {
    if (_currentPosition == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Lokasi belum tersedia. Cari lokasi terlebih dahulu."),
        ),
      );
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Peta Layar Penuh'),
            backgroundColor: Color(0xFFFF6F00)
          ),
          body: FlutterMap(
            options: MapOptions(
              initialCenter: _currentPosition!,
              initialZoom: 15.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
              ),
MarkerLayer(
  markers: [
    Marker(
      point: _currentPosition!,
      child: Icon(
        Icons.location_on,
        color: Colors.red,
        size: 40,
      ),
    ),
  ],
),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _getCurrentLocation,
            child: const Icon(Icons.my_location),
            backgroundColor: Color(0xFFFF6F00)
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          child: _currentPosition != null
              ? FlutterMap(
                  options: MapOptions(
                    initialCenter: _currentPosition!,
                    initialZoom: 15.0,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: ['a', 'b', 'c'],
                    ),
MarkerLayer(
  markers: [
    Marker(
      point: _currentPosition!,
      child: Icon(
        Icons.location_on,
        color: Colors.red,
        size: 40,
      ),
    ),
  ],
),
                  ],
                )
              : const Center(child: CircularProgressIndicator()),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              onPressed: _getCurrentLocation,
              icon: const Icon(Icons.my_location,color: Colors.white,),
              label: const Text('Cari Lokasi', style: TextStyle(color: Colors.white),),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFF6F00)
              ),
            ),
            ElevatedButton.icon(
              onPressed: _openFullScreenMap,
              icon: const Icon(Icons.fullscreen, color: Colors.white,),
              label: const Text('Peta Layar Penuh'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFF6F00)
              ),
            ),
          ],
        ),
      ],
    );
  }
}









// MarkerLayer(
//   markers: [
//     Marker(
//       point: _currentPosition!,
//       child: Icon(
//         Icons.location_on,
//         color: Colors.red,
//         size: 40,
//       ),
//     ),
//   ],
// ),
