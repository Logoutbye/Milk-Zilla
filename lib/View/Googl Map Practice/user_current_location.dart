import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetUserCurrentLocation extends StatefulWidget {
  const GetUserCurrentLocation({super.key});

  @override
  State<GetUserCurrentLocation> createState() => _GetUserCurrentLocationState();
}

class _GetUserCurrentLocationState extends State<GetUserCurrentLocation> {
  // Google Map Controller
  Completer<GoogleMapController> _controller = Completer();

  // initial position
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(30.3753, 69.3451),
    zoom: 10,
  );

  List<Marker> _marker = [
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(34.0151, 71.5250),
      infoWindow: InfoWindow(title: "Peshawar"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        markers: Set<Marker>.of(_marker),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.location_on),
        onPressed: () async {
          getUserCurrentLocation().then((value) async {
            print("My Current Location");
            print("longitude : " +
                value.latitude.toString() +
                " Latitude : " +
                value.latitude.toString());
            // adding to marker
            _marker.add(
              Marker(
                markerId: MarkerId('2'),
                position: LatLng(value.latitude, value.longitude),
                infoWindow: InfoWindow(title: "My Current Location"),
              ),
            );

            // my location on camera position
            CameraPosition cameraPosition = CameraPosition(
              target: LatLng(value.latitude, value.longitude),
              zoom: 5,
            );
            // using controller controll the map
            final GoogleMapController controller = await _controller.future;
            controller
                .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
            setState(() {});
          });
        },
      ),
    );
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then(
      (value) {},
    )
        .onError(
      (error, stackTrace) {
        print("Error : " + error.toString());
      },
    );

    return Geolocator.getCurrentPosition();
  }
}
