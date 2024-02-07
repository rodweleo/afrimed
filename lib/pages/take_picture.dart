import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class TakePicture extends StatefulWidget {
  const TakePicture({super.key, required this.camera});
  final CameraDescription camera;
  @override
  State<TakePicture> createState() => _TakePictureState();
}

class _TakePictureState extends State<TakePicture> {
  late CameraController _cameracontroller;
  late Future<void> _initializeControllerFuture;

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _cameracontroller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _cameracontroller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _cameracontroller.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take a picture')),
      body: Column(
        children: [
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // If the Future is complete, display the preview.
                return CameraPreview(_cameracontroller);
              } else {
                // Otherwise, display a loading indicator.
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          FloatingActionButton(
            // Provide an onPressed callback.
            onPressed: () async {
              // Take the Picture in a try / catch block. If anything goes wrong,
              // catch the error.
              try {
                // Ensure that the camera is initialized.
                await _initializeControllerFuture;

                // Attempt to take a picture and get the file `image`
                // where it was saved.
                final image = await _cameracontroller.takePicture();

                if (!mounted) return;

                // If the picture was taken, display it on a new screen.

              } catch (e) {
                // If an error occurs, log the error to the console.
                print(e);
              }
            },
            child: const Icon(Icons.camera_alt),
          ),
        ],
      ),
    );
  }
}
