import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:lottie/lottie.dart';
import 'package:test_ui/screens/profilescreen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with TickerProviderStateMixin {
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  GoogleMapController? _controller;
  final Location _location = Location();
  bool isExpanded = false;
  bool showProfileText = false; // Track visibility of profile text

  late AnimationController _animationController;
  final List<String> _animationPaths = [
    'assets/images/Animation - 1720338527272.json',
  ];
  final int _currentAnimationIndex = 0;

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
    _location.onLocationChanged.listen((l) {
      _controller?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(l.latitude!, l.longitude!),
            zoom: 15.0,
          ),
        ),
      );
    });
  }

  void _toggleSheet() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  Widget _buildServiceContainer(String image, String text) {
    return Container(
      width: 100,
      height: 80,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 225, 225, 225),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 50,
            width: 80,
          ),
          const SizedBox(height: 5),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: _kGooglePlex,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
          Positioned(
            top: 50,
            left: 16,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AccountScreen(),
                  ),
                );
              },
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://img.freepik.com/free-psd/3d-illustration-human-avatar-profile_23-2150671142.jpg?t=st=1720343478~exp=1720347078~hmac=23eacdd0e71bbc7b20ce6c6032432bf694553fd0d8d184ec2f0f2aa5c15cb5a8&w=740',
                ),
                radius: 25,
              ),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.2,
            minChildSize: 0.1,
            maxChildSize: 0.8,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(16.0)),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: _toggleSheet,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            isExpanded
                                ? Icons.keyboard_arrow_down
                                : Icons.keyboard_arrow_up,
                            size: 30,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Hi, Gajenn Singh',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Pick Services',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              'Go anywhere and get Anything',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildServiceContainer(
                                  "assets/images/image 3 (no bg).png",
                                  'Car',
                                ),
                                _buildServiceContainer(
                                  "assets/images/image 5 (no bg) (1).png",
                                  'Intercity',
                                ),
                                _buildServiceContainer(
                                  "assets/images/image 6.png",
                                  'Reserve',
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildServiceContainer(
                                  "assets/images/image 10.png",
                                  'Travel',
                                ),
                                _buildServiceContainer(
                                  "assets/images/image 5 (no bg).png",
                                  'Intracity',
                                ),
                                _buildServiceContainer(
                                  "assets/images/image 4 (1).png",
                                  'Package',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: AnimatedBuilder(
                          animation: _animationController,
                          builder: (context, child) {
                            return Lottie.asset(
                              _animationPaths[_currentAnimationIndex],
                              height: 250,
                              width: 550,
                              animate: true,
                              repeat: true,
                              frameRate: const FrameRate(360),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
