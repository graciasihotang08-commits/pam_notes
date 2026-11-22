import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class _Place {
  final String name;
  final LatLng point;
  const _Place(this.name, this.point);
}

const _places = [
  _Place('Institut Teknologi Del', LatLng(2.385245, 99.147824)),
  _Place('Horatio Guesthouse', LatLng(2.383161, 99.148106)),
  _Place('Gasa Ribu', LatLng(2.37213, 99.14706)),
];


class CampusMap extends StatelessWidget {
  const CampusMap({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(initialCenter: _places.first.point, initialZoom: 15),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'del.ac.id.pam_notes',
        ),
        MarkerLayer(
          markers: _places
              .map(
                (p) => Marker(
                  point: p.point,
                  width: 44,
                  height: 44,
                  child: GestureDetector(
                    onTap: () =>
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(p.name))),
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 44,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        const RichAttributionWidget(
          attributions: [TextSourceAttribution('© OpenStreetMap contributors')],
        ),
      ],
    );
  }
}
