import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as lat_lng;

import 'package:great_places/models/place.dart';

class MapScreen extends StatefulWidget {
  const MapScreen(
      {Key? key,
      this.initialLocation = const PlaceLocation(
        latitude: -27.6612008699,
        longitude: -48.4910024556,
      ),
      this.isSelecting = false})
      : super(key: key);

  final PlaceLocation initialLocation;
  final bool isSelecting;

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  lat_lng.LatLng? _pickedLocation;

  void _selectLocation(lat_lng.LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Map'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: _pickedLocation == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_pickedLocation);
                    },
              icon: const Icon(Icons.check),
            ),
        ],
      ),
      body: FlutterMap(
        options: MapOptions(
          center: lat_lng.LatLng(widget.initialLocation.latitude,
              widget.initialLocation.longitude),
          zoom: 16.0,
          onTap: (tapPos, latAndLng) => _selectLocation(latAndLng),
        ),
        layers: [
          TileLayerOptions(
            urlTemplate:
                'https://api.mapbox.com/styles/v1/reneengels/ckxqdzgrk1fx514nm9vn7jb15/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoicmVuZWVuZ2VscyIsImEiOiJja3hxZDIyMmk0cHRpMnJreTVwNzRoYnRlIn0.iY9IPyiIr0Qu4bajDuquEQ',
            additionalOptions: {
              'accessToken':
                  'pk.eyJ1IjoicmVuZWVuZ2VscyIsImEiOiJja3hxZDIyMmk0cHRpMnJreTVwNzRoYnRlIn0.iY9IPyiIr0Qu4bajDuquEQ',
              'id': 'mapbox.mapbox-streets-v8',
            },
          ),
          MarkerLayerOptions(
            markers: [
              (_pickedLocation == null && widget.isSelecting)
                  ? Marker(
                      builder: (ctx) => const Center(),
                      point: lat_lng.LatLng(0, 0))
                  : Marker(
                      width: 80.0,
                      height: 80.0,
                      point: _pickedLocation == null
                          ? lat_lng.LatLng(widget.initialLocation.latitude,
                              widget.initialLocation.longitude)
                          : lat_lng.LatLng(_pickedLocation!.latitude,
                              _pickedLocation!.longitude),
                      builder: (ctx) => const Center(
                        child: Icon(Icons.location_pin),
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
