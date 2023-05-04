import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomWindowMarkerInfo extends StatefulWidget {
  const CustomWindowMarkerInfo({super.key});

  @override
  State<CustomWindowMarkerInfo> createState() => _CustomWindowMarkerInfoState();
}

class _CustomWindowMarkerInfoState extends State<CustomWindowMarkerInfo> {
  // controller of package
  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  // markers
  final List<Marker> _markers = [];
  final List<LatLng> _latlng = [
    LatLng(34.0151, 71.5250),
    LatLng(34.1495, 73.2115),
    LatLng(34.2019, 72.0522),
  ];

  @override
  void initState() {
    // TODO: implement initState
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Custom Window example"),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(34.0151, 71.5250),
            ),
            markers: Set<Marker>.of(_markers),
            onTap: (position) {
              _customInfoWindowController.hideInfoWindow!();
            },
            onCameraMove: (position) {
              _customInfoWindowController.onCameraMove!();
            },
            onMapCreated: (GoogleMapController controller) {
              _customInfoWindowController.googleMapController = controller;
            },
          ),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            height: 300,
            width: 200,
            offset: 35,
          ),
        ],
      ),
    );
  }

// function to load markers
  loadData() {
    for (int i = 0; i < _latlng.length; i++) {
      _markers.add(
        Marker(
          markerId: MarkerId(
            i.toString(),
          ),
          icon: BitmapDescriptor.defaultMarker,
          position: _latlng[i],
          onTap: () {
            _customInfoWindowController.addInfoWindow!(
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://img.freepik.com/premium-psd/rustic-autumnal-flower-illustrations-with-fall-leaf-leaves-colors_351449-506.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Text('My Location'),
              ),
              _latlng[i],
            );
          },
        ),
      );
      setState(() {});
    }
  }
}
