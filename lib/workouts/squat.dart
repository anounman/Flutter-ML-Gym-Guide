import 'package:Fit_Mode/services/camera_view.dart';
import 'package:Fit_Mode/services/pose_painter.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class squat extends StatefulWidget {
  const squat({Key? key}) : super(key: key);

  @override
  _squatState createState() => _squatState();
}

class _squatState extends State<squat> {
  PoseDetector poseDetector = GoogleMlKit.vision.poseDetector();
  bool isBusy = false;
  CustomPaint? customPaint;
  Future<void> storeCalories() async {
    print("Calories Counted");
    final prefs = await SharedPreferences.getInstance();
    var calories = prefs.getInt('squat') ?? 0;
    var cal = calories + (counter * 0.2).toInt();
    prefs.setInt('squat', cal);
    print("Counter: $counter \n Calories: $cal");
  }

  @override
  void initState() {
    ResetValue();
    super.initState();
  }

  @override
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
    final PoseLandmarkType leftpos1 = PoseLandmarkType.leftHip;
    final PoseLandmarkType leftpos2 = PoseLandmarkType.leftKnee;
    final PoseLandmarkType leftpos3 = PoseLandmarkType.leftAnkle;

    final PoseLandmarkType rightpos1 = PoseLandmarkType.rightHip;
    final PoseLandmarkType rightpos2 = PoseLandmarkType.rightKnee;
    final PoseLandmarkType rightpos3 = PoseLandmarkType.rightAnkle;

    // final faces = await faceDetector.processImage(inputImage);
    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      final painter = PosePainter(
          poses,
          inputImage.inputImageData!.size,
          inputImage.inputImageData!.imageRotation,
          75,
          80,
          160,
          180,
          leftpos1,
          leftpos2,
          leftpos3,
          rightpos1,
          rightpos2,
          rightpos3);
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
