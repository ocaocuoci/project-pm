import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CameraPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController controller;
  bool isCameraReady = false;

  // 📍 koordinat (contoh: Sidoarjo)
  final LatLng lokasi = LatLng(-7.4478, 112.7183);

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async {
    controller = CameraController(
      cameras[0],
      ResolutionPreset.medium,
    );

    await controller.initialize();

    if (!mounted) return;

    setState(() {
      isCameraReady = true;
    });
  }

  Future<void> takePicture() async {
    if (!controller.value.isInitialized) return;

    final image = await controller.takePicture();
    print("Foto tersimpan di: ${image.path}");
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Camera + Map"),
      ),
      body: isCameraReady
          ? Column(
              children: [
                // 📷 CAMERA
                Expanded(
                  flex: 2,
                  child: CameraPreview(controller),
                ),

                // 📍 MAP
                Expanded(
                  flex: 1,
                  child: FlutterMap(
                    options: MapOptions(
                      initialCenter: lokasi,
                      initialZoom: 13,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: lokasi,
                            width: 40,
                            height: 40,
                            child: const Icon(
                              Icons.location_pin,
                              size: 40,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // 📸 BUTTON
                ElevatedButton(
                  onPressed: takePicture,
                  child: const Text("Ambil Foto"),
                ),
                const SizedBox(height: 10),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}