import 'package:Fit_Mode/services/camera_view.dart';
import 'package:Fit_Mode/services/pose_painter.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class arm_press extends StatefulWidget {
  const arm_press({Key? key}) : super(key: key);

  @override
  _arm_pressState createState() => _arm_pressState();
}

class _arm_pressState extends State<arm_press> {
  PoseDetector poseDetector = GoogleMlKit.vision.poseDetector();
  final PoseLandmarkType leftpos1 = PoseLandmarkType.leftShoulder;
  final PoseLandmarkType leftpos2 = PoseLandmarkType.leftElbow;
  final PoseLandmarkType leftpos3 = PoseLandmarkType.leftWrist;

  final PoseLandmarkType rightpos1 = PoseLandmarkType.rightShoulder;
  final PoseLandmarkType rightpos2 = PoseLandmarkType.rightElbow;
  final PoseLandmarkType rightpos3 = PoseLandmarkType.rightWrist;

  bool isBusy = false;
  CustomPaint? customPaint;
  Future<void> storeCalories() async {
    print("Calories Counted");
    calculate('arm_press');
  }

  Future<void> calculate(key) async {
    final prefs = await SharedPreferences.getInstance();
    var calories = prefs.getInt(key.toString()) ?? 0;
    var cal = calories + (counter * 0.02).toInt();
    prefs.setInt(key.toString(), cal);
    print("Calories Counted:${cal}");
  }

  @override
  void initState() {
    ResetValue();
    super.initState();
  }

  void dispose() async {
    super.dispose();
    await storeCalories();
    await poseDetector.close();
  }

  @override
  Widget build(BuildContext context) {
    return CameraView(
        customPaint: customPaint,
        onImage: (inputImage) {
          processImage(inputImage);
        });
  }

  Future<void> processImage(InputImage inputImage) async {
    if (isBusy) return;
    isBusy = true;
    final poses = await poseDetector.processImage(inputImage);
    // final faces = await faceDetector.processImage(inputImage);
    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      final painter = PosePainter(
        poses,
        inputImage.inputImageData!.size,
        inputImage.inputImageData!.imageRotation,
        50,
        70,
        120,
        140,
        leftpos1,
        leftpos2,
        leftpos3,
        rightpos1,
        rightpos2,
        rightpos3,
      );

      customPaint = CustomPaint(painter: painter);
    } else {
      customPaint = null;
    }
    isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}