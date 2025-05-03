import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapPage extends StatefulWidget {
  final List<Map<String, String>> gymsNearMe;

  const MapPage({super.key, required this.gymsNearMe});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;
  LatLng? userLocation;

  @override
  void initState() {
    super.initState();
    getUserLocation();
  }

  Future<void> getUserLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      userLocation = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    final gym = widget.gymsNearMe.first;
    final double lat = double.parse(gym['latitude']!);
    final double lng = double.parse(gym['longitude']!);
    final LatLng gymLocation = LatLng(lat, lng);

    return Scaffold(
      appBar: AppBar(
        title: Text(gym['title'] ?? 'Gym Location'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: gymLocation,
          zoom: 14,
        ),
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
        markers: {
          Marker(
            markerId: MarkerId("gym"),
            position: gymLocation,
            infoWindow: InfoWindow(
              title: gym['title'],
              snippet: gym['address'],
            ),
          ),
          if (userLocation != null)
            Marker(
              markerId: MarkerId("user"),
              position: userLocation!,
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
              infoWindow: InfoWindow(title: 'You'),
            ),
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: true,
        zoomGesturesEnabled: true,
        scrollGesturesEnabled: true,
        rotateGesturesEnabled: true,
        tiltGesturesEnabled: true,
      ),
    );
  }
}