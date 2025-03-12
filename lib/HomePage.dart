import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:objectdetection/services/tflite_inference.dart';
//import 'package:tflite_flutter/tflite_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Code Logic to Load an Image from Gallery
  File? _selectedImage;

  final TFLiteInference _tfLiteInference = TFLiteInference();

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tfLiteInference.closeModel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image Classifier')),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _selectedImage != null
                ? Image.file(
                  _selectedImage!,
                  height: 200,
                ) // show the selected image
                : const Text('No Image Selected'),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: _pickImage,
              child: const Text("Select Image"),
            ),

            // If an Image is selected, show the two buttons
            if (_selectedImage != null) ...[
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  print("Infer using Server API");
                },
                child: const Text("Infer Online (Server)"),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async{
                  print("Infer using TFLite Model");
                  await _tfLiteInference.loadModel();
                  print("Model Loaded sucessfully");

                  

                },
                child: const Text("Infer Offline (On-Mobile)"),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
