import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

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

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async {
    controller = CameraController(
      cameras[0], // kamera belakang
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
        title: const Text("Camera Advance"),
      ),
      body: isCameraReady
          ? Column(
              children: [
                Expanded(
                  child: CameraPreview(controller),
                ),
                ElevatedButton(
                  onPressed: takePicture,
                  child: const Text("Ambil Foto"),
                ),
                const SizedBox(height: 20),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}