import '/core/utils/string_manager.dart';
import '/core/widgets/custome_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShowLocationOnMapScreen extends StatefulWidget {
  final double? latitude;
  final double? longitude;

  const ShowLocationOnMapScreen({
    Key? key,
     this.latitude,
     this.longitude,
  }) : super(key: key);

  @override
  _ShowLocationOnMapScreenState createState() =>
      _ShowLocationOnMapScreenState();
}

class _ShowLocationOnMapScreenState extends State<ShowLocationOnMapScreen> {
  late GoogleMapController _mapController;

  @override
  Widget build(BuildContext context) {
    final LatLng customLocation = LatLng(widget.latitude??24.7136, widget.longitude??46.6753);

    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.locationText),
      ),
      body: GoogleMap(

        initialCameraPosition: CameraPosition(
          target: customLocation,
          zoom: 14,
        ),
        markers: {
          Marker(

            markerId: const MarkerId('StringManager.locationBookText'),
            position: customLocation,
            infoWindow: const InfoWindow(

              title: StringManager.locationText,
              snippet: StringManager.userLocationBookText,
            ),
          ),
        },
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },
      ),
    );
  }
}

