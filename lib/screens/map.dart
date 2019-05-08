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
      _center = LatLng(widget.place["geometry"]["location"]["lat"],
          widget.place["geometry"]["location"]["lng"]);
      _offset = LatLng(widget.place["geometry"]["location"]["lat"] + .0009,
          widget.place["geometry"]["location"]["lng"]);
      _markers.add(Marker(
          markerId: MarkerId(_center.toString()),
          position: _center,
          infoWindow: InfoWindow(
            title: widget.place["name"],
            snippet: widget.place["formatted_address"],
          ),
          onTap: () {
            CameraPosition(target: _offset);
          },
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
      // scrollGesturesEnabled: false,
      zoomGesturesEnabled: false,
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: _offset,
        zoom: 18.0,
      ),
    );
  }
}
