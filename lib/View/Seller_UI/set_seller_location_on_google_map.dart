import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:milk_zilla/res/my_colors.dart';

class SetSellerLocationOnGoogleMap extends StatefulWidget {
  const SetSellerLocationOnGoogleMap({super.key});

  @override
  State<SetSellerLocationOnGoogleMap> createState() =>
      _SetSellerLocationOnGoogleMapState();
}

class _SetSellerLocationOnGoogleMapState
    extends State<SetSellerLocationOnGoogleMap> {
  //=====================================
  // Google Map Controller
  Completer<GoogleMapController> _controller = Completer();

  // initial Camera and marker position
  LatLng _markerPosition = LatLng(30.3753, 69.3451);

// for connverting coardinates to address
  late List<Placemark> placemarks;

  // latitude and longitude for sending back to Cart Screen
  List<double> latitudeLongitude = List.empty(growable: true);

  @override
  void initState() {
    showCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          // initial position on map
          initialCameraPosition:
              CameraPosition(target: _markerPosition, zoom: 14),
          mapType: MapType.normal,
          //myLocationButtonEnabled: true,
          //compassEnabled: true,
          myLocationEnabled: true,
          // setting multiple markers on map
          markers: {
            Marker(
              markerId: MarkerId('marker_1'),
              position: _markerPosition,
              draggable: true,
              onDragEnd: _onMarkerDragEnd,
            ),
          },
          // controller of the map
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),

      // move camera to a specific location
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColors.kSecondary,
        child: Icon(
          Icons.check,
          color: MyColors.kPrimary,
        ),
        onPressed: () async {
          Navigator.pop(context, latitudeLongitude);
          // GoogleMapController controller = await _controller.future;
          // controller.animateCamera(
          //   CameraUpdate.newCameraPosition(
          //     CameraPosition(
          //       target: LatLng(34.0151, 71.5250),
          //       zoom: 14,
          //     ),
          //   ),
          // );
        },
      ),
    );
  }

  showCurrentLocation() async {
    getUserCurrentLocation().then((value) async {
      print("My Current Location");
      print("longitude : " +
          value.latitude.toString() +
          " Latitude : " +
          value.latitude.toString());
      // my location on camera position
      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(value.latitude, value.longitude),
        zoom: 10,
      );
      // using controller controll the map
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      _markerPosition = LatLng(value.latitude, value.longitude);
      latitudeLongitude.add(_markerPosition.latitude);
      latitudeLongitude.add(_markerPosition.longitude);

      setState(() {});
    });
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

  void _onMarkerDragEnd(LatLng position) async {
    setState(() {
      _markerPosition = position;
      latitudeLongitude = List.empty(growable: true);
      latitudeLongitude.add(_markerPosition.latitude);
      latitudeLongitude.add(_markerPosition.longitude);
    });
    print(
        'Marker position: ${_markerPosition.latitude}, ${_markerPosition.longitude}');

    placemarks = await placemarkFromCoordinates(
        _markerPosition.latitude, _markerPosition.longitude);

    print("Marker Address : ${placemarks[0]}");
  }
}
