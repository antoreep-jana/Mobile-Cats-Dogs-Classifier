import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

import "dart:io";
import 'dart:typed_data';

import 'package:image/image.dart' as img;


class TFLiteInference {

  Interpreter? _interpreter;

  // Load the TFLite Model
  Future<void> loadModel() async {
    try{
      _interpreter = await Interpreter.fromAsset('assets/model_unquant.tflite');
      print("Model loaded successfully!");
    }catch (e){
      print("Failed to load model: $e");
      _interpreter = null; // Ensure that it is null if loading fails

    }
  }

  Uint8List? preprocessImage(File imageFile){
    try{
      // Read image as bytes
      //img.Image? image = img.decodeImage(imageFile.readAsBytesSync());
      img.Image? image = img.decodeImage(imageFile.readAsBytesSync());
      if (image == null){
        print("Failed to decode image");
        return null;
      }
      // Resize to model's expected input size (Example : 224 x 224)
      img.Image resizedImage = img.copyResize(image, width : 224, height : 224);

      // Convert image to bytes format
      Uint8List inputBytes = Uint8List.fromList(resizedImage.getBytes());

      return inputBytes;
    }catch(e){
        print("Error processing image : $e");
        return null;
    }
  }


  void closeModel(){
    _interpreter?.close();
  }
}