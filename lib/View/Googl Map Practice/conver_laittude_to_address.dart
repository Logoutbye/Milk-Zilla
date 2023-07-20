import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class ConvertLatToAddress extends StatefulWidget {
  const ConvertLatToAddress({super.key});

  @override
  State<ConvertLatToAddress> createState() => _ConvertLatToAddressState();
}

class _ConvertLatToAddressState extends State<ConvertLatToAddress> {
  String stAddress = '';
  String latlngaddress = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Map'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(stAddress),
          Text(latlngaddress),
          GestureDetector(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                height: 50,
                color: Colors.green,
                child: Center(child: Text("Convert LatLng to address")),
              ),
            ),
            onTap: () async {
              List<Location> locations = await locationFromAddress(
                  "Allama Iqbal Rd, Abbottabad, Khyber Pakhtunkhwa, Pakistan");
              List<Placemark> placemarks =
                  await placemarkFromCoordinates(34.0151, 71.5250);

              setState(() {
                stAddress = locations.last.latitude.toString() +
                    " " +
                    locations.last.longitude.toString();
                latlngaddress =
                    placemarks.reversed.last.administrativeArea.toString();
              });
              // From a query
              // final query =
              //     "Allama Iqbal Rd, Abbottabad, Khyber Pakhtunkhwa, Pakistan";
              // var addresses =
              //     await Geocoder.local.findAddressesFromQuery(query);
              // var firts = addresses.first;
              // print("${firts.featureName} : ${firts.coordinates}");

              // you can access every thing of the address means country code , admin area and every thing
              //=============================
              // from coordinates
              // final coardinates = new Coordinates(34.1495, 73.2115);
              // var address = await Geocoder.local
              //     .findAddressesFromCoordinates(coardinates);
              // var first = address.first;
              // // print(
              //     "First Feature Name : ${first.featureName} ${first.addressLine.toString()}");
            },
          ),
        ],
      ),
    );
  }
}
