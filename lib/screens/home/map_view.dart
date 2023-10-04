import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:real_estate/utils/c_extensions.dart';

import '../../model/m_place.dart';
import '../../utils/resizer/fetch_pixels.dart';
import '../../widget/appbar/first_appbar.dart';
import 'home_detail_view.dart';

class MapView extends StatelessWidget {
  final List<PlaceModel> place;

  MapView({super.key, required this.place});

  MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: FetchPixels.getPixelHeight(8),
              horizontal: FetchPixels.getPixelHeight(16),
            ),
            child: const FirstAppBar(title: 'Map View'),
          ),
          Expanded(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                center: LatLng(20.5937, 78.9629),
                zoom: 5,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                MarkerLayer(
                    markers: place
                        .map(
                          (item) => Marker(
                            point: LatLng(item.latitude!, item.longitude!),
                            builder: (context) => GestureDetector(
                              onTap: () {
                                Get.to(
                                  () => HomeDetailView(
                                    placeData: item,
                                  ),
                                );
                              },
                              child: Image(
                                image: AssetImage("home_marker".png),
                              ),
                            ),
                          ),
                        )
                        .toList()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
