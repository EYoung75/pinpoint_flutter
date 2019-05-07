import 'dart:async';

import "package:flutter/material.dart";
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map extends StatefulWidget {
  final place;
  Map(this.place);

  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  Completer<GoogleMapController> _controller = Completer();
  LatLng _center;
  LatLng _offset;
  Set<Marker> _markers = {};

  void initState() {
    super.initState();
    setState(() {
      _center = LatLng(
          widget.place["location"]["lat"], widget.place["location"]["lng"]);
      _offset = LatLng(widget.place["location"]["lat"] + .0009,
          widget.place["location"]["lng"]);
      _markers.add(Marker(
          markerId: MarkerId(_center.toString()),
          position: _center,
          infoWindow: InfoWindow(
            title: widget.place["location"]["address"],
            snippet: "4 star rating",
          ),
          onTap: () {
            CameraPosition(target: _offset);
          },
          consumeTapEvents: false,
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)));
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      tiltGesturesEnabled: false,
      markers: _markers,
      myLocationButtonEnabled: false,
      rotateGesturesEnabled: false,
      scrollGesturesEnabled: false,
      zoomGesturesEnabled: false,
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: _offset,
        zoom: 18.0,
      ),
    );
  }
}
