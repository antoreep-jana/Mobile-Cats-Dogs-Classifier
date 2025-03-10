import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class TFLiteInference {
  Interpreter? _interpreter;

  // Load the TFLite Model
  Future<void> loadModel() async {
    _interpreter = await Interpreter.fromAsset('assets/model_unquant.tflite');
  }

  void closeModel(){
    _interpreter?.close();
  }
}