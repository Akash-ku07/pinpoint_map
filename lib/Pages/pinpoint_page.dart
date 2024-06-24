import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class PinpointPage extends StatefulWidget {
  const PinpointPage({super.key});

  @override
  State<PinpointPage> createState() => _PinpointPageState();
}

class _PinpointPageState extends State<PinpointPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PinPoint Map'),
      ),
      body: content(),
    );
  }

  Widget content() {
    return FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(21.4225, 39.8262),
        initialZoom: 13,
        interactionOptions: const InteractionOptions(flags: ~InteractiveFlag.doubleTapZoom),
      ),
      children: [
        openStreetMapTileLayer,
        MarkerLayer(markers: [
          Marker(
            point: LatLng(21.4225, 39.8262),
            width: 60,
            height: 60,
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () => _showBottomSheet(context, 'Mina Camp', 'Mecca, Saudi Arabia'),
              child: Icon(
                Icons.location_pin,
                size: 30,
                color: Colors.red,
              ),
            ),
          ),
          Marker(
            point: LatLng(21.4243, 39.8724),
            width: 60,
            height: 60,
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () => _showBottomSheet(context, 'Camp 45', 'Mecca, Saudi Arabia'),
              child: Icon(
                Icons.location_pin,
                size: 30,
                color: Colors.red,
              ),
            ),
          ),
          Marker(
            point: LatLng(21.4235, 39.8735),
            width: 60,
            height: 60,
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () => _showBottomSheet(context, 'Camp 42-55', 'Mecca, Saudi Arabia'),
              child: Icon(
                Icons.location_pin,
                size: 30,
                color: Colors.red,
              ),
            ),
          ),
        ]),
      ],
    );
  }

  void _showBottomSheet(BuildContext context, String title, String subtitle) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Color(0xFF1A737E),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.house_rounded, color: Colors.white, size: 40),
                    title: Text(
                      title,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    subtitle: Text(
                      subtitle,
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildCustomButton(Icons.directions, 'Direction'),
                      _buildCustomButton(Icons.download, 'Download'),
                      _buildCustomButton(Icons.more_horiz, 'More'),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildCustomButton(IconData icon, String label) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: TextButton.icon(
        onPressed: () {
          // Handle button action
        },
        icon: Icon(icon, color: Color(0xFF1A737E)),
        label: Text(
          label,
          style: TextStyle(color: Color(0xFF1A737E)),
        ),
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
        ),
      ),
    );
  }
}

TileLayer get openStreetMapTileLayer => TileLayer(
  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
  userAgentPackageName: 'dev.fleaflet.flutter_map.example',
);
