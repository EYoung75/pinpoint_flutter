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
  LatLng _center;
  Set<Marker> _markers = {};

  void initState() {
    super.initState();
    setState(() {
      _center = LatLng(widget.place["location"]["lat"], widget.place["location"]["lng"]);
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_center.toString()),
        position: _center,
        infoWindow: InfoWindow(
          title: widget.place["name"],
          snippet: '4 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
      _center = LatLng(widget.place["location"]["lat"]+.0009, widget.place["location"]["lng"]);
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    print("LOCATION: ${widget.place["location"]["lat"]}");
    
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      markers: _markers,
      myLocationButtonEnabled: false,
      rotateGesturesEnabled: false,
      scrollGesturesEnabled: false,
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: _center,
        zoom: 18.0,
      ),
    );
  }
}
