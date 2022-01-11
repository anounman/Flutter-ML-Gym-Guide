import 'package:Fit_Mode/pages/HomeScreen.dart';
import 'package:Fit_Mode/services/pose_painter.dart';
import 'package:Fit_Mode/workouts/arm_press.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import '../main.dart';

class CameraView extends StatefulWidget {
  CameraView(
      {Key? key,
      required this.customPaint,
      required this.onImage,
      this.initialDirection = CameraLensDirection.front})
      : super(key: key);

  final CustomPaint? customPaint;
  final Function(InputImage inputImage) onImage;
  final CameraLensDirection initialDirection;

  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  CameraController? _controller;
  int _cameraIndex = 1;
  bool stream = false;

  @override
  void initState() {
    super.initState();
    stream = false;
    try {
      _startLiveFeed();
    } catch (e) {}
  }

  @override
  void dispose() async {
    super.dispose();
    print("Before Dispose:$_controller");
    if (stream) {
      await _controller?.stopImageStream();
    }
    await _controller?.dispose();
    _controller = null;
    print("After Dispose:$_controller");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _liveFeedBody(),
            Container(
              color: align ? Colors.green : Colors.red,
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(counter.toString()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _liveFeedBody() {
    if (_controller?.value.isInitialized == false) {
      return Center(
        child: CircularProgressIndicator(
          color: Colors.red,
        ),
      );
    }
    return Container(
      height: MediaQuery.of(context).size.height - 50,
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          CameraPreview(_controller!),
          if (widget.customPaint != null) widget.customPaint!,
        ],
      ),
    );
  }

  Future _startLiveFeed() async {
    final camera = cameras![_cameraIndex];
    _controller = CameraController(
      camera,
      ResolutionPreset.high,
      imageFormatGroup: ImageFormatGroup.yuv420,
      enableAudio: false,
    );
    _controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _controller!.startImageStream(_processCameraImage).catchError((e) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        });
        stream != stream;
      });
    });
  }

  Future _processCameraImage(CameraImage image) async {
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    final Size imageSize =
        Size(image.width.toDouble(), image.height.toDouble());

    final camera = cameras![_cameraIndex];
    final imageRotation =
        InputImageRotationMethods.fromRawValue(camera.sensorOrientation) ??
            InputImageRotation.Rotation_0deg;

    final inputImageFormat =
        InputImageFormatMethods.fromRawValue(image.format.raw) ??
            InputImageFormat.YUV420;

    final planeData = image.planes.map(
      (Plane plane) {
        return InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width,
        );
      },
    ).toList();

    final inputImageData = InputImageData(
      size: imageSize,
      imageRotation: imageRotation,
      inputImageFormat: inputImageFormat,
      planeData: planeData,
    );

    final inputImage =
        InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);

    widget.onImage(inputImage);
  }
}
