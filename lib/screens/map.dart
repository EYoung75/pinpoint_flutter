import 'dart:async';

import "package:flutter/material.dart";
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map extends StatefulWidget {
  @override
  final place;
  Map(this.place);

  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  Completer<GoogleMapController> _controller = Completer();

  LatLng _center = LatLng(37.7825, -122.4077);

  void initState() {
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    print("LOCATION: ${widget.place["location"]["lat"]}");
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: LatLng(widget.place["location"]["lat"], widget.place["location"]["lng"]),
        zoom: 18.0,
      ),
    );
  }
}
