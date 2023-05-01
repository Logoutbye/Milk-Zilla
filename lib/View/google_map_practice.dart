import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapPratices extends StatefulWidget {
  const GoogleMapPratices({super.key});

  @override
  State<GoogleMapPratices> createState() => _GoogleMapPraticesState();
}

class _GoogleMapPraticesState extends State<GoogleMapPratices> {
  // Google Map Controller
  Completer<GoogleMapController> _controller = Completer();

  // initial position
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(30.3753, 69.3451),
    zoom: 5,
  );

  // My Map Markers

  List<Marker> _marker = [];
  List<Marker> markerList = [
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(34.0151, 71.5250),
      infoWindow: InfoWindow(title: "Peshawar"),
    ),
    Marker(
      markerId: MarkerId('2'),
      position: LatLng(34.1495, 73.2115),
      infoWindow: InfoWindow(title: "Abbottabad"),
    ),
    Marker(
      markerId: MarkerId('3'),
      position: LatLng(34.2019, 72.0522),
      infoWindow: InfoWindow(title: "Mardan"),
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    _marker.addAll(markerList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        mapType: MapType.normal,
        myLocationButtonEnabled: true,
        compassEnabled: true,
        myLocationEnabled: true,
        markers: Set<Marker>.of(_marker),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
