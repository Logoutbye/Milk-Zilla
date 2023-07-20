import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:milk_zilla/res/my_colors.dart';

class CustomerDeliveryLocation extends StatefulWidget {
  CustomerDeliveryLocation(
      {super.key,
      required this.latitudeOfCustomer,
      required this.longitudeOfCustomer,
      required this.customerName});

  double latitudeOfCustomer;
  double longitudeOfCustomer;
  String customerName;

  @override
  State<CustomerDeliveryLocation> createState() =>
      _CustomerDeliveryLocationState();
}

class _CustomerDeliveryLocationState extends State<CustomerDeliveryLocation> {
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
    //storeLatitudeAndLongitudeOfCustomer();
    showCurrentLocation();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Utils.flushBarErrorMessage(
    //     '${widget.latitudeOfCustomer} : ${widget.longitudeOfCustomer}',
    //     context);
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          // initial position on map
          initialCameraPosition:
              CameraPosition(target: _markerPosition, zoom: 20),
          mapType: MapType.normal,
          //myLocationButtonEnabled: true,
          //compassEnabled: true,
          myLocationEnabled: true,
          // setting multiple markers on map
          markers: {
            Marker(
              markerId: MarkerId('marker_1'),
              position: _markerPosition,
              //draggable: true,
              //onDragEnd: _onMarkerDragEnd,
              infoWindow: InfoWindow(
                title: "My Current Location",
              ),
            ),
            Marker(
                markerId: MarkerId('marker_2'),
                position: LatLng(
                    widget.latitudeOfCustomer, widget.longitudeOfCustomer),
                draggable: true,
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueGreen),
                infoWindow: InfoWindow(
                    title: "Destination",
                    snippet: "Location of ${widget.customerName}")
                //onDragEnd: _onMarkerDragEnd,
                ),
          },

          polylines: {
            Polyline(
              polylineId: PolylineId('1'),
              color: Colors.orange,
              points: [
                _markerPosition,
                LatLng(widget.latitudeOfCustomer, widget.longitudeOfCustomer),
              ],
            ),
          },
          // controller of the map
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),

      // move camera to a specific location
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColors.kSecondary,
        child: Icon(
          Icons.arrow_back,
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
}
